import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:your_sales/core/localization/s.dart';
import 'package:your_sales/core/responsive/responsive_config.dart';
import 'package:your_sales/core/routing/app_routes.dart';
import 'package:your_sales/core/shared_widgets/custom_primary_button.dart';
import 'package:your_sales/core/shared_widgets/custom_primary_textfield.dart';
import 'package:your_sales/core/theme/app_text_style.dart';

class ForgotPasswordView extends StatefulWidget {
  const ForgotPasswordView({super.key});

  @override
  State<ForgotPasswordView> createState() => _ForgotPasswordViewState();
}

class _ForgotPasswordViewState extends State<ForgotPasswordView> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final s = S.of(context)!;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          s.forgetPasswordTitle,
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
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(s.enterYourEmail, style: AppTextStyles.style14W600),
              6.verticalSpace,
              CustomPrimaryTextfield(
                controller: _emailController,
                text: s.email,
                // validator: (value) =>
                //     value!.isEmpty ? s.pleaseEnterEmail : null,
              ),
              60.verticalSpace,
              CustomPrimaryButton(
                onPressed: () {
                  // if (_formKey.currentState!.validate()) {
                  context.push(
                    AppRoutes.otpVerificationView,
                    extra: _emailController.text,
                  );
                  // }
                },
                text: s.done,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
