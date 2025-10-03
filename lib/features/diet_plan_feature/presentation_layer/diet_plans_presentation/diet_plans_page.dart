import 'package:flutter/material.dart';
import 'package:gaia_nutrition_plans/features/diet_plan_feature/domain_layer/entities/diet_plan_entity.dart';
import 'package:gaia_nutrition_plans/features/diet_plan_feature/presentation_layer/diet_plans_presentation/diet_plans_controller.dart';
import 'package:gaia_nutrition_plans/features/diet_plan_feature/presentation_layer/diet_plans_presentation/widgets/diet_plan_list_tile_widget.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class DietPlansPage extends GetView<DietPlansController> {
  const DietPlansPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PagingListener(
        controller: controller.pagingController,
        builder: (context, state, fetchNextPage) => PagedListView(
          state: state,
          fetchNextPage: () => fetchNextPage(),
          builderDelegate: PagedChildBuilderDelegate<DietPlanEntity>(
            itemBuilder: (context, item, index) =>
                DietPlanListTileWidget(dietPlan: item),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: controller.onAddPressed,
        child: const Icon(Icons.add),
      ),
    );
  }
}
