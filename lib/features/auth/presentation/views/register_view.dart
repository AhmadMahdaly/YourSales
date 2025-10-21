import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:your_sales/core/localization/s.dart';
import 'package:your_sales/core/responsive/responsive_config.dart';
import 'package:your_sales/core/shared_widgets/custom_primary_button.dart';
import 'package:your_sales/core/shared_widgets/custom_primary_textfield.dart';
import 'package:your_sales/core/theme/app_images.dart';
import 'package:your_sales/core/theme/app_text_style.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _fullNameController = TextEditingController();
  final _companyController = TextEditingController();
  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _fullNameController.dispose();
    _companyController.dispose();
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
                s.createAccount,
                style: AppTextStyles.style20W700,
                textAlign: TextAlign.center,
              ),
              8.verticalSpace,
              Text(
                s.joinOurServices,
                style: AppTextStyles.style14W400,
                textAlign: TextAlign.center,
              ),
              24.verticalSpace,
              Text(
                s.fullName,
                style: AppTextStyles.style14W600,
              ),
              6.verticalSpace,
              CustomPrimaryTextfield(
                controller: _fullNameController,
                text: s.fullName,
                // validator: (value) =>
                //     value!.isEmpty ? s.pleaseEnterFullName : null,
              ),
              16.verticalSpace,
              Text(
                s.email,
                style: AppTextStyles.style14W600,
              ),
              6.verticalSpace,
              CustomPrimaryTextfield(
                controller: _emailController,
                text: s.email,
                // validator: (value) =>
                //     value!.isEmpty ? s.pleaseEnterEmail : null,
              ),
              16.verticalSpace,
              Text(
                s.companyName,
                style: AppTextStyles.style14W600,
              ),
              6.verticalSpace,
              CustomPrimaryTextfield(
                controller: _companyController,
                text: s.companyName,
                isPassword: true,
                // validator: (value) =>
                //     value!.length < 6 ? s.pleaseEnterPassword : null,
              ),
              16.verticalSpace,
              Text(
                s.password,
                style: AppTextStyles.style14W600,
              ),
              6.verticalSpace,
              CustomPrimaryTextfield(
                controller: _passwordController,
                text: s.password,
                isPassword: true,
                // validator: (value) =>
                //     value!.length < 6 ? s.pleaseEnterPassword : null,
              ),
              40.verticalSpace,
              // if (state is AuthLoading)
              //   const SizedBox(
              //     height: 20,
              //     width: 20,
              //     child: CircularProgressIndicator(
              //       strokeWidth: 2,
              //       color: Colors.white,
              //     ),
              //   )
              // else
              CustomPrimaryButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {}
                },
                text: s.signUp,
              ),
              TextButton(
                onPressed: () => context.pop(),
                child: Text(
                  S.of(context)!.alreadyHaveAccount,
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
