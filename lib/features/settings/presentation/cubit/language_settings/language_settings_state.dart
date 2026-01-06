part of 'language_settings_cubit.dart';

/// State for Language Settings Form
class LanguageSettingsState extends Equatable {
  final String language;
  final bool isDirty; // Track if form has unsaved changes
  final bool isSaving; // Track if save is in progress

  const LanguageSettingsState({
    required this.language,
    this.isDirty = false,
    this.isSaving = false,
  });

  factory LanguageSettingsState.initial() {
    return const LanguageSettingsState(
      language: 'id_ID',
      isDirty: false,
      isSaving: false,
    );
  }

  LanguageSettingsState copyWith({
    String? language,
    bool? isDirty,
    bool? isSaving,
  }) {
    return LanguageSettingsState(
      language: language ?? this.language,
      isDirty: isDirty ?? this.isDirty,
      isSaving: isSaving ?? this.isSaving,
    );
  }

  @override
  List<Object?> get props => [language, isDirty, isSaving];
}
