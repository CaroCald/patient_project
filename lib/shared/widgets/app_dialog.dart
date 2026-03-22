import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:patient_project/shared/theme/app_colors.dart';
import 'package:patient_project/shared/widgets/app_button.dart';
import 'package:patient_project/shared/widgets/app_spacing.dart';
import 'package:patient_project/shared/widgets/app_text.dart';

class AppDialog extends StatelessWidget {
  final String title;
  final String message;
  final String confirmLabel;
  final String? cancelLabel;
  final VoidCallback onConfirm;
  final VoidCallback? onCancel;
  final bool isDestructive;

  const AppDialog({
    super.key,
    required this.title,
    required this.message,
    required this.confirmLabel,
    required this.onConfirm,
    this.cancelLabel,
    this.onCancel,
    this.isDestructive = false,
  });

  static Future<void> show(
    BuildContext context, {
    required String title,
    required String message,
    required String confirmLabel,
    required VoidCallback onConfirm,
    String? cancelLabel,
    VoidCallback? onCancel,
    bool isDestructive = false,
  }) {
    return showDialog(
      context: context,
      builder: (_) => AppDialog(
        title: title,
        message: message,
        confirmLabel: confirmLabel,
        onConfirm: onConfirm,
        cancelLabel: cancelLabel,
        onCancel: onCancel,
        isDestructive: isDestructive,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
      title: AppText.titleLarge(title),
      content: AppText.bodyMedium(message),
      actions: [
        if (cancelLabel != null)
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              onCancel?.call();
            },
            child: AppText.bodyLarge(
              cancelLabel!,
              color: AppColors.textSecondary,
            ),
          ),
        SizedBox(
          width: 120.w,
          child: AppButton(
            label: confirmLabel,
            onPressed: () {
              Navigator.of(context).pop();
              onConfirm();
            },
          ),
        ),
        gapW8,
      ],
    );
  }
}
