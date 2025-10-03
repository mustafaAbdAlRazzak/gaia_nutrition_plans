import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gaia_nutrition_plans/features/user_feature/presentation_layer/register_presentation/register_controller.dart';
import 'package:get/state_manager.dart';

class WeightHeightInputWidget extends GetView<RegisterController> {
  const WeightHeightInputWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextFormField(
            controller: controller.weightController,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
            ],
            decoration: const InputDecoration(
              labelText: 'Weight (kg)',
              hintText: 'Enter weight',
              prefixIcon: Icon(Icons.monitor_weight_outlined, size: 24),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Enter weight';
              }
              final weight = double.tryParse(value);
              if (weight == null || weight <= 0) {
                return 'Enter valid weight';
              }
              if (weight < 20 || weight > 500) {
                return 'Weight should be between 20-500 kg';
              }
              return null;
            },
            onChanged: (value) => controller.clearError(),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: TextFormField(
            controller: controller.heightController,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
            ],
            decoration: const InputDecoration(
              labelText: 'Height (cm)',
              hintText: 'Enter height',
              prefixIcon: Icon(Icons.height, size: 24),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Enter height';
              }
              final height = double.tryParse(value);
              if (height == null || height <= 0) {
                return 'Enter valid height';
              }
              if (height < 50 || height > 300) {
                return 'Height should be between 50-300 cm';
              }
              return null;
            },
            onChanged: (value) => controller.clearError(),
          ),
        ),
      ],
    );
  }
}
