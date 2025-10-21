import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:your_sales/core/localization/s.dart';
import 'package:your_sales/core/responsive/responsive_config.dart';
import 'package:your_sales/core/theme/app_colors.dart';
import 'package:your_sales/core/theme/app_text_style.dart';
import 'package:your_sales/features/intro/onboarding/cubit/onboarding_cubit.dart';

class OnBoardingTitle extends StatelessWidget {
  const OnBoardingTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OnboardingCubit, int>(
      builder: (context, state) {
        return Align(
          alignment: Alignment.topCenter,
          child: Text(
            textAlign: TextAlign.center,
            context.read<OnboardingCubit>().onBoardingIndex == 0
                ? S.of(context)!.onboard1Title
                : context.read<OnboardingCubit>().onBoardingIndex == 1
                ? S.of(context)!.onboard2Title
                : S.of(context)!.onboard3Title,
            style: AppTextStyles.style20W700.copyWith(
              color: AppColors.primaryColor,
              fontSize: SizeConfig.responsiveValue(
                phone: 20.sp,
                tablet: 22.sp,
              ),
            ),
          ),
        );
      },
    );
  }
}

class OnBoardingText extends StatelessWidget {
  const OnBoardingText({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OnboardingCubit, int>(
      builder: (context, state) {
        return Align(
          alignment: Alignment.topCenter,
          child: Text(
            textAlign: TextAlign.center,
            context.read<OnboardingCubit>().onBoardingIndex == 0
                ? S.of(context)!.onboard1
                : context.read<OnboardingCubit>().onBoardingIndex == 1
                ? S.of(context)!.onboard2
                : S.of(context)!.onboard3,
            style: AppTextStyles.style20W400.copyWith(
              color: AppColors.secondaryColor,
              fontSize: SizeConfig.responsiveValue(
                phone: 16.sp,
                tablet: 18.sp,
              ),
            ),
          ),
        );
      },
    );
  }
}
