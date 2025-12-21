import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../config/constans/text_styles_const.dart';
import '../../../../config/themes/app_colors.dart';
import '../../../../core/utils/currency_formatter.dart';
import '../../../../injection_container.dart';
import '../bloc/service_bloc.dart';

class ServiceListPage extends StatelessWidget {
  const ServiceListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<ServiceBloc>()..add(LoadServices()),
      child: Scaffold(
        backgroundColor: AppColors.dashboardBackground,
        appBar: AppBar(
          title: Text('Layanan', style: TextStyleConst.poppinsSemiBold20),
          backgroundColor: AppColors.white,
          foregroundColor: AppColors.blackText900,
          elevation: 0,
          actions: [
            IconButton(
              icon: const Icon(Icons.add, color: AppColors.dashboardBlue),
              onPressed: () => context.push('/services/new'),
            ),
          ],
        ),
        body: BlocConsumer<ServiceBloc, ServiceState>(
          listener: (context, state) {
            // Show snackbar on error
            if (state is ServiceError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                  backgroundColor: AppColors.error600,
                  action: SnackBarAction(
                    label: 'Retry',
                    textColor: AppColors.white,
                    onPressed: () {
                      context.read<ServiceBloc>().add(LoadServices());
                    },
                  ),
                ),
              );
            }
          },
          builder: (context, state) {
            if (state is ServiceLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is ServiceLoaded) {
              return _buildServicesContent(context, state);
            }
            return const Center(child: Text('Tidak ada data'));
          },
        ),
      ),
    );
  }

  Widget _buildServicesContent(BuildContext context, ServiceLoaded state) {
    return RefreshIndicator(
      onRefresh: () async {
        context.read<ServiceBloc>().add(LoadServices());
        await Future.delayed(const Duration(milliseconds: 500));
      },
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.all(32.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Page Title
            Text(
              'Daftar Layanan',
              style: TextStyleConst.poppinsBold24.copyWith(color: AppColors.blackText900),
            ),
            const SizedBox(height: 8),
            Text(
              'Kelola semua layanan yang tersedia untuk pencucian motor',
              style: TextStyleConst.poppinsRegular14.copyWith(color: AppColors.textGray3),
            ),
            const SizedBox(height: 24),

            // Search Bar
            TextField(
              onChanged: (value) {
                // TODO: Implement search functionality
              },
              decoration: InputDecoration(
                hintText: 'Cari layanan...',
                hintStyle: TextStyleConst.poppinsRegular14.copyWith(color: AppColors.textGray3),
                prefixIcon: const Icon(Icons.search, color: AppColors.textGray3),
                filled: true,
                fillColor: AppColors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: AppColors.borderGray),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: AppColors.borderGray),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: AppColors.dashboardBlue, width: 2),
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Services Grid
            if (state.services.isEmpty)
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(48.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.miscellaneous_services_outlined,
                        size: 64,
                        color: AppColors.textGray3.withValues(alpha: 0.5),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Tidak ada layanan',
                        style:
                            TextStyleConst.poppinsSemiBold18.copyWith(color: AppColors.textGray3),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Tambahkan layanan baru untuk memulai',
                        style: TextStyleConst.poppinsRegular14.copyWith(color: AppColors.textGray3),
                      ),
                    ],
                  ),
                ),
              )
            else
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 1.2,
                ),
                itemCount: state.services.length,
                itemBuilder: (context, index) {
                  final service = state.services[index];
                  return _buildServiceCard(context, service, index);
                },
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildServiceCard(BuildContext context, dynamic service, int index) {
    // Determine if service is favorite or default
    bool isFavorite = service.isFavorite ?? false;
    bool isDefault = service.isDefault ?? false;

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Service Type Badge
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: _getServiceTypeColor(service.type),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    service.type.toUpperCase(),
                    style: TextStyleConst.poppinsMedium10.copyWith(
                      color: AppColors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const Spacer(),
                if (isFavorite) const Icon(Icons.star, color: Colors.amber, size: 16),
                if (isDefault)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: AppColors.dashboardBlue,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      'Default',
                      style: TextStyleConst.poppinsMedium10.copyWith(
                        color: AppColors.white,
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 12),

            // Service Name
            Text(
              service.name,
              style: TextStyleConst.poppinsSemiBold18.copyWith(color: AppColors.blackText900),
            ),
            const SizedBox(height: 8),

            // Service Description
            Text(
              service.description,
              style: TextStyleConst.poppinsRegular14.copyWith(color: AppColors.textGray3),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 16),

            // Price and Actions
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Harga',
                      style: TextStyleConst.poppinsRegular12.copyWith(color: AppColors.textGray3),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      CurrencyFormatter.format(service.price),
                      style: TextStyleConst.poppinsBold20.copyWith(color: AppColors.dashboardGreen),
                    ),
                  ],
                ),
                Row(
                  children: [
                    // Edit Button
                    OutlinedButton.icon(
                      onPressed: () {
                        context.push('/services/${service.id}/edit');
                      },
                      icon: const Icon(Icons.edit, size: 18),
                      label: const Text('Edit'),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        foregroundColor: AppColors.dashboardBlue,
                        side: const BorderSide(color: AppColors.dashboardBlue),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    // Delete Button
                    IconButton(
                      onPressed: () {
                        _showDeleteConfirmation(context, service);
                      },
                      icon: const Icon(Icons.delete, color: AppColors.error600, size: 20),
                      style: IconButton.styleFrom(
                        backgroundColor: AppColors.error50,
                        padding: const EdgeInsets.all(8),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Color _getServiceTypeColor(String type) {
    switch (type.toLowerCase()) {
      case 'washing':
        return AppColors.dashboardBlue;
      case 'detailing':
        return AppColors.dashboardGreen;
      case 'engine':
        return AppColors.warning600;
      case 'protection':
        return AppColors.warning600;
      case 'cleaning':
        return AppColors.dashboardGreen;
      default:
        return AppColors.textGray3;
    }
  }

  void _showDeleteConfirmation(BuildContext context, dynamic service) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(
          'Hapus Layanan',
          style: TextStyleConst.poppinsSemiBold18.copyWith(color: AppColors.blackText900),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Apakah Anda yakin ingin menghapus layanan ini?',
              style: TextStyleConst.poppinsRegular14.copyWith(color: AppColors.textGray3),
            ),
            const SizedBox(height: 12),
            Text(
              service.name,
              style: TextStyleConst.poppinsSemiBold16.copyWith(color: AppColors.blackText900),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: Text(
              'Batal',
              style: TextStyleConst.poppinsMedium14.copyWith(color: AppColors.textGray3),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(dialogContext);
              context.read<ServiceBloc>().add(DeleteServiceEvent(service.id));
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.error600,
              foregroundColor: AppColors.white,
            ),
            child: Text(
              'Hapus',
              style: TextStyleConst.poppinsMedium14,
            ),
          ),
        ],
      ),
    );
  }
}
