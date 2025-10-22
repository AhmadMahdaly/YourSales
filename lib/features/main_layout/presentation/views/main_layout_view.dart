import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:your_sales/core/localization/s.dart';
import 'package:your_sales/core/shared_widgets/svg_image_widget.dart';
import 'package:your_sales/core/theme/app_colors.dart';
import 'package:your_sales/features/main_layout/data/models/tab_item_model.dart';
import 'package:your_sales/features/main_layout/presentation/controllers/cubit/main_layout_cubit.dart';
import 'package:your_sales/features/my_app/controller/cubit/localization_cubit.dart';

class MainLayoutView extends StatefulWidget {
  const MainLayoutView({super.key});

  @override
  State<MainLayoutView> createState() => _MainLayoutViewState();
}

class _MainLayoutViewState extends State<MainLayoutView> {
  late final PageController _pageController;
  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);
    // context.read<ServiceBloc>().add(const FetchServicesEvent());
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocalizationCubit, LocalizationState>(
      builder: (context, state) {
        // final localizationCubit = context.read<LocalizationCubit>();
        Future.microtask(() {
          final s = S.of(context)!;
          context.read<MainLayoutCubit>().setTabs([
            TabItemModel(
              label: s.home,
              icon: 'assets/images/svg/home.svg',
              page:
                  const SizedBox(), //HomeView(onPageChanged: context.read<MainLayoutCubit>().onPageChanged, pageController: _pageController,),
            ),
            TabItemModel(
              label: s.orders,
              icon: 'assets/images/svg/orders.svg',
              page: const SizedBox(),
            ),
            TabItemModel(
              label: s.wallet,
              icon: 'assets/images/svg/wallet.svg',
              page: const SizedBox(),
            ),
            TabItemModel(
              label: s.profile,
              icon: 'assets/images/svg/user.svg',
              page: const SizedBox(),
            ),
          ]);
        });
        return BlocBuilder<MainLayoutCubit, MainLayoutState>(
          builder: (context, state) {
            final cubit = context.read<MainLayoutCubit>();

            if (state.tabs.isEmpty) {
              return const Scaffold(
                body: Center(child: CircularProgressIndicator()),
              );
            }

            return Scaffold(
              // IconButton(
              //   onPressed: () async {
              //     final newLang = CacheHelper.getLanguage() == 'ar'
              //         ? 'en'
              //         : 'ar';
              //     await localizationCubit.changeLanguage(
              //       Locale(newLang),
              //     );
              // context.read<ServiceBloc>().add(
              //   const FetchServicesEvent(),
              // );
              //   },
              //   icon: const Icon(
              //     Icons.language_outlined,
              //     color: AppColors.primaryColor,
              //   ),
              // ),
              body: PageView(
                controller: _pageController,
                onPageChanged: cubit.onPageChanged,
                children: state.tabs.map((t) => t.page).toList(),
              ),
              bottomNavigationBar: BottomNavigationBar(
                currentIndex: state.currentIndex,
                onTap: (index) => cubit.goToPage(index, _pageController),
                selectedItemColor: AppColors.primaryColor,
                unselectedItemColor: DefaultSelectionStyle.defaultColor,
                type: BottomNavigationBarType.fixed,
                items: state.tabs.map((tab) {
                  final isActive =
                      state.tabs.indexOf(tab) == state.currentIndex;
                  return BottomNavigationBarItem(
                    icon: isActive
                        ? SvgImage(
                            imagePath: tab.icon,
                            color: AppColors.primaryColor,
                          )
                        : SvgImage(
                            imagePath: tab.icon,
                            color: DefaultSelectionStyle.defaultColor,
                          ),
                    label: tab.label,
                  );
                }).toList(),
              ),
            );
          },
        );
      },
    );
  }
}
