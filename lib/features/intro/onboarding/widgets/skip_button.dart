import 'package:flutter/material.dart';
import 'package:your_sales/core/cache_helper/cache_helper.dart';
import 'package:your_sales/core/cache_helper/cache_values.dart';
import 'package:your_sales/core/localization/s.dart';
import 'package:your_sales/core/responsive/responsive_config.dart';
import 'package:your_sales/core/theme/app_colors.dart';
import 'package:your_sales/core/theme/app_text_style.dart';

class SkipButton extends StatelessWidget {
  const SkipButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
      child: GestureDetector(
        onTap: () {
          // context.pushReplacementNamed(Routes.loginScreen);
          CacheHelper.set(CacheKeys.isFirstOpen, true);
        },
        child: Align(
          alignment: Alignment.topRight,
          child: Text(
            S.of(context)!.skip,
            style: AppTextStyles.style16W500.copyWith(
              color: AppColors.scaffoldBackgroundLightColor,
              fontSize: SizeConfig.responsiveValue(phone: 12.sp, tablet: 16.sp),
            ),
          ),
        ),
      ),
    );
  }
}
