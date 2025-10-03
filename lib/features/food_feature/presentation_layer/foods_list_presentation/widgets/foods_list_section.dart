import 'package:flutter/material.dart';
import 'package:gaia_nutrition_plans/features/food_feature/domain_layer/entities/food_entity.dart';
import 'package:gaia_nutrition_plans/features/food_feature/presentation_layer/foods_list_presentation/foods_list_controller.dart';
import 'package:gaia_nutrition_plans/features/food_feature/presentation_layer/foods_list_presentation/widgets/food_list_tile_widget.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class FoodsListSection extends GetView<FoodsListController> {
  const FoodsListSection({super.key});

  @override
  Widget build(BuildContext context) {
    return PagingListener(
      controller: controller.pagingController,
      builder: (context, state, fetchNextPage) => PagedListView(
        state: state,
        fetchNextPage: () => fetchNextPage(),
        builderDelegate: PagedChildBuilderDelegate<FoodEntity>(
          itemBuilder: (context, item, index) => FoodListTileWidget(food: item),
        ),
      ),
    );
  }
}
