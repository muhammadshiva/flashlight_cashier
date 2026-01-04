import 'package:freezed_annotation/freezed_annotation.dart';

part 'ui_state_model.freezed.dart';

@freezed
class UIStateModel<T> with _$UIStateModel<T> {
  const factory UIStateModel.success({required T data}) = UIStateModelSuccess<T>;
  const factory UIStateModel.empty({
    @Default('Maaf, saat ini data kamu tidak tersedia') String message,
  }) = UIStateModelEmpty<T>;
  const factory UIStateModel.loading() = UIStateModelLoading<T>;
  const factory UIStateModel.error({
    @Default('Terjadi Kesalahan, Silakan Coba Lagi') String message,
  }) = UIStateModelError<T>;
  const factory UIStateModel.idle() = UIStateModelIdle<T>;
}
