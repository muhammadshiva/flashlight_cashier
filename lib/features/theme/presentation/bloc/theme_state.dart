import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

/// State for the ThemeBloc.
class ThemeState extends Equatable {
  final ThemeMode themeMode;

  const ThemeState({
    this.themeMode = ThemeMode.system,
  });

  /// Returns true if dark mode is active.
  bool get isDarkMode => themeMode == ThemeMode.dark;

  /// Returns true if light mode is active.
  bool get isLightMode => themeMode == ThemeMode.light;

  /// Returns true if system theme is being used.
  bool get isSystemTheme => themeMode == ThemeMode.system;

  /// Creates a copy of this state with the given fields replaced.
  ThemeState copyWith({
    ThemeMode? themeMode,
  }) {
    return ThemeState(
      themeMode: themeMode ?? this.themeMode,
    );
  }

  /// Converts the state to JSON for persistence.
  Map<String, dynamic> toJson() {
    return {
      'themeMode': themeMode.index,
    };
  }

  /// Creates a state from JSON for restoration.
  factory ThemeState.fromJson(Map<String, dynamic> json) {
    return ThemeState(
      themeMode: ThemeMode.values[json['themeMode'] as int? ?? 0],
    );
  }

  @override
  List<Object?> get props => [themeMode];
}
