import 'package:flutter/material.dart';
import 'package:your_sales/core/responsive/responsive_config.dart';
import 'package:your_sales/core/theme/app_colors.dart';
import 'package:your_sales/core/theme/app_text_style.dart';

Future<T?> showCustomModalBottomSheet<T>({
  required BuildContext context,
  required Widget child,
  String? title,
  bool isDismissible = true,
  bool enableDrag = true,
  double? heightFactor, // لتحديد نسبة الارتفاع
}) {
  return showModalBottomSheet<T>(
    context: context,
    isScrollControlled: true,
    isDismissible: isDismissible,
    enableDrag: enableDrag,
    backgroundColor: Colors.transparent,
    builder: (_) {
      return FractionallySizedBox(
        heightFactor: heightFactor ?? 0.6, // الافتراضي 60% من الشاشة
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.scaffoldBackgroundLightColor,
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(16.r),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withAlpha(33),
                blurRadius: 8,
                offset: const Offset(0, -2),
              ),
            ],
          ),
          child: Padding(
            padding: EdgeInsets.only(
              left: 16.w,
              right: 16.w,
              top: 12.h,
              bottom: MediaQuery.of(context).viewInsets.bottom + 12.h,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // شريط السحب العلوي
                Container(
                  width: 40.w,
                  height: 5.h,
                  decoration: BoxDecoration(
                    color: AppColors.unfocusBorderColor,
                    borderRadius: BorderRadius.circular(100.r),
                  ),
                ),
                SizedBox(height: 12.h),
                // العنوان إن وجد
                if (title != null) ...[
                  Text(
                    title,
                    style: AppTextStyles.style16W600.copyWith(
                      color: AppColors.primaryColor,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  const Divider(height: 1),
                  SizedBox(height: 12.h),
                ],
                // المحتوى الممرر
                Expanded(
                  child: SingleChildScrollView(
                    child: child,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}
