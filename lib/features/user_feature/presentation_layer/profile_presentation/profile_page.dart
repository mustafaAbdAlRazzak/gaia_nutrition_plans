import 'package:flutter/material.dart';
import 'package:gaia_nutrition_plans/core/constant/app_spaces.dart';
import 'package:gaia_nutrition_plans/features/user_feature/presentation_layer/profile_presentation/profile_controller.dart';
import 'package:get/get.dart';
import 'widgets/profile_info_widget.dart';
import 'widgets/profile_menu_item_widget.dart';
import 'widgets/profile_loading_widget.dart';
import 'widgets/profile_error_widget.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileController>(
      builder: (controller) {
        if (controller.isLoading) {
          return const ProfileLoadingWidget();
        }
        if (controller.errorMessage != null || controller.currentUser == null) {
          return ProfileErrorWidget(
            message: controller.errorMessage ?? 'No user data found',
            onRetry: controller.refreshUser,
          );
        }
        final user = controller.currentUser!;
        return RefreshIndicator(
          onRefresh: controller.refreshUser,
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Column(
              children: [
                const SizedBox(height: mediumSpace),
                ProfileInfoWidget(
                  fullName: controller.fullName,
                  email: user.email,
                  genderText: controller.genderText,
                  formattedBirthday: controller.formattedBirthday,
                  age: controller.age,
                  weight: user.weight,
                  height: user.height,
                ),
                const SizedBox(height: mediumSpace),
                ProfileMenuItemWidget(
                  icon: Icons.star,
                  title: 'Upgrade to Premium',
                  subtitle: 'Unlock all features and benefits',
                  onTap: controller.upgradeToPremium,
                  isLoading: controller.isUpgradeLoading,
                ),
                ProfileMenuItemWidget(
                  icon: Icons.edit,
                  title: 'Edit Profile',
                  subtitle: 'Update your personal information',
                  onTap: controller.editProfile,
                ),
                ProfileMenuItemWidget(
                  icon: Icons.lock,
                  title: 'Change Password',
                  subtitle: 'Update your account password',
                  onTap: controller.changePassword,
                  isLoading: controller.isChangePasswordLoading,
                ),
                ProfileMenuItemWidget(
                  icon: Icons.logout,
                  title: 'Logout',
                  subtitle: 'Sign out of your account',
                  onTap: controller.logout,
                  isLoading: controller.isLogoutLoading,
                ),
                ProfileMenuItemWidget(
                  icon: Icons.delete_forever,
                  title: 'Delete Account',
                  subtitle: 'Permanently delete your account',
                  onTap: controller.deleteAccount,
                  isLoading: controller.isDeleteLoading,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
