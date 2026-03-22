import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:patient_project/shared/theme/app_colors.dart';

class AppText extends StatelessWidget {
  final String text;
  final double fontSize;
  final FontWeight fontWeight;
  final Color color;
  final TextAlign textAlign;
  final int? maxLines;
  final TextOverflow? overflow;

  const AppText(
    this.text, {
    super.key,
    this.fontSize = 14,
    this.fontWeight = FontWeight.normal,
    this.color = AppColors.textPrimary,
    this.textAlign = TextAlign.start,
    this.maxLines,
    this.overflow,
  });

  const AppText.headlineLarge(
    this.text, {
    super.key,
    this.fontWeight = FontWeight.bold,
    this.color = AppColors.textPrimary,
    this.textAlign = TextAlign.start,
    this.maxLines,
    this.overflow,
  }) : fontSize = 28;

  const AppText.headlineMedium(
    this.text, {
    super.key,
    this.fontWeight = FontWeight.bold,
    this.color = AppColors.textPrimary,
    this.textAlign = TextAlign.start,
    this.maxLines,
    this.overflow,
  }) : fontSize = 22;

  const AppText.titleLarge(
    this.text, {
    super.key,
    this.fontWeight = FontWeight.w600,
    this.color = AppColors.textPrimary,
    this.textAlign = TextAlign.start,
    this.maxLines,
    this.overflow,
  }) : fontSize = 18;

  const AppText.bodyLarge(
    this.text, {
    super.key,
    this.fontWeight = FontWeight.normal,
    this.color = AppColors.textPrimary,
    this.textAlign = TextAlign.start,
    this.maxLines,
    this.overflow,
  }) : fontSize = 16;

  const AppText.bodyMedium(
    this.text, {
    super.key,
    this.fontWeight = FontWeight.normal,
    this.color = AppColors.textSecondary,
    this.textAlign = TextAlign.start,
    this.maxLines,
    this.overflow,
  }) : fontSize = 14;

  const AppText.caption(
    this.text, {
    super.key,
    this.fontWeight = FontWeight.normal,
    this.color = AppColors.textSecondary,
    this.textAlign = TextAlign.start,
    this.maxLines,
    this.overflow,
  }) : fontSize = 12;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
      style: TextStyle(
        fontSize: fontSize.sp,
        fontWeight: fontWeight,
        color: color,
      ),
    );
  }
}
