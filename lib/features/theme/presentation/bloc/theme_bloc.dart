import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

import 'theme_event.dart';
import 'theme_state.dart';

/// BLoC for managing application theme with state persistence.
///
/// Uses HydratedBloc to automatically persist theme state across app restarts.
/// Supports light mode, dark mode, and system theme.
class ThemeBloc extends HydratedBloc<ThemeEvent, ThemeState> {
  ThemeBloc() : super(const ThemeState()) {
    on<ToggleTheme>(_onToggleTheme);
    on<SetThemeMode>(_onSetThemeMode);
    on<SetSystemTheme>(_onSetSystemTheme);
  }

  /// Handles toggle theme event.
  void _onToggleTheme(ToggleTheme event, Emitter<ThemeState> emit) {
    final newMode = state.isDarkMode ? ThemeMode.light : ThemeMode.dark;
    emit(state.copyWith(themeMode: newMode));
  }

  /// Handles set specific theme mode event.
  void _onSetThemeMode(SetThemeMode event, Emitter<ThemeState> emit) {
    emit(state.copyWith(themeMode: event.themeMode));
  }

  /// Handles set system theme event.
  void _onSetSystemTheme(SetSystemTheme event, Emitter<ThemeState> emit) {
    emit(state.copyWith(themeMode: ThemeMode.system));
  }

  @override
  ThemeState? fromJson(Map<String, dynamic> json) {
    try {
      return ThemeState.fromJson(json);
    } catch (e) {
      // Return default state if deserialization fails
      return const ThemeState();
    }
  }

  @override
  Map<String, dynamic>? toJson(ThemeState state) {
    try {
      return state.toJson();
    } catch (e) {
      // Return null if serialization fails
      return null;
    }
  }
}
