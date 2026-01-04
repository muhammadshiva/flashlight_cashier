part of 'store_info_cubit.dart';

@freezed
class StoreInfoState with _$StoreInfoState {
  const factory StoreInfoState.initial() = _Initial;
  const factory StoreInfoState.loading() = _Loading;
  const factory StoreInfoState.loaded(StoreInfo storeInfo) = _Loaded;
  const factory StoreInfoState.error(String message) = _Error;
}
