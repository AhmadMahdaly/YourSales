// ignore_for_file: cast_nullable_to_non_nullable

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:your_sales/core/constants.dart';
import 'package:your_sales/core/routing/app_routes.dart';
import 'package:your_sales/features/intro/onboarding/cubit/onboarding_cubit.dart';
import 'package:your_sales/features/intro/onboarding/onboarding_screen.dart';
import 'package:your_sales/features/intro/splash/splash_view.dart';
import 'package:your_sales/features/main_layout/presentation/controllers/cubit/main_layout_cubit.dart';
import 'package:your_sales/features/main_layout/presentation/views/main_layout_view.dart';

class RouterGenerationConfig {
  static GoRouter goRouter = GoRouter(
    navigatorKey: navigatorKey,
    initialLocation: AppRoutes.splashScreen,
    routes: [
      GoRoute(
        path: AppRoutes.splashScreen,
        name: AppRoutes.splashScreen,
        builder: (context, state) => const SplashView(),
      ),
      GoRoute(
        path: AppRoutes.onBoardingScreen,
        name: AppRoutes.onBoardingScreen,
        builder: (context, state) => BlocProvider<OnboardingCubit>(
          create: (context) => OnboardingCubit(),
          child: const OnBoardingScreen(),
        ),
      ),

      GoRoute(
        path: AppRoutes.mainlayoutScreen,
        name: AppRoutes.mainlayoutScreen,
        builder: (context, state) => BlocProvider<MainLayoutCubit>(
          create: (context) => MainLayoutCubit(),
          child: const MainLayoutView(),
        ),
      ),

      /// ------------- < >  -------------
      // GoRoute(
      //     path: AppRoutes.allCoursesScreen,
      //     name: AppRoutes.allCoursesScreen,
      //     builder: (context, state) {
      //       final args = state.extra! as Map<String, dynamic>;
      //       final title = args['title'] as String;
      //       final subject = args['items'] as List<Course>;
      //       final subscriptions = args['subscriptions'] as List<Subscription>;
      //       final currencySymbol = args['currencySymbol'] as String?;
      //       return BlocProvider<CartBloc>.value(
      //         value: getIt<CartBloc>(),
      //         child: AllContentScreen(
      //           items: subject,
      //           title: title,
      //           subscriptions: subscriptions,
      //           currencySymbol: currencySymbol,
      //         ),
      //       );
      //     },
      //   ),
    ],
  );
}
