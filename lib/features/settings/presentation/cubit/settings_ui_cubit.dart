import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'settings_ui_state.dart';
part 'settings_ui_cubit.freezed.dart';

/// Cubit for managing Settings Dialog UI state
/// Handles menu selection, dialog expansion, and other UI-only state
/// Separated from SettingsBloc to optimize rebuilds
class SettingsUICubit extends Cubit<SettingsUIState> {
  SettingsUICubit() : super(const SettingsUIState());

  /// Select a menu item
  void selectMenu(String menu) {
    emit(state.copyWith(selectedMenu: menu));
  }

  /// Toggle dialog expanded state
  void toggleExpanded() {
    emit(state.copyWith(isDialogExpanded: !state.isDialogExpanded));
  }

  /// Set search query
  void setSearchQuery(String? query) {
    emit(state.copyWith(searchQuery: query));
  }

  /// Mark settings as dirty (unsaved changes)
  void markDirty() {
    emit(state.copyWith(isDirty: true));
  }

  /// Mark settings as clean (all changes saved)
  void markClean() {
    emit(state.copyWith(isDirty: false));
  }

  /// Reset UI state to initial values
  void reset() {
    emit(const SettingsUIState());
  }
}
