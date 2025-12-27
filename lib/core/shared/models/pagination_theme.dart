import 'package:flutter/material.dart';

/// Styling configuration untuk pagination
class PaginationTheme {
  final Color primaryColor;
  final Color backgroundColor;
  final Color textColor;
  final Color disabledColor;
  final Color borderColor;
  final Color shimmerBaseColor;
  final Color shimmerHighlightColor;
  final double borderRadius;
  final EdgeInsets padding;
  final TextStyle? textStyle;
  final BoxShadow? shadow;

  const PaginationTheme({
    required this.primaryColor,
    required this.backgroundColor,
    required this.textColor,
    required this.disabledColor,
    required this.borderColor,
    this.shimmerBaseColor = Colors.grey,
    this.shimmerHighlightColor = Colors.white,
    this.borderRadius = 4.0,
    this.padding = const EdgeInsets.all(16),
    this.textStyle,
    this.shadow,
  });
}
