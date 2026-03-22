import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:patient_project/shared/theme/app_colors.dart';
import 'package:patient_project/shared/widgets/app_text.dart';

class AppScaffold extends StatelessWidget {
  final String? title;
  final Widget body;
  final List<Widget>? actions;
  final Widget? floatingActionButton;
  final Widget? bottomNavigationBar;
  final bool showAppBar;
  final bool resizeToAvoidBottomInset;
  final VoidCallback? onBack;
  final bool isLoading;

  const AppScaffold({
    super.key,
    required this.body,
    this.title,
    this.actions,
    this.floatingActionButton,
    this.bottomNavigationBar,
    this.showAppBar = true,
    this.resizeToAvoidBottomInset = true,
    this.onBack,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: resizeToAvoidBottomInset,
      floatingActionButton: floatingActionButton,
      bottomNavigationBar: bottomNavigationBar,
      appBar: showAppBar && title != null
          ? AppAppBar(title: title!, actions: actions, onBack: onBack)
          : null,
      body: SafeArea(
        child: Stack(
          children: [
            body,
            if (isLoading)
              const Positioned.fill(
                child: ColoredBox(
                  color: Colors.black26,
                  child: Center(child: CircularProgressIndicator()),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class AppAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget>? actions;
  final VoidCallback? onBack;

  const AppAppBar({
    super.key,
    required this.title,
    this.actions,
    this.onBack,
  });

  @override
  Size get preferredSize => Size.fromHeight(56.h);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.primary,
      leading: onBack != null
          ? IconButton(
              icon: const Icon(Icons.arrow_back_ios, color: AppColors.surface),
              onPressed: onBack,
            )
          : null,
      title: AppText.titleLarge(title, color: AppColors.surface),
      actions: actions,
    );
  }
}
