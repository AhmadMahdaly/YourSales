import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:your_sales/core/functions/text_input_formatter_utils.dart';
import 'package:your_sales/core/localization/s.dart';
import 'package:your_sales/core/responsive/responsive_config.dart';
import 'package:your_sales/core/routing/app_routes.dart';
import 'package:your_sales/core/shared_widgets/custom_primary_button.dart';
import 'package:your_sales/core/theme/app_colors.dart';
import 'package:your_sales/core/theme/app_text_style.dart';

class OtpVerificationView extends StatefulWidget {
  const OtpVerificationView({required this.email, super.key});
  final String email;

  @override
  State<OtpVerificationView> createState() => _OtpVerificationViewState();
}

class _OtpVerificationViewState extends State<OtpVerificationView> {
  final _formKey = GlobalKey<FormState>();
  final _otpController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final s = S.of(context)!;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          s.verificationCode,
          style: AppTextStyles.style20Bold.copyWith(fontSize: 20.sp),
        ),
        leading: IconButton(
          onPressed: () => context.pop(),
          icon: const Icon(Icons.arrow_back_ios_new_outlined),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.r),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              PinCodeTextField(
                keyboardType: TextInputType.number,
                inputFormatters: TextInputFormatterUtils.numbersOnly,
                appContext: context,
                length: 4,
                controller: _otpController,
                // onCompleted: (value) =>
                //     value.length != 6 ? s.invalidOtp : null,
                pinTheme: PinTheme(
                  borderRadius: BorderRadius.circular(14.r),
                  shape: PinCodeFieldShape.box,
                  fieldHeight: 54.h,
                  fieldWidth: 74.w,
                  activeBorderWidth: 2,
                  inactiveBorderWidth: 1,
                  activeColor: AppColors.primaryColor,
                  inactiveColor: AppColors.secondaryColor,
                  selectedColor: AppColors.primaryColor,
                ),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const _CustomTimerWidget(),
                  20.horizontalSpace,
                  Expanded(child: Text(s.weSendVerificationCodeToYourEmail)),
                ],
              ),

              60.verticalSpace,
              CustomPrimaryButton(
                onPressed: () {
                  // if (_formKey.currentState!.validate()) {
                  context.push(AppRoutes.newPasswordView, extra: widget.email);
                  // }
                },
                text: s.verify,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CustomTimerWidget extends StatefulWidget {
  const _CustomTimerWidget();

  @override
  State<_CustomTimerWidget> createState() => _CustomTimerWidgetState();
}

class _CustomTimerWidgetState extends State<_CustomTimerWidget> {
  @override
  void initState() {
    startTimer();
    super.initState();
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  Timer? timer;
  int timeLeft = 30;
  bool isButtonDisabled = true;

  void startTimer() {
    timeLeft = 30;
    isButtonDisabled = true;

    timer?.cancel();
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!mounted) return;

      if (timeLeft > 0) {
        timeLeft--;
        setState(() {});
      } else {
        isButtonDisabled = false;
        timer.cancel();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final s = S.of(context)!;
    return InkWell(
      onTap: isButtonDisabled
          ? null
          : () async {
              if (!mounted) return;
              startTimer();
              setState(() {
                isButtonDisabled = true;
              });
            },
      child: SizedBox(
        width: 80.w,
        height: 50.h,
        child: FittedBox(
          fit: BoxFit.fitWidth,
          child: Text(
            timeLeft == 0
                ? s.sendAgain
                : '00:${timeLeft.toString().padLeft(2, '0')}',
            textAlign: TextAlign.center,
            style: AppTextStyles.style14W600.copyWith(
              color: AppColors.primaryColor,
            ),
          ),
        ),
      ),
    );
  }
}
