import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:your_sales/core/cache_helper/cache_helper.dart';
import 'package:your_sales/core/cache_helper/cache_values.dart';
import 'package:your_sales/core/localization/s.dart';
import 'package:your_sales/core/responsive/responsive_config.dart';
import 'package:your_sales/core/routing/app_routes.dart';
import 'package:your_sales/core/shared_widgets/custom_primary_button.dart';
import 'package:your_sales/core/theme/app_colors.dart';
import 'package:your_sales/core/theme/app_images.dart';
import 'package:your_sales/core/theme/app_text_style.dart';
import 'package:your_sales/features/intro/onboarding/cubit/onboarding_cubit.dart';
import 'package:your_sales/features/intro/onboarding/widgets/app_journey_dot.dart';
import 'package:your_sales/features/intro/onboarding/widgets/onboarding_text.dart';
import 'package:your_sales/features/intro/onboarding/widgets/skip_button.dart';
import 'package:your_sales/features/my_app/controller/cubit/localization_cubit.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final PageController _pageController = PageController();
  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final localizationCubit = context.read<LocalizationCubit>();
    final s = S.of(context)!;
    return BlocBuilder<OnboardingCubit, int>(
      builder: (context, state) {
        final onboardingCubit = context.read<OnboardingCubit>();
        return Scaffold(
          backgroundColor: AppColors.primaryColor,
          body: SafeArea(
            bottom: false,
            child: Stack(
              fit: StackFit.expand,
              children: [
                Positioned(
                  bottom: 0,
                  right: 0,
                  left: 0,
                  child: Container(
                    height: SizeConfig.screenHeight / 2.3,
                    decoration: BoxDecoration(
                      color: AppColors.primaryColor,
                      borderRadius: BorderRadius.only(
                        bottomRight: CacheHelper.getLanguage() == 'en'
                            ? Radius.circular(100.r)
                            : Radius.zero,
                        bottomLeft: CacheHelper.getLanguage() == 'ar'
                            ? Radius.circular(100.r)
                            : Radius.zero,
                      ),
                    ),
                  ),
                ),

                PageView.builder(
                  controller: _pageController,
                  itemCount: 3,
                  // physics: const BouncingScrollPhysics(),
                  onPageChanged: onboardingCubit.setOnBoardingIndex,
                  itemBuilder: (context, index) {
                    final images = [
                      AppImages.onboard1,
                      AppImages.onboard2,
                      AppImages.onboard3,
                    ];

                    return Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.all(25.r),
                          child: CircleAvatar(
                            backgroundColor:
                                AppColors.scaffoldBackgroundLightColor,
                            radius: SizeConfig.screenWidth - 200.r,
                            child: Image.asset(
                              images[index],
                              fit: BoxFit.fill,
                              width: SizeConfig.screenWidth - 100.w,
                            ),
                          ),
                        ),
                        const Spacer(),
                        Container(
                          height: SizeConfig.screenHeight / 2.3,
                          decoration: const BoxDecoration(
                            color: AppColors.scaffoldBackgroundLightColor,
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 16.r),
                            child: Column(
                              children: [
                                60.verticalSpace,
                                const OnBoardingTitle(),
                                8.verticalSpace,
                                const OnBoardingText(),
                                50.verticalSpace,
                              ],
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),

                // Top bar
                Positioned(
                  top: 0,
                  right: 0,
                  left: 0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      if (onboardingCubit.onBoardingIndex != 2)
                        const SkipButton(),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 8.w,
                          vertical: 4.h,
                        ),
                        margin: EdgeInsets.symmetric(horizontal: 16.w),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4.r),
                          border: Border.all(
                            color: AppColors.lightBlueColor,
                            strokeAlign: BorderSide.strokeAlignOutside,
                          ),
                        ),
                        child: InkWell(
                          onTap: () async {
                            final newLang = CacheHelper.getLanguage() == 'ar'
                                ? 'en'
                                : 'ar';
                            await localizationCubit.changeLanguage(
                              Locale(newLang),
                            );
                          },
                          child: Text(
                            s.lang,
                            style: AppTextStyles.style16W600.copyWith(
                              color: AppColors.scaffoldBackgroundLightColor,
                              fontSize: SizeConfig.responsiveValue(
                                phone: 14.sp,
                                tablet: 16.sp,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // Bottom content
                Positioned(
                  bottom: SizeConfig.screenHeight / 2.5,
                  right: 0,
                  left: 0,
                  child: SizedBox(
                    height: 5.h,
                    child: CustomJourneyDot(
                      activeIndex: onboardingCubit.onBoardingIndex,
                      count: 3,
                    ),
                  ),
                ),

                Positioned(
                  bottom: 30.h,
                  right: 0,
                  left: 0,
                  child: Column(
                    children: [
                      CustomPrimaryButton(
                        width: 100.w,
                        text: onboardingCubit.onBoardingIndex == 2
                            ? s.exploreOurWork
                            : s.next,
                        onPressed: () {
                          if (onboardingCubit.onBoardingIndex == 2) {
                            CacheHelper.set(
                              CacheKeys.isFirstOpen,
                              true,
                            );
                            context.pushReplacementNamed(
                              AppRoutes.loginScreen,
                            );
                          } else {
                            _pageController.nextPage(
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.easeInOut,
                            );
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
