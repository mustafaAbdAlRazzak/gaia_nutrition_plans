import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:gaia_nutrition_plans/features/user_feature/domain_layer/entities/user_entity.dart';
import 'package:gaia_nutrition_plans/features/user_feature/domain_layer/use_cases/get_client_secret_use_case.dart';
import 'package:gaia_nutrition_plans/features/user_feature/domain_layer/use_cases/is_user_subscribed_use_case.dart';
import 'package:gaia_nutrition_plans/features/user_feature/domain_layer/use_cases/reset_password_use_case.dart';
import 'package:gaia_nutrition_plans/features/user_feature/domain_layer/use_cases/delete_account_use_case.dart';
import 'package:gaia_nutrition_plans/features/user_feature/domain_layer/use_cases/get_current_user_profile_use_case.dart';
import 'package:gaia_nutrition_plans/features/user_feature/domain_layer/use_cases/logout_use_case.dart';
import 'package:gaia_nutrition_plans/features/user_feature/presentation_layer/edit_profile_presentation/edit_profile_binding.dart';
import 'package:gaia_nutrition_plans/features/user_feature/presentation_layer/edit_profile_presentation/edit_profile_page.dart';
import 'package:gaia_nutrition_plans/features/user_feature/presentation_layer/login_presentation/login_binding.dart';
import 'package:gaia_nutrition_plans/features/user_feature/presentation_layer/login_presentation/login_page.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class ProfileController extends GetxController {
  final GetCurrentUserProfileUseCase getCurrentUserUseCase;
  final ResetPasswordUseCase changePasswordUseCase;
  final DeleteAccountUseCase deleteAccountUseCase;
  final LogoutUseCase logoutUseCase;
  final GetClientSecretUseCase getClientSecretUseCase;
  final IsUserSubscribedUseCase isUserSubscribedUseCase;

  ProfileController({
    required this.getCurrentUserUseCase,
    required this.changePasswordUseCase,
    required this.deleteAccountUseCase,
    required this.logoutUseCase,
    required this.getClientSecretUseCase,
    required this.isUserSubscribedUseCase,
  });

  // State variables
  UserEntity? _currentUser;
  bool _isLoading = true;
  bool _isLogoutLoading = false;
  bool _isDeleteLoading = false;
  bool _isChangePasswordLoading = false;
  bool _isUpgradeLoading = false;
  String? _errorMessage;

  // Getters
  UserEntity? get currentUser => _currentUser;
  bool get isLoading => _isLoading;
  bool get isLogoutLoading => _isLogoutLoading;
  bool get isDeleteLoading => _isDeleteLoading;
  bool get isChangePasswordLoading => _isChangePasswordLoading;
  bool get isUpgradeLoading => _isUpgradeLoading;
  String? get errorMessage => _errorMessage;

  @override
  void onInit() {
    super.onInit();
    loadCurrentUser();
  }

  // Methods
  Future<void> loadCurrentUser() async {
    _isLoading = true;
    _errorMessage = null;
    update();
    try {
      _currentUser = await getCurrentUserUseCase.execute();
      if (_currentUser == null) {
        _errorMessage = 'Unable to load user data';
      }
    } catch (e) {
      _errorMessage = 'Failed to load user data';
    } finally {
      _isLoading = false;
      update();
    }
  }

  Future<void> refreshUser() async {
    await loadCurrentUser();
  }

  void editProfile() async {
    final bool? result = await Get.to(
      () => const EditProfilePage(),
      binding: EditProfileBinding(),
    );
    if (result != null) {
      await refreshUser();
    }
  }

  Future<void> changePassword() async {
    final bool? confirm = await _showConfirmDialog(
      'Change Password',
      'Do you want to change your password?',
    );

    if (confirm != true) return;

    _isChangePasswordLoading = true;
    update();

    try {
      await changePasswordUseCase.execute();
      Get.snackbar(
        'Success',
        'Password change request sent successfully',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to change password',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      _isChangePasswordLoading = false;
      update();
    }
  }

  Future<void> logout() async {
    final bool? confirm = await _showConfirmDialog(
      'Logout',
      'Are you sure you want to logout?',
    );

    if (confirm != true) return;

    _isLogoutLoading = true;
    update();

    try {
      await logoutUseCase.execute();
      Get.snackbar(
        'Success',
        'Logged out successfully',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
      Get.to(() => const LoginPage(), binding: LoginBinding());
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to logout',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      _isLogoutLoading = false;
      update();
    }
  }

  Future<void> deleteAccount() async {
    final bool? confirm = await _showDangerousConfirmDialog(
      'Delete Account',
      'Are you sure you want to delete your account? This action cannot be undone.',
    );

    if (confirm != true) return;

    _isDeleteLoading = true;
    update();

    try {
      await deleteAccountUseCase.execute();
      Get.snackbar(
        'Success',
        'Account deleted successfully',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
      Get.to(() => const LoginPage(), binding: LoginBinding());
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to delete account',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      _isDeleteLoading = false;
      update();
    }
  }

  Future<bool?> _showConfirmDialog(String title, String message) async {
    return await Get.dialog<bool>(
      AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Get.back(result: false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Get.back(result: true),
            child: const Text('Confirm'),
          ),
        ],
      ),
    );
  }

  Future<bool?> _showDangerousConfirmDialog(
    String title,
    String message,
  ) async {
    return await Get.dialog<bool>(
      AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Get.back(result: false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Get.back(result: true),
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }

  String get fullName {
    if (_currentUser == null) return '';
    final firstName = _currentUser!.firstName;
    final secondName = _currentUser!.secondName ?? '';
    return secondName.isEmpty ? firstName : '$firstName $secondName';
  }

  String get genderText {
    if (_currentUser == null) return '';
    return _currentUser!.gender ? 'Male' : 'Female';
  }

  String get formattedBirthday {
    if (_currentUser == null) return '';
    final date = _currentUser!.birthday;
    return '${date.day}/${date.month}/${date.year}';
  }

  int get age {
    if (_currentUser == null) return 0;
    final now = DateTime.now();
    final birthday = _currentUser!.birthday;
    int age = now.year - birthday.year;
    if (now.month < birthday.month ||
        (now.month == birthday.month && now.day < birthday.day)) {
      age--;
    }
    return age;
  }

  Future<void> upgradeToPremium() async {
    _isUpgradeLoading = true;
    update();
    try {
      bool? isSubscribed = await isUserSubscribedUseCase.execute();
      if (isSubscribed == true) throw Exception('Already subscribed');
      Stripe.publishableKey =
          'pk_test_51SCvpePXBKqzheTUOLkfMqydEVdDMoyZzeVknvWhG2gujgoX7F9NYMhB672MwN7iqB7Pzp0V40OQOJVa7cI2uOIm00m4Di85vw';
      final String? clientSecret = await getClientSecretUseCase.execute();
      await _initPaymentSheet(clientSecret!);
      await Stripe.instance.presentPaymentSheet();
    } catch (e) {
      Get.defaultDialog(
        title: 'Error',
        middleText: 'Failed to upgrade to premium $e',
      );
    } finally {
      _isUpgradeLoading = false;
      update();
    }
  }

  Future<void> _initPaymentSheet(String clientSecret) async {
    await Stripe.instance.initPaymentSheet(
      paymentSheetParameters: SetupPaymentSheetParameters(
        paymentIntentClientSecret: clientSecret,
        merchantDisplayName: 'Gaia nutrition plans app premium subscription',
      ),
    );
  }
}
