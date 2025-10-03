import 'package:flutter/material.dart';
import 'package:gaia_nutrition_plans/features/food_feature/presentation_layer/foods_list_presentation/widgets/foods_list_section.dart';
import 'package:gaia_nutrition_plans/features/food_feature/presentation_layer/foods_list_presentation/widgets/foods_search_section.dart';

class FoodsListPage extends StatelessWidget {
  const FoodsListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Column(
        children: [
          FoodsSearchSection(),
          Expanded(child: FoodsListSection()),
        ],
      ),
    );
  }
}
