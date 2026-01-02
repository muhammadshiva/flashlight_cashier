import 'package:flashlight_pos/config/themes/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Reusable dialog for text input editing
///
/// Prevents keyboard from covering input field by using a dialog
/// that automatically adjusts to keyboard visibility
class TextEditDialog extends StatefulWidget {
  final String title;
  final String? description;
  final String initialValue;
  final int maxLines;
  final String? hintText;

  const TextEditDialog({
    super.key,
    required this.title,
    this.description,
    required this.initialValue,
    this.maxLines = 1,
    this.hintText,
  });

  /// Show the dialog and return the edited value
  /// Returns null if cancelled
  static Future<String?> show({
    required BuildContext context,
    required String title,
    String? description,
    required String initialValue,
    int maxLines = 1,
    String? hintText,
  }) {
    return showDialog<String>(
      context: context,
      builder: (context) => TextEditDialog(
        title: title,
        description: description,
        initialValue: initialValue,
        maxLines: maxLines,
        hintText: hintText,
      ),
    );
  }

  @override
  State<TextEditDialog> createState() => _TextEditDialogState();
}

class _TextEditDialogState extends State<TextEditDialog> {
  late final TextEditingController _controller;
  late final FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialValue);
    _focusNode = FocusNode();

    // Auto-focus the text field when dialog opens
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _focusNode.requestFocus();
      // Select all text for easy replacement
      _controller.selection = TextSelection(
        baseOffset: 0,
        extentOffset: _controller.text.length,
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _save() {
    Navigator.of(context).pop(_controller.text);
  }

  void _cancel() {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title
                Text(
                  widget.title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: AppColors.blackFoundation600,
                  ),
                ),

                if (widget.description != null) ...[
                  8.verticalSpace,
                  Text(
                    widget.description!,
                    style: const TextStyle(
                      fontSize: 13,
                      color: AppColors.textGray2,
                    ),
                  ),
                ],

                16.verticalSpace,

                // TextField
                TextField(
                  controller: _controller,
                  focusNode: _focusNode,
                  maxLines: widget.maxLines,
                  style: const TextStyle(
                    fontSize: 14,
                    color: AppColors.blackFoundation600,
                  ),
                  decoration: InputDecoration(
                    hintText: widget.hintText,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(color: AppColors.borderGray),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(color: AppColors.borderGray),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(color: AppColors.orangePrimary, width: 2),
                    ),
                  ),
                  onSubmitted: (_) => _save(),
                ),

                24.verticalSpace,

                // Actions
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: _cancel,
                      child: const Text(
                        'Cancel',
                        style: TextStyle(
                          color: AppColors.textGray2,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    12.horizontalSpace,
                    ElevatedButton(
                      onPressed: _save,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.orangeAccent,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                      ),
                      child: const Text(
                        'Save',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
