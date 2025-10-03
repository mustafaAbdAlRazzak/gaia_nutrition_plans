import 'package:flutter/material.dart';
import 'package:gaia_nutrition_plans/core/constant/app_spaces.dart';
import 'package:gaia_nutrition_plans/features/diet_plan_feature/presentation_layer/select_foods_presentation/select_foods_controller.dart';
import 'package:gaia_nutrition_plans/features/diet_plan_feature/presentation_layer/select_foods_presentation/widgets/food_search_item.dart';
import 'package:gaia_nutrition_plans/features/food_feature/domain_layer/entities/food_entity.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class SelectFoodsPage extends StatelessWidget {
  const SelectFoodsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SelectFoodsController>(
      builder: (controller) => Scaffold(
        appBar: AppBar(
          title: const Text('Select Foods'),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: controller.onCancel,
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.check),
              onPressed: controller.onAddSelectedFoods,
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(smallSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: mediumSpace),
              // Search Field
              TextFormField(
                controller: controller.searchController,
                onChanged: controller.onSearchChanged,
                decoration: const InputDecoration(
                  hintText: 'Search for foods...',
                  prefixIcon: Icon(Icons.search),
                ),
                textInputAction: TextInputAction.search,
              ),
              const SizedBox(height: mediumSpace),
              // Search Results
              Expanded(
                child: PagingListener(
                  controller: controller.pagingController,
                  builder: (context, state, fetchNextPage) => PagedListView(
                    state: state,
                    fetchNextPage: () => fetchNextPage(),
                    builderDelegate: PagedChildBuilderDelegate<FoodEntity>(
                      itemBuilder: (context, item, index) => FoodSearchItem(
                        food: item,
                        isSelected: controller.isFoodSelected(item.id!),
                        onTap: () => controller.whenSelectedFoodPressed(item),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
