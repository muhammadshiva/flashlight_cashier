import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/network/network_info.dart';
import '../../../../core/pagination/pagination_params.dart';
import '../../../../core/pagination/paginated_response.dart';
import '../../../../core/utils/repository_helper.dart';
import '../../domain/entities/customer.dart';
import '../../domain/repositories/customer_repository.dart';
import '../datasources/customer_local_data_source.dart';
import '../datasources/customer_remote_data_source.dart';
import '../models/customer_model.dart';

/// Implementation of [CustomerRepository] that handles customer operations
/// with offline support.
///
/// Uses:
/// - [NetworkInfo] to check connectivity before making API calls
/// - [CustomerLocalDataSource] for local caching with Hive
/// - [CustomerRemoteDataSource] for API calls
/// - [RepositoryHelper] for consistent error handling
///
/// Strategy:
/// - Get Customers: Network-first, cache on success, fallback to cache when offline
/// - Get Customer: Network-first, cache on success, fallback to cache when offline
/// - Create/Update/Delete: Requires network (data integrity)
class CustomerRepositoryImpl implements CustomerRepository {
  final CustomerRemoteDataSource remoteDataSource;
  final CustomerLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  CustomerRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, PaginatedResponse<Customer>>> getCustomers({
    PaginationParams? pagination,
    String? query,
  }) async {
    // Check network connectivity
    if (await networkInfo.isConnected) {
      // Online: Fetch from remote
      return RepositoryHelper.safeApiCall(
        () async {
          final result = await remoteDataSource.getCustomers(
            pagination: pagination,
            query: query,
          );

          // Convert models to entities
          final customers = result.data.map((model) => model.toEntity()).toList();

          // Cache the customers (only first page without query for simplicity)
          if ((pagination == null || pagination.page == 1) && (query == null || query.isEmpty)) {
            await localDataSource.cacheCustomers(customers);
          }

          return result.toEntity((model) => model.toEntity());
        },
      );
    } else {
      // Offline: Try to return cached data
      try {
        final cachedCustomers = await localDataSource.getCachedCustomers();

        if (cachedCustomers.isEmpty) {
          return const Left(NoCachedDataFailure('Tidak ada data customer tersimpan'));
        }

        // Filter by query if present
        var filteredCustomers = cachedCustomers;
        if (query != null && query.isNotEmpty) {
          final lowercaseQuery = query.toLowerCase();
          filteredCustomers = cachedCustomers.where((customer) {
            return customer.name.toLowerCase().contains(lowercaseQuery) ||
                customer.phoneNumber.contains(lowercaseQuery) ||
                customer.email.toLowerCase().contains(lowercaseQuery);
          }).toList();
        }

        // Apply pagination
        final page = pagination?.page ?? 1;
        final limit = pagination?.limit ?? 10;
        final offset = pagination?.offset ?? 0;

        final total = filteredCustomers.length;
        final totalPages = (total / limit).ceil();
        final startIndex = ((page - 1) * limit) + offset;
        final endIndex = (startIndex + limit).clamp(0, total);

        final paginatedData = filteredCustomers.sublist(
          startIndex.clamp(0, total),
          endIndex,
        );

        return Right(PaginatedResponse<Customer>(
          data: paginatedData,
          total: total,
          page: page,
          limit: limit,
          totalPages: totalPages,
        ));
      } catch (e) {
        return Left(CacheFailure(e.toString()));
      }
    }
  }

  @override
  Future<Either<Failure, Customer>> getCustomer(String id) async {
    // Check network connectivity
    if (await networkInfo.isConnected) {
      // Online: Fetch from remote
      return RepositoryHelper.safeApiCall(
        () async {
          final result = await remoteDataSource.getCustomer(id);
          final customer = result.toEntity();

          // Cache the customer
          await localDataSource.cacheCustomer(customer);

          return customer;
        },
      );
    } else {
      // Offline: Try to return cached data
      try {
        final cachedCustomer = await localDataSource.getCachedCustomer(id);

        if (cachedCustomer == null) {
          return const Left(NoCachedDataFailure('Customer tidak ditemukan di cache'));
        }

        return Right(cachedCustomer);
      } catch (e) {
        return Left(CacheFailure(e.toString()));
      }
    }
  }

  @override
  Future<Either<Failure, Customer>> createCustomer(Customer customer) async {
    return RepositoryHelper.safeApiCallWithNetworkCheck(
      networkInfo,
      () async {
        final customerModel = CustomerModel(
          id: customer.id,
          name: customer.name,
          phoneNumber: customer.phoneNumber,
          email: customer.email,
        );
        final result = await remoteDataSource.createCustomer(customerModel);
        final createdCustomer = result.toEntity();

        // Cache the new customer
        await localDataSource.cacheCustomer(createdCustomer);

        return createdCustomer;
      },
    );
  }

  @override
  Future<Either<Failure, Customer>> updateCustomer(Customer customer) async {
    return RepositoryHelper.safeApiCallWithNetworkCheck(
      networkInfo,
      () async {
        final customerModel = CustomerModel(
          id: customer.id,
          name: customer.name,
          phoneNumber: customer.phoneNumber,
          email: customer.email,
        );
        final result = await remoteDataSource.updateCustomer(customerModel);
        final updatedCustomer = result.toEntity();

        // Update cache
        await localDataSource.cacheCustomer(updatedCustomer);

        return updatedCustomer;
      },
    );
  }

  @override
  Future<Either<Failure, void>> deleteCustomer(String id) async {
    return RepositoryHelper.safeApiCallWithNetworkCheck(
      networkInfo,
      () async {
        await remoteDataSource.deleteCustomer(id);

        // Remove from cache
        await localDataSource.removeCustomer(id);

        return;
      },
    );
  }

  /// Clears all cached customer data.
  Future<void> clearCache() async {
    await localDataSource.clearCache();
  }

  /// Checks if customer cache is valid.
  Future<bool> isCacheValid() async {
    return await localDataSource.isCacheValid();
  }
}
