import 'package:flutter/material.dart';
import 'package:gaia_nutrition_plans/core/constant/app_border_radius.dart';
import 'package:gaia_nutrition_plans/core/constant/app_icon_sizes.dart';
import 'package:gaia_nutrition_plans/core/constant/app_spaces.dart';

class ProfileMenuItemWidget extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? subtitle;
  final VoidCallback? onTap;
  final bool isLoading;

  const ProfileMenuItemWidget({
    super.key,
    required this.icon,
    required this.title,
    this.subtitle,
    this.onTap,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(
        horizontal: mediumSpace,
        vertical: tinySpace,
      ),
      child: ListTile(
        leading: isLoading
            ? const SizedBox(
                width: mediumSpace,
                height: mediumSpace,
                child: CircularProgressIndicator(),
              )
            : Icon(
                icon,
                size: largeIcon,
                color: Theme.of(context).colorScheme.primary,
              ),
        title: Text(title, style: Theme.of(context).textTheme.titleMedium),
        subtitle: subtitle != null
            ? Text(subtitle!, style: Theme.of(context).textTheme.bodyMedium)
            : null,
        trailing: isLoading
            ? null
            : Icon(
                Icons.arrow_forward_ios,
                size: mediumIcon,
                color: Theme.of(context).colorScheme.primary,
              ),
        onTap: isLoading ? null : onTap,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
        ),
      ),
    );
  }
}
