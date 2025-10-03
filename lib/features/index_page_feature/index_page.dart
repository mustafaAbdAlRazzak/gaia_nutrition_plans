import 'package:flutter/material.dart';
import 'package:gaia_nutrition_plans/features/index_page_feature/index_controller.dart';
import 'package:gaia_nutrition_plans/features/index_page_feature/widgets/custom_bottom_navigation.dart';
import 'package:gaia_nutrition_plans/features/index_page_feature/widgets/index_page_view.dart';
import 'package:gaia_nutrition_plans/features/root_feature/presentation_layer/gaia_nutrition_plans_app_controller.dart';
import 'package:get/get.dart';

class IndexPage extends StatelessWidget {
  const IndexPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<IndexController>(
      builder: (controller) => Scaffold(
        appBar: AppBar(
          title: Text(controller.currentPageTitle),
          actions: [
            GetBuilder<GaiaNutritionPlansAppController>(
              builder: (controller) => IconButton(
                icon: Icon(
                  controller.isDarkMode ? Icons.light_mode : Icons.dark_mode,
                ),
                onPressed: controller.toggleTheme,
              ),
            ),
          ],
        ),
        body: const IndexPageView(),
        bottomNavigationBar: const CustomBottomNavigation(),
      ),
    );
  }
}
