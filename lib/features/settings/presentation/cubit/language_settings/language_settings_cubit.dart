import 'package:equatable/equatable.dart';
import 'package:flashlight_pos/features/settings/presentation/bloc/settings_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'language_settings_state.dart';

/// Cubit for managing Language Settings Form
/// Handles form state, validation, and syncing with SettingsBloc
class LanguageSettingsCubit extends Cubit<LanguageSettingsState> {
  final SettingsBloc settingsBloc;

  LanguageSettingsCubit({required this.settingsBloc}) : super(LanguageSettingsState.initial()) {
    _initializeFromSettingsBloc();
  }

  /// Initialize form from current app settings in SettingsBloc
  void _initializeFromSettingsBloc() {
    final appSettings = settingsBloc.state.appSettings;
    if (appSettings != null) {
      emit(LanguageSettingsState(
        language: appSettings.language,
        isDirty: false,
        isSaving: false,
      ));
    }
  }

  /// Update language
  void updateLanguage(String language) {
    emit(state.copyWith(
      language: language,
      isDirty: true,
    ));
  }

  /// Save language settings to SettingsBloc
  Future<void> saveSettings() async {
    emit(state.copyWith(isSaving: true));

    // Dispatch event to SettingsBloc
    settingsBloc.add(UpdateLanguageSettings(
      language: state.language,
    ));

    // Wait a bit for SettingsBloc to process
    await Future.delayed(const Duration(milliseconds: 300));

    emit(state.copyWith(
      isSaving: false,
      isDirty: false,
    ));
  }

  /// Reset form to current app settings
  void reset() {
    _initializeFromSettingsBloc();
  }

  /// Discard changes
  void discardChanges() {
    _initializeFromSettingsBloc();
  }
}
