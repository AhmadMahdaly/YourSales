import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:your_sales/core/localization/s.dart';
import 'package:your_sales/core/responsive/responsive_config.dart';
import 'package:your_sales/core/routing/app_routes.dart';
import 'package:your_sales/core/shared_widgets/custom_primary_button.dart';
import 'package:your_sales/core/shared_widgets/custom_primary_textfield.dart';
import 'package:your_sales/core/theme/app_colors.dart';
import 'package:your_sales/core/theme/app_images.dart';
import 'package:your_sales/core/theme/app_text_style.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  bool isPassword = true;
  @override
  Widget build(BuildContext context) {
    final s = S.of(context)!;
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.r),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              65.verticalSpace,
              Image.asset(
                AppImages.appLogo,
                height: 100.h,
                fit: BoxFit.contain,
              ),
              32.verticalSpace,
              Text(
                s.loginToYourAccount,
                style: AppTextStyles.style20W700.copyWith(
                  color: AppColors.primaryColor,
                ),
                textAlign: TextAlign.start,
              ),
              24.verticalSpace,
              Text(
                s.email,
                style: AppTextStyles.style14W600.copyWith(
                  color: AppColors.textGrayColor,
                ),
              ),
              6.verticalSpace,
              CustomPrimaryTextfield(
                prefix: const Icon(
                  Icons.mail_outline_rounded,
                  color: AppColors.textGrayColor,
                ),
                controller: _emailController,
                text: S.of(context)!.email,
                // validator: (value) =>
                //     value!.isEmpty ? S.of(context)!.pleaseEnterEmail : null,
                textInputAction: TextInputAction.next,
                autofillHints: const [AutofillHints.email],
              ),
              16.verticalSpace,
              Text(
                s.password,
                style: AppTextStyles.style14W600.copyWith(
                  color: AppColors.textGrayColor,
                ),
              ),
              6.verticalSpace,
              CustomPrimaryTextfield(
                prefix: const Icon(
                  Icons.lock_outline_rounded,
                  color: AppColors.textGrayColor,
                ),
                controller: _passwordController,
                text: S.of(context)!.password,
                isPassword: true,
                // validator: (value) =>
                //     value!.isEmpty ? S.of(context)!.pleaseEnterPassword : null,
                suffix: IconButton(
                  onPressed: () => setState(() {
                    isPassword = !isPassword;
                  }),
                  icon: isPassword
                      ? const Icon(
                          Icons.visibility_outlined,
                          color: AppColors.textGrayColor,
                        )
                      : const Icon(
                          Icons.visibility_off_outlined,
                          color: AppColors.textGrayColor,
                        ),
                ),
                textInputAction: TextInputAction.done,
                autofillHints: const [AutofillHints.password],
              ),
              8.verticalSpace,
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  InkWell(
                    onTap: () => context.push(AppRoutes.forgetPasswordScreen),
                    child: Text(
                      S.of(context)!.forgetPassword,
                      style: AppTextStyles.style14W500.copyWith(
                        color: AppColors.primaryColor,
                      ),
                    ),
                  ),
                ],
              ),
              45.verticalSpace,
              CustomPrimaryButton(
                onPressed: () {
                  // if (_formKey.currentState!.validate()) {}
                  context.pushReplacementNamed(
                    AppRoutes.mainlayoutScreen,
                  );
                },
                text: S.of(context)!.signIn,
              ),

              // TextButton(
              //   onPressed: () => context.push(AppRoutes.registerScreen),
              //   child: Text(
              //     S.of(context)!.dontHaveAccount,
              //     style: AppTextStyles.style14W700,
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
