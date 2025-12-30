import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

/// Events for the ThemeBloc.
abstract class ThemeEvent extends Equatable {
  const ThemeEvent();

  @override
  List<Object?> get props => [];
}

/// Event to toggle between light and dark theme.
class ToggleTheme extends ThemeEvent {
  const ToggleTheme();
}

/// Event to set a specific theme mode.
class SetThemeMode extends ThemeEvent {
  final ThemeMode themeMode;

  const SetThemeMode(this.themeMode);

  @override
  List<Object?> get props => [themeMode];
}

/// Event to set theme to follow system settings.
class SetSystemTheme extends ThemeEvent {
  const SetSystemTheme();
}
