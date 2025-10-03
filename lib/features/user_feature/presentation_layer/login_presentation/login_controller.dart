import 'package:gaia_nutrition_plans/features/index_page_feature/index_binding.dart';
import 'package:gaia_nutrition_plans/features/index_page_feature/index_page.dart';
import 'package:gaia_nutrition_plans/features/user_feature/domain_layer/use_cases/login_use_case.dart';
import 'package:gaia_nutrition_plans/features/user_feature/presentation_layer/register_presentation/register_binding.dart';
import 'package:gaia_nutrition_plans/features/user_feature/presentation_layer/register_presentation/register_page.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class LoginController extends GetxController {
  final LoginUseCase loginUseCase;

  LoginController(this.loginUseCase);

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  bool _isLoading = false;
  bool _isPasswordVisible = false;
  String? _errorMessage;

  bool get isLoading => _isLoading;
  bool get isPasswordVisible => _isPasswordVisible;
  String? get errorMessage => _errorMessage;

  void togglePasswordVisibility() {
    _isPasswordVisible = !_isPasswordVisible;
    update();
  }

  void clearError() {
    if (_errorMessage != null) {
      _errorMessage = null;
      update();
    }
  }

  Future<void> login() async {
    if (!formKey.currentState!.validate()) {
      return;
    }

    _isLoading = true;
    _errorMessage = null;
    update();

    try {
      await loginUseCase.execute(
        email: emailController.text.trim(),
        password: passwordController.text,
      );
      Get.off(() => const IndexPage(), binding: IndexBinding());
      Get.snackbar(
        'Success',
        'Login successful!',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    } catch (e) {
      _errorMessage = 'Login failed. Please try again.';
    } finally {
      _isLoading = false;
      update();
    }
  }

  void goToCreateAccountPage() =>
      Get.to(() => const RegisterPage(), binding: RegisterBinding());

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
