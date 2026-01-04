part of 'settings_ui_cubit.dart';

class SettingsUIState extends Equatable {
  final String selectedMenu;
  final bool isDialogExpanded;
  final String? searchQuery;
  final bool isDirty;

  const SettingsUIState({
    this.selectedMenu = 'store_info',
    this.isDialogExpanded = false,
    this.searchQuery,
    this.isDirty = false,
  });

  @override
  List<Object?> get props => [selectedMenu, isDialogExpanded, searchQuery, isDirty];

  SettingsUIState copyWith({
    String? selectedMenu,
    bool? isDialogExpanded,
    String? searchQuery,
    bool? isDirty,
  }) {
    return SettingsUIState(
      selectedMenu: selectedMenu ?? this.selectedMenu,
      isDialogExpanded: isDialogExpanded ?? this.isDialogExpanded,
      searchQuery: searchQuery ?? this.searchQuery,
      isDirty: isDirty ?? this.isDirty,
    );
  }
}
