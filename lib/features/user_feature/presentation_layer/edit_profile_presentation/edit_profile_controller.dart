import 'package:gaia_nutrition_plans/features/user_feature/domain_layer/entities/user_entity.dart';
import 'package:gaia_nutrition_plans/features/user_feature/domain_layer/use_cases/get_current_user_profile_use_case.dart';
import 'package:gaia_nutrition_plans/features/user_feature/domain_layer/use_cases/update_profile_use_case.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class EditProfileController extends GetxController {
  final UpdateProfileUseCase _updateProfile;
  final GetCurrentUserProfileUseCase _getCurrentUser;

  EditProfileController({
    required UpdateProfileUseCase updateProfileUseCase,
    required GetCurrentUserProfileUseCase getCurrentUserUseCase,
  }) : _updateProfile = updateProfileUseCase,
       _getCurrentUser = getCurrentUserUseCase;

  // Form Controllers
  final firstNameController = TextEditingController();
  final secondNameController = TextEditingController();
  final weightController = TextEditingController();
  final heightController = TextEditingController();
  final genderController = TextEditingController();
  final birthdayController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  // State
  UserEntity? _user;
  bool _isLoading = false;
  bool _isInitialLoading = true;
  bool _selectedGender = true; // true = Male, false = Female
  DateTime? _selectedDate;
  String? _errorMessage;

  // Getters
  UserEntity? get user => _user;
  bool get isLoading => _isLoading;
  bool get isInitialLoading => _isInitialLoading;
  bool get selectedGender => _selectedGender;
  DateTime? get selectedDate => _selectedDate;
  String? get errorMessage => _errorMessage;

  @override
  void onInit() {
    super.onInit();
    loadUser();
  }

  Future<void> loadUser() async {
    _setInitialLoading(true);

    try {
      _user = await _getCurrentUser.execute();
      if (_user != null) {
        _populateFields();
      } else {
        _setError('Unable to load user data');
      }
    } catch (_) {
      _setError('Failed to load user data');
    } finally {
      _setInitialLoading(false);
    }
  }

  void _populateFields() {
    if (_user == null) return;

    firstNameController.text = _user!.firstName;
    secondNameController.text = _user!.secondName ?? '';
    weightController.text = _user!.weight.toString();
    heightController.text = _user!.height.toString();

    _selectedGender = _user!.gender;
    _selectedDate = _user!.birthday;

    genderController.text = _selectedGender ? 'Male' : 'Female';
    birthdayController.text = formattedDate;
  }

  void setGender(bool gender) {
    _selectedGender = gender;
    genderController.text = gender ? 'Male' : 'Female';
    clearError();
    update();
  }

  void setDate(DateTime date) {
    _selectedDate = date;
    birthdayController.text = formattedDate;
    clearError();
    update();
  }

  Future<void> showGenderDialog(BuildContext context) async {
    final result = await showDialog<bool>(
      context: context,
      builder: (_) => _genderDialog(context),
    );
    if (result != null) setGender(result);
  }

  Widget _genderDialog(BuildContext context) {
    return AlertDialog(
      title: const Text('Select Gender'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [_genderTile('Male', true), _genderTile('Female', false)],
      ),
      actions: [
        TextButton(
          onPressed: () => Get.back<bool>(result: null),
          child: const Text('Cancel'),
        ),
      ],
    );
  }

  Widget _genderTile(String title, bool value) {
    return ListTile(
      title: Text(title),
      leading: Radio<bool>(
        value: value,
        groupValue: _selectedGender,
        onChanged: (_) => Get.back<bool>(result: value),
      ),
      onTap: () => Get.back<bool>(result: value),
    );
  }

  Future<void> selectDate(BuildContext context) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime(2000),
      firstDate: DateTime(1900),
      lastDate: DateTime.now().subtract(const Duration(days: 365 * 13)),
    );
    if (picked != null && picked != _selectedDate) {
      setDate(picked);
    }
  }

  String get formattedDate => _selectedDate == null
      ? 'Select Birthday'
      : '${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}';

  Future<void> updateProfile() async {
    if (!formKey.currentState!.validate()) return;
    if (_selectedDate == null) {
      _setError('Please select your birthday');
      return;
    }

    _setLoading(true);

    try {
      final UserEntity updatedUser = UserEntity(
        id: _user!.id,
        email: _user!.email,
        firstName: firstNameController.text.trim(),
        secondName: secondNameController.text.trim().isEmpty
            ? null
            : secondNameController.text.trim(),
        birthday: _selectedDate!,
        weight: double.parse(weightController.text),
        height: double.parse(heightController.text),
        gender: _selectedGender,
        createdAt: _user!.createdAt,
        updatedAt: DateTime.now(),
      );

      await _updateProfile.execute(updatedUser);

      Get.snackbar(
        'Success',
        'Profile updated successfully!',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );

      _user = updatedUser;
      Get.back(result: true);
    } catch (_) {
      _setError('Failed to update profile. Please try again.');
    } finally {
      _setLoading(false);
    }
  }

  // Helpers
  void _setLoading(bool value) {
    _isLoading = value;
    _errorMessage = null;
    update();
  }

  void _setInitialLoading(bool value) {
    _isInitialLoading = value;
    update();
  }

  void _setError(String message) {
    _errorMessage = message;
    update();
  }

  void clearError() {
    if (_errorMessage != null) {
      _errorMessage = null;
      update();
    }
  }

  @override
  void onClose() {
    firstNameController.dispose();
    secondNameController.dispose();
    weightController.dispose();
    heightController.dispose();
    genderController.dispose();
    birthdayController.dispose();
    super.onClose();
  }
}
