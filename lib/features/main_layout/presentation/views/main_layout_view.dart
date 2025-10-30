import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:your_sales/core/localization/s.dart';
import 'package:your_sales/core/shared_controllers/cubit/location_permission_cubit.dart';
import 'package:your_sales/core/shared_widgets/custom_modal_bottom_sheet.dart';
import 'package:your_sales/core/shared_widgets/svg_image_widget.dart';
import 'package:your_sales/core/theme/app_colors.dart';
import 'package:your_sales/features/main_layout/data/models/tab_item_model.dart';
import 'package:your_sales/features/main_layout/presentation/controllers/cubit/main_layout_cubit.dart';
import 'package:your_sales/features/main_layout/presentation/views/widgets/location_permission_sheet.dart';
import 'package:your_sales/features/my_app/controller/cubit/localization_cubit.dart';

class MainLayoutView extends StatefulWidget {
  const MainLayoutView({super.key});

  @override
  State<MainLayoutView> createState() => _MainLayoutViewState();
}

class _MainLayoutViewState extends State<MainLayoutView> {
  late final PageController _pageController;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  bool _isModalOpen = false;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<LocationPermissionCubit>().checkInitialPermission();
    });
  }

  void _showMandatoryPermissionModal() {
    if (_isModalOpen) return;

    setState(() {
      _isModalOpen = true;
    });

    showCustomModalBottomSheet<void>(
      context: context,
      child: const LocationPermissionSheet(),

      isDismissible: false,
      enableDrag: false,
      heightFactor: 0.65,
    ).then((_) {
      setState(() {
        _isModalOpen = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LocationPermissionCubit, LocationPermissionState>(
      listener: (context, state) {
        if (state is LocationPermissionDenied ||
            state is LocationPermissionPermanentlyDenied ||
            state is LocationPermissionServiceDisabled) {
          _showMandatoryPermissionModal();
        }

        if (state is LocationPermissionGranted) {
          if (_isModalOpen) {
            Navigator.pop(context);
          }
        }
      },
      builder: (context, state) {
        if (state is LocationPermissionGranted) {
          return BlocBuilder<LocalizationCubit, LocalizationState>(
            builder: (context, state) {
              Future.microtask(() {
                final s = S.of(context)!;
                context.read<MainLayoutCubit>().setTabs([
                  TabItemModel(
                    label: s.home,
                    icon: 'assets/images/svg/home.svg',
                    page: const SizedBox(),
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
        return const Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}
