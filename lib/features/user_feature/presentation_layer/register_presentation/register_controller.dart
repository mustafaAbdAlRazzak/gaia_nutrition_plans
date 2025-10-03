import 'package:gaia_nutrition_plans/features/user_feature/domain_layer/entities/user_entity.dart';
import 'package:gaia_nutrition_plans/features/user_feature/domain_layer/use_cases/register_use_case.dart';
import 'package:gaia_nutrition_plans/features/user_feature/presentation_layer/login_presentation/login_binding.dart';
import 'package:gaia_nutrition_plans/features/user_feature/presentation_layer/login_presentation/login_page.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class RegisterController extends GetxController {
  final RegisterUseCase registerUseCase;

  RegisterController(this.registerUseCase);

  // Form Controllers
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController secondNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final TextEditingController weightController = TextEditingController();
  final TextEditingController heightController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  // State variables
  bool _isLoading = false;
  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;
  bool _selectedGender = true; // true for male, false for female
  DateTime? _selectedDate;
  String? _errorMessage;

  // Getters
  bool get isLoading => _isLoading;
  bool get isPasswordVisible => _isPasswordVisible;
  bool get isConfirmPasswordVisible => _isConfirmPasswordVisible;
  bool get selectedGender => _selectedGender;
  DateTime? get selectedDate => _selectedDate;
  String? get errorMessage => _errorMessage;

  // Methods
  void togglePasswordVisibility() {
    _isPasswordVisible = !_isPasswordVisible;
    update();
  }

  void toggleConfirmPasswordVisibility() {
    _isConfirmPasswordVisible = !_isConfirmPasswordVisible;
    update();
  }

  void setGender(bool gender) {
    _selectedGender = gender;
    update();
  }

  void setDate(DateTime date) {
    _selectedDate = date;
    update();
  }

  void clearError() {
    if (_errorMessage != null) {
      _errorMessage = null;
      update();
    }
  }

  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime(2000),
      firstDate: DateTime(1900),
      lastDate: DateTime.now().subtract(
        const Duration(days: 365 * 13),
      ), // At least 13 years old
    );

    if (picked != null && picked != _selectedDate) {
      setDate(picked);
    }
  }

  String get formattedDate {
    if (_selectedDate == null) return 'Select Birthday';
    return '${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}';
  }

  Future<void> register() async {
    if (!formKey.currentState!.validate()) {
      return;
    }

    if (_selectedDate == null) {
      _errorMessage = 'Please select your birthday';
      update();
      return;
    }

    if (passwordController.text != confirmPasswordController.text) {
      _errorMessage = 'Passwords do not match';
      update();
      return;
    }

    _isLoading = true;
    _errorMessage = null;
    update();

    try {
      final UserEntity userEntity = UserEntity(
        firstName: firstNameController.text.trim(),
        secondName: secondNameController.text.trim().isEmpty
            ? null
            : secondNameController.text.trim(),
        email: emailController.text.trim(),
        birthday: _selectedDate!,
        weight: double.parse(weightController.text),
        height: double.parse(heightController.text),
        gender: _selectedGender,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      await registerUseCase.execute(
        userEntity: userEntity,
        password: passwordController.text,
      );
      Get.back();
      Get.snackbar(
        'Success',
        'Registration successful! Please verify your email and login now',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    } catch (e) {
      _errorMessage = 'Registration failed. Please try again.';
    } finally {
      _isLoading = false;
      update();
    }
  }

  void goToLogInPage() =>
      Get.to(() => const LoginPage(), binding: LoginBinding());

  @override
  void onClose() {
    firstNameController.dispose();
    secondNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    weightController.dispose();
    heightController.dispose();
    super.onClose();
  }
}
