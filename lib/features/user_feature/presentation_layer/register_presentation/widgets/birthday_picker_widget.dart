import 'package:flutter/material.dart';
import 'package:gaia_nutrition_plans/features/user_feature/presentation_layer/register_presentation/register_controller.dart';
import 'package:get/state_manager.dart';

class BirthdayPickerWidget extends GetView<RegisterController> {
  const BirthdayPickerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => controller.selectDate(context),
      borderRadius: BorderRadius.circular(10),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        decoration: BoxDecoration(
          border: Border.all(
            color: controller.errorMessage?.contains('birthday') == true
                ? Colors.red
                : Theme.of(
                        context,
                      ).inputDecorationTheme.border?.borderSide.color ??
                      Colors.grey,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            const Icon(Icons.calendar_today, size: 24),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                controller.formattedDate,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: controller.formattedDate == 'Select Birthday'
                      ? Colors.grey[600]
                      : null,
                ),
              ),
            ),
            const Icon(Icons.arrow_drop_down, size: 24),
          ],
        ),
      ),
    );
  }
}
