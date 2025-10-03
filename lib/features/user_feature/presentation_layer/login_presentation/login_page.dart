import 'package:flutter/material.dart';
import 'package:gaia_nutrition_plans/core/constant/app_spaces.dart';
import 'package:gaia_nutrition_plans/features/user_feature/presentation_layer/login_presentation/login_controller.dart';
import 'package:gaia_nutrition_plans/features/user_feature/presentation_layer/login_presentation/widgets/login_error_message.dart';
import 'package:get/get.dart';
import 'widgets/email_input_widget.dart';
import 'widgets/password_input_widget.dart';
import 'widgets/login_button_widget.dart';
import 'widgets/create_account_button_widget.dart';

class LoginPage extends GetView<LoginController> {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login'), centerTitle: true),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(mediumSpace),
        child: Form(
          key: controller.formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (controller.errorMessage != null) const LoginErrorMessage(),
              const EmailInputWidget(),
              const SizedBox(height: largeSpace),
              const PasswordInputWidget(),
              const SizedBox(height: largeSpace),
              const LoginButtonWidget(),
              const SizedBox(height: largeSpace),
              const CreateAccountButtonWidget(),
              const SizedBox(height: largeSpace),
            ],
          ),
        ),
      ),
    );
  }
}
