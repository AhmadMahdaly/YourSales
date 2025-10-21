import 'package:flutter/material.dart';
import 'package:your_sales/core/responsive/responsive_config.dart';
import 'package:your_sales/core/theme/app_colors.dart';

class CustomJourneyDot extends StatelessWidget {
  const CustomJourneyDot({
    required this.activeIndex,
    required this.count,
    super.key,
  });
  final int activeIndex;
  final int count;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: count,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 4.w),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 500),
              height: 6.h,
              width: activeIndex == index ? 22.w : 5.w,
              decoration: BoxDecoration(
                color: activeIndex == index
                    ? AppColors.primaryColor
                    : AppColors.grayColor,
                borderRadius: BorderRadius.circular(15.w),
              ),
            ),
          );
        },
      ),
    );
  }
}
