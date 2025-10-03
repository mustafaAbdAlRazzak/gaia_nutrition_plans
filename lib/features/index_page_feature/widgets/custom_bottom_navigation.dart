import 'package:flutter/material.dart';
import 'package:gaia_nutrition_plans/features/index_page_feature/index_controller.dart';
import 'package:get/get.dart';

class CustomBottomNavigation extends StatelessWidget {
  const CustomBottomNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<IndexController>(
      builder: (controller) => BottomNavigationBar(
        currentIndex: controller.currentIndex,
        onTap: controller.changeTab,
        items: controller.navigationItems,
      ),
    );
  }
}
