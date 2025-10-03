import 'package:flutter/material.dart';
import 'package:gaia_nutrition_plans/features/index_page_feature/index_controller.dart';
import 'package:get/get.dart';

class IndexPageView extends StatelessWidget {
  const IndexPageView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<IndexController>(
      builder: (controller) => PageView(
        controller: controller.pageController,
        onPageChanged: controller.onPageChanged,
        children: controller.pagesWidgets,
      ),
    );
  }
}
