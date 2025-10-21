import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:your_sales/core/localization/s.dart';
import 'package:your_sales/core/responsive/responsive_config.dart';
import 'package:your_sales/core/routing/app_routes.dart';
import 'package:your_sales/core/shared_widgets/custom_primary_button.dart';
import 'package:your_sales/core/shared_widgets/custom_primary_textfield.dart';
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
              50.verticalSpace,
              Image.asset(
                AppImages.appLogo,
                height: 100.h,
                fit: BoxFit.contain,
              ),
              24.verticalSpace,
              Text(
                s.welcomeBack,
                style: AppTextStyles.style20W700,
                textAlign: TextAlign.center,
              ),
              8.verticalSpace,
              Text(
                s.signInAccessOurServices,
                style: AppTextStyles.style14W400,
                textAlign: TextAlign.center,
              ),
              24.verticalSpace,
              Text(
                s.email,
                style: AppTextStyles.style14W600,
              ),
              6.verticalSpace,
              CustomPrimaryTextfield(
                controller: _emailController,
                text: S.of(context)!.email,
                // validator: (value) =>
                //     value!.isEmpty ? S.of(context)!.pleaseEnterEmail : null,
              ),
              16.verticalSpace,
              Text(
                s.password,
                style: AppTextStyles.style14W600,
              ),
              6.verticalSpace,
              CustomPrimaryTextfield(
                controller: _passwordController,
                text: S.of(context)!.password,
                isPassword: true,
                // validator: (value) =>
                //     value!.isEmpty ? S.of(context)!.pleaseEnterPassword : null,
              ),
              TextButton(
                onPressed: () => context.push(AppRoutes.forgetPasswordScreen),
                child: Text(
                  S.of(context)!.forgetPassword,
                  textAlign: TextAlign.end,
                ),
              ),
              40.verticalSpace,
              CustomPrimaryButton(
                onPressed: () {
                  // if (_formKey.currentState!.validate()) {}
                  context.pushReplacementNamed(
                    AppRoutes.mainlayoutScreen,
                  );
                },
                text: S.of(context)!.signIn,
              ),

              TextButton(
                onPressed: () => context.push(AppRoutes.registerScreen),
                child: Text(
                  S.of(context)!.dontHaveAccount,
                  style: AppTextStyles.style14W700,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
