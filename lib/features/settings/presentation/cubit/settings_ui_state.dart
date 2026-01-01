part of 'settings_ui_cubit.dart';

@freezed
class SettingsUIState with _$SettingsUIState {
  const factory SettingsUIState({
    @Default('store_info') String selectedMenu,
    @Default(false) bool isDialogExpanded,
    String? searchQuery,
    @Default(false) bool isDirty,
  }) = _SettingsUIState;

  @override
  // TODO: implement isDialogExpanded
  bool get isDialogExpanded => throw UnimplementedError();

  @override
  // TODO: implement isDirty
  bool get isDirty => throw UnimplementedError();

  @override
  // TODO: implement searchQuery
  String? get searchQuery => throw UnimplementedError();

  @override
  // TODO: implement selectedMenu
  String get selectedMenu => throw UnimplementedError();
}
