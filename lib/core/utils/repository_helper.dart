import 'package:dartz/dartz.dart';
import '../error/failures.dart';

class RepositoryHelper {
  static Future<Either<Failure, T>> safeApiCall<T>(
      Future<T> Function() apiCall) async {
    try {
      final result = await apiCall();
      return Right(result);
    } on Failure catch (e) {
      return Left(e);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
