import 'package:flashlight_pos/features/settings/data/models/get_store_info_params.dart';
import 'package:flashlight_pos/features/settings/domain/entities/store_info.dart';
import 'package:flashlight_pos/features/settings/domain/usecases/get_store_info.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'store_info_cubit.freezed.dart';
part 'store_info_state.dart';

/// Cubit for managing Store Information
class StoreInfoCubit extends Cubit<StoreInfoState> {
  final GetStoreInfo getStoreInfo;

  StoreInfoCubit({required this.getStoreInfo}) : super(const StoreInfoState.initial());

  /// Fetch store information from API or dummy data
  Future<void> fetchStoreInfo({bool isPrototype = false}) async {
    emit(const StoreInfoState.loading());

    final params = GetStoreInfoParams(isPrototype: isPrototype);
    final result = await getStoreInfo(params);

    result.fold(
      (failure) => emit(StoreInfoState.error(failure.toString())),
      (storeInfo) => emit(StoreInfoState.loaded(storeInfo)),
    );
  }
}
