import 'package:flutter/material.dart';
import 'package:gaia_nutrition_plans/features/user_feature/presentation_layer/register_presentation/register_controller.dart';
import 'package:get/get.dart';

class GenderSelectorWidget extends GetView<RegisterController> {
  const GenderSelectorWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final bool selectedGender = controller.selectedGender;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Gender', style: Theme.of(context).textTheme.bodyMedium),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () => controller.setGender(true),
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: selectedGender
                          ? Theme.of(context).primaryColor
                          : Colors.grey,
                      width: selectedGender ? 2 : 1,
                    ),
                    borderRadius: BorderRadius.circular(10),
                    color: selectedGender
                        ? Theme.of(context).primaryColor.withValues(alpha: 0.1)
                        : null,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.male,
                        size: 24,
                        color: selectedGender
                            ? Theme.of(context).primaryColor
                            : Colors.grey,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Male',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: selectedGender
                              ? Theme.of(context).primaryColor
                              : null,
                          fontWeight: selectedGender ? FontWeight.bold : null,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: GestureDetector(
                onTap: () => controller.setGender(false),
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: !selectedGender
                          ? Theme.of(context).primaryColor
                          : Colors.grey,
                      width: !selectedGender ? 2 : 1,
                    ),
                    borderRadius: BorderRadius.circular(10),
                    color: !selectedGender
                        ? Theme.of(context).primaryColor.withValues(alpha: 0.1)
                        : null,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.female,
                        size: 24,
                        color: !selectedGender
                            ? Theme.of(context).primaryColor
                            : Colors.grey,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Female',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: !selectedGender
                              ? Theme.of(context).primaryColor
                              : null,
                          fontWeight: !selectedGender ? FontWeight.bold : null,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
