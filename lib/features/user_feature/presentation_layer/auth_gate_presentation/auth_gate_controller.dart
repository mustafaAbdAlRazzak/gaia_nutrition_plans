import 'package:flutter/material.dart';
import 'package:gaia_nutrition_plans/features/index_page_feature/index_binding.dart';
import 'package:gaia_nutrition_plans/features/index_page_feature/index_page.dart';
import 'package:gaia_nutrition_plans/features/user_feature/domain_layer/use_cases/is_user_logged_in_use_case.dart';
import 'package:gaia_nutrition_plans/features/user_feature/presentation_layer/login_presentation/login_binding.dart';
import 'package:gaia_nutrition_plans/features/user_feature/presentation_layer/login_presentation/login_page.dart';
import 'package:get/get.dart';

class AuthGateController extends GetxController {
  final IsUserLoggedInUseCase _isUserLoggedIn;

  AuthGateController(this._isUserLoggedIn);

  @override
  void onInit() {
    super.onInit();
    WidgetsBinding.instance.addPostFrameCallback((_) => _redirectUser());
  }

  void _redirectUser() {
    final isLoggedIn = _isUserLoggedIn.execute();

    if (isLoggedIn) {
      Get.off(() => const IndexPage(), binding: IndexBinding());
    } else {
      Get.off(() => const LoginPage(), binding: LoginBinding());
    }
  }
}
