import 'package:flutter/material.dart';
import 'package:gaia_nutrition_plans/core/constant/app_border_radius.dart';
import 'package:gaia_nutrition_plans/core/constant/app_icon_sizes.dart';
import 'package:gaia_nutrition_plans/core/constant/app_spaces.dart';
import 'package:gaia_nutrition_plans/features/user_feature/presentation_layer/edit_profile_presentation/edit_profile_controller.dart';
import 'package:get/get.dart';

class EditProfileErrorWidget extends GetView<EditProfileController> {
  const EditProfileErrorWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(mediumSpace),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: hugeIcon, color: Colors.red),
            const SizedBox(height: mediumSpace),
            const Text('Error'),
            const SizedBox(height: mediumSpace),
            Text(
              controller.errorMessage ?? 'No user data found',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: largeSpace),
            ElevatedButton.icon(
              onPressed: controller.loadUser,
              icon: const Icon(Icons.refresh, size: smallIcon),
              label: const Text('Try Again'),
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(borderRadius),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
