import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:your_sales/core/responsive/responsive_config.dart';
import 'package:your_sales/core/shared_controllers/cubit/location_permission_cubit.dart';
import 'package:your_sales/core/theme/app_colors.dart';
import 'package:your_sales/core/theme/app_text_style.dart';

class LocationPermissionSheet extends StatelessWidget {
  const LocationPermissionSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocationPermissionCubit, LocationPermissionState>(
      builder: (context, state) {
        var title = 'السماح بتحديد الموقع';
        var body = 'من فضلك قم بتفعيل السماح الوصول إلى موقعك لتحديد موقعك';
        var buttonText = 'السماح بتحديد الموقع';
        var onPressed = () {
          context.read<LocationPermissionCubit>().requestPermission();
        };

        if (state is LocationPermissionPermanentlyDenied) {
          title = 'الصلاحية مرفوضة نهائياً';
          body =
              'يرجى تفعيل الصلاحية يدوياً من إعدادات التطبيق للتمكن من تحديد موقعك.';
          buttonText = 'الانتقال إلى الإعدادات';
          onPressed = () {
            context.read<LocationPermissionCubit>().openAppSettings();
          };
        } else if (state is LocationPermissionServiceDisabled) {
          title = 'خدمة الموقع (GPS) معطلة';
          body =
              'يرجى تفعيل خدمة تحديد المواقع (GPS) على جهازك والمحاولة مرة أخرى.';
          buttonText = 'حاول مرة أخرى';
        }

        return Padding(
          padding: EdgeInsets.all(16.r),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.pop(context),
                  color: AppColors.primaryColor,
                ),
              ),

              Text(
                title,
                style: AppTextStyles.style16W600.copyWith(
                  color: AppColors.primaryColor,
                ),
              ),
              24.verticalSpace,

              Icon(
                Icons.location_on_rounded,
                size: 100.r,
                color: AppColors.primaryColor,
              ),
              24.verticalSpace,

              Text(
                body,
                textAlign: TextAlign.center,
                style: AppTextStyles.style14W400.copyWith(
                  color: AppColors.forthColor,
                ),
              ),
              32.verticalSpace,

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: onPressed,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryColor,
                    padding: EdgeInsets.symmetric(vertical: 16.h),
                  ),
                  child: state is LocationPermissionLoading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : Text(
                          buttonText,
                          style: AppTextStyles.style16W600.copyWith(
                            color: Colors.white,
                          ),
                        ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
