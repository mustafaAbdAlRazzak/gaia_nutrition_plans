import 'package:flutter/material.dart';
import 'package:gaia_nutrition_plans/core/constant/app_spaces.dart';
import 'package:gaia_nutrition_plans/features/diet_plan_feature/domain_layer/entities/diet_plan_entity.dart';
import 'package:gaia_nutrition_plans/features/diet_plan_feature/presentation_layer/diet_plans_presentation/diet_plans_controller.dart';
import 'package:get/get.dart';

class DietPlanListTileWidget extends GetView<DietPlansController> {
  final DietPlanEntity dietPlan;

  const DietPlanListTileWidget({super.key, required this.dietPlan});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () => controller.openDietPlanDetails(dietPlan),
      contentPadding: const EdgeInsets.all(smallSpace),
      title: Text(dietPlan.name),
      trailing: PopupMenuButton<String>(
        icon: const Icon(Icons.more_vert),
        itemBuilder: (BuildContext context) => [
          PopupMenuItem<String>(
            value: 'edit',
            onTap: () => controller.onEditPressed(dietPlan),
            child: const Text('Edit'),
          ),
          PopupMenuItem<String>(
            onTap: () => controller.onDeletePressed(dietPlan),
            value: 'delete',
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }
}
