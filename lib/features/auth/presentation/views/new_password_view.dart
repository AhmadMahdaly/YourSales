import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:your_sales/core/localization/s.dart';
import 'package:your_sales/core/responsive/responsive_config.dart';
import 'package:your_sales/core/routing/app_routes.dart';
import 'package:your_sales/core/shared_widgets/custom_primary_button.dart';
import 'package:your_sales/core/shared_widgets/custom_primary_textfield.dart';
import 'package:your_sales/core/theme/app_text_style.dart';

class NewPasswordView extends StatefulWidget {
  const NewPasswordView({required this.email, super.key});
  final String email;

  @override
  State<NewPasswordView> createState() => _NewPasswordViewState();
}

class _NewPasswordViewState extends State<NewPasswordView> {
  final _formKey = GlobalKey<FormState>();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

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
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                s.newPassword,
                style: AppTextStyles.style14W600,
              ),
              6.verticalSpace,
              CustomPrimaryTextfield(
                controller: _newPasswordController,
                text: s.newPassword,
                isPassword: true,
                // validator: (value) {
                //   if (value!.isEmpty) return s.pleaseEnterPassword;
                //   if (value.length < 6) return s.passwordMinLength;
                //   return null;
                // },
              ),
              16.verticalSpace,
              Text(
                s.confirmPassword,
                style: AppTextStyles.style14W600,
              ),
              6.verticalSpace,
              CustomPrimaryTextfield(
                controller: _confirmPasswordController,
                text: s.confirmPassword,
                isPassword: true,
                // validator: (value) {
                //   if (value!.isEmpty) return s.pleaseConfirmPassword;
                //   if (value != _newPasswordController.text) {
                //     return s.passwordsDoNotMatch;
                //   }
                //   return null;
                // },
              ),
              60.verticalSpace,
              CustomPrimaryButton(
                onPressed: () {
                  context.pushReplacementNamed(
                    AppRoutes.loginScreen,
                  );
                  // if (_formKey.currentState!.validate()) {}
                },
                text: s.reset,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
