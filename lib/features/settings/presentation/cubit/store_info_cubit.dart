import 'package:flashlight_pos/features/settings/data/models/get_store_info_params.dart';
import 'package:flashlight_pos/features/settings/domain/entities/store_info.dart';
import 'package:flashlight_pos/features/settings/domain/usecases/get_store_info.dart';
import 'package:flashlight_pos/shared/models/ui_state_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Cubit for managing Store Information
class StoreInfoCubit extends Cubit<UIStateModel<StoreInfo>> {
  final GetStoreInfo getStoreInfo;

  StoreInfoCubit({required this.getStoreInfo}) : super(const UIStateModel.idle());

  /// Fetch store information from API or dummy data
  Future<void> fetchStoreInfo({bool isPrototype = false}) async {
    emit(const UIStateModel.loading());

    final params = GetStoreInfoParams(isPrototype: isPrototype);
    final result = await getStoreInfo(params);

    result.fold(
      (failure) => emit(UIStateModel.error(message: failure.toString())),
      (storeInfo) => emit(UIStateModel.success(data: storeInfo)),
    );
  }
}
