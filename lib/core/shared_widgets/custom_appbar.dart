import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:your_sales/core/responsive/responsive_config.dart';
import 'package:your_sales/core/theme/app_colors.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    required this.title,
    this.isLeading = false,
    super.key,
    this.actions,
    this.titleWidget,
    this.leading,
  });
  @override
  Size get preferredSize => Size.fromHeight(80.h);

  final String title;
  final bool isLeading;
  final List<Widget>? actions;
  final Widget? titleWidget;
  final Widget? leading;
  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      toolbarHeight: 80.h,
      actions: actions,
      automaticallyImplyLeading: false,
      title: titleWidget ?? Text(title),
      leading: isLeading
          ? IconButton(
              onPressed: () => context.pop(),
              icon: const Icon(Icons.arrow_back_ios_new_rounded),
            )
          : leading,
      shape: OutlineInputBorder(
        borderSide: const BorderSide(
          color: AppColors.primaryColor,
          width: 0.7,
        ),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(15.r),
          bottomRight: Radius.circular(15.r),
        ),
      ),
    );
  }
}
