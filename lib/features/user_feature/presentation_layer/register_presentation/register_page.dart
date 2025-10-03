import 'package:flutter/material.dart';
import 'package:gaia_nutrition_plans/core/constant/app_spaces.dart';
import 'package:gaia_nutrition_plans/features/user_feature/presentation_layer/register_presentation/register_controller.dart';
import 'package:gaia_nutrition_plans/features/user_feature/presentation_layer/register_presentation/widgets/register_erorr_widget.dart';
import 'package:get/get.dart';
import 'widgets/first_name_input_widget.dart';
import 'widgets/second_name_input_widget.dart';
import 'widgets/register_email_input_widget.dart';
import 'widgets/register_password_input_widget.dart';
import 'widgets/birthday_picker_widget.dart';
import 'widgets/gender_selector_widget.dart';
import 'widgets/weight_height_input_widget.dart';
import 'widgets/register_button_widget.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Create Account'), centerTitle: true),
      body: GetBuilder<RegisterController>(
        builder: (controller) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(smallSpace),
            child: Form(
              key: controller.formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  if (controller.errorMessage != null)
                    const RegisterErorrWidget(),
                  const FirstNameInputWidget(),
                  const SizedBox(height: mediumSpace),
                  const SecondNameInputWidget(),
                  const SizedBox(height: mediumSpace),
                  const RegisterEmailInputWidget(),
                  const SizedBox(height: mediumSpace),
                  const BirthdayPickerWidget(),
                  const SizedBox(height: mediumSpace),
                  const GenderSelectorWidget(),
                  const SizedBox(height: mediumSpace),
                  const WeightHeightInputWidget(),
                  const SizedBox(height: mediumSpace),
                  RegisterPasswordInputWidget(
                    labelText: 'Password',
                    hintText: 'Enter your password',
                    controller: controller.passwordController,
                    isVisible: controller.isPasswordVisible,
                    toggleVisibility: controller.togglePasswordVisibility,
                    clearError: controller.clearError,
                  ),
                  const SizedBox(height: mediumSpace),
                  RegisterPasswordInputWidget(
                    labelText: 'Confirm Password',
                    hintText: 'Confirm your password',
                    controller: controller.confirmPasswordController,
                    isVisible: controller.isConfirmPasswordVisible,
                    toggleVisibility:
                        controller.toggleConfirmPasswordVisibility,
                    clearError: controller.clearError,
                  ),
                  const SizedBox(height: largeSpace),
                  const RegisterButtonWidget(),
                  const SizedBox(height: largeSpace),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
