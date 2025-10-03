import 'package:flutter/material.dart';
import 'package:gaia_nutrition_plans/core/constant/app_icon_sizes.dart';
import 'package:gaia_nutrition_plans/core/constant/app_spaces.dart';

class ProfileInfoWidget extends StatelessWidget {
  final String fullName;
  final String email;
  final String genderText;
  final String formattedBirthday;
  final int age;
  final double weight;
  final double height;

  const ProfileInfoWidget({
    super.key,
    required this.fullName,
    required this.email,
    required this.genderText,
    required this.formattedBirthday,
    required this.age,
    required this.weight,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: mediumSpace),
      child: Padding(
        padding: const EdgeInsets.all(mediumSpace),
        child: Column(
          children: [
            const SizedBox(height: mediumSpace),
            // Name
            Text(
              fullName,
              style: Theme.of(context).textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: tinySpace),
            // Email
            Text(
              email,
              style: Theme.of(context).textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: mediumSpace),
            // Info Grid
            Row(
              children: [
                Expanded(
                  child: _InfoItem(
                    icon: Icons.cake,
                    label: 'Age',
                    value: '$age years',
                  ),
                ),
                Expanded(
                  child: _InfoItem(
                    icon: Icons.wc,
                    label: 'Gender',
                    value: genderText,
                  ),
                ),
              ],
            ),
            const SizedBox(height: mediumSpace),
            Row(
              children: [
                Expanded(
                  child: _InfoItem(
                    icon: Icons.monitor_weight,
                    label: 'Weight',
                    value: '${weight.toStringAsFixed(1)} kg',
                  ),
                ),
                Expanded(
                  child: _InfoItem(
                    icon: Icons.height,
                    label: 'Height',
                    value: '${height.toStringAsFixed(1)} cm',
                  ),
                ),
              ],
            ),
            const SizedBox(height: mediumSpace),
            _InfoItem(
              icon: Icons.calendar_today,
              label: 'Birthday',
              value: formattedBirthday,
            ),
          ],
        ),
      ),
    );
  }
}

class _InfoItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _InfoItem({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: tinySpace),
      child: Row(
        children: [
          Icon(
            icon,
            size: mediumIcon,
            color: Theme.of(context).colorScheme.primary,
          ),
          const SizedBox(width: mediumSpace),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: Theme.of(
                  context,
                ).textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.bold),
              ),
              Text(value, style: Theme.of(context).textTheme.bodyMedium),
            ],
          ),
        ],
      ),
    );
  }
}
