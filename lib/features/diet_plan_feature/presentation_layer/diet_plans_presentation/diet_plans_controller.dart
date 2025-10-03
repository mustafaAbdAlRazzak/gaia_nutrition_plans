import 'package:gaia_nutrition_plans/features/diet_plan_feature/domain_layer/entities/diet_plan_entity.dart';
import 'package:gaia_nutrition_plans/features/diet_plan_feature/domain_layer/use_cases/diet_plan_use_cases/delete_diet_plan_use_case.dart';
import 'package:gaia_nutrition_plans/features/diet_plan_feature/domain_layer/use_cases/diet_plan_use_cases/get_diet_plans_use_case.dart';
import 'package:gaia_nutrition_plans/features/diet_plan_feature/presentation_layer/ai_diet_plan_generator/ai_diet_plan_generator_binding.dart';
import 'package:gaia_nutrition_plans/features/diet_plan_feature/presentation_layer/ai_diet_plan_generator/ai_diet_plan_generator_page.dart';
import 'package:gaia_nutrition_plans/features/diet_plan_feature/presentation_layer/diet_plan_details_presentation/diet_plan_details_binding.dart';
import 'package:gaia_nutrition_plans/features/diet_plan_feature/presentation_layer/diet_plan_details_presentation/diet_plan_details_view.dart';
import 'package:gaia_nutrition_plans/features/diet_plan_feature/presentation_layer/save_diet_plan_presentation/save_diet_plan_binding.dart';
import 'package:gaia_nutrition_plans/features/diet_plan_feature/presentation_layer/save_diet_plan_presentation/save_diet_plan_dialog.dart';
import 'package:gaia_nutrition_plans/shared_widgets/confirm_deletion_dialog.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class DietPlansController extends GetxController {
  final GetDietPlansUseCase getDietPlansUseCase;
  final DeleteDietPlanUseCase deleteDietPlanUseCase;
  DietPlansController({
    required this.getDietPlansUseCase,
    required this.deleteDietPlanUseCase,
  });

  List<DietPlanEntity> dietPlans = [];
  String searchQuery = '';
  int currentPage = 1;
  final int pageSize = 20;

  final ScrollController scrollController = ScrollController();
  late final PagingController<int, DietPlanEntity> pagingController;

  @override
  void onInit() {
    super.onInit();
    _setupScrollListener();
  }

  @override
  void onClose() {
    scrollController.dispose();
    pagingController.dispose();
    super.onClose();
  }

  void _setupScrollListener() {
    pagingController = PagingController<int, DietPlanEntity>(
      getNextPageKey: (state) =>
          state.lastPageIsEmpty ? null : state.nextIntPageKey,
      fetchPage: (int pageKey) => _fetchPage(pageKey),
    );
  }

  Future<List<DietPlanEntity>> _fetchPage(int pageKey) async {
    currentPage = pageKey;
    return await getDietPlansUseCase.execute(
      searchQuery: searchQuery,
      pageNumber: pageKey,
      pageSize: pageSize,
    );
  }

  Future<void> onDeletePressed(DietPlanEntity dietPlan) async {
    openConfirmDeletionDialog(() async {
      await deleteDietPlanUseCase.execute(dietPlan);
      Get.back();
      searchQuery = '';
      currentPage = 1;
      pagingController.refresh();
    });
  }

  Future<void> onAddPressed() async {
    // Show dialog to choose between manual or AI creation
    final String? choice = await Get.dialog<String>(
      AlertDialog(
        title: const Text('Create Diet Plan'),
        content: const Text('How would you like to create your diet plan?'),
        actions: [
          TextButton(
            onPressed: () => Get.back(result: 'manual'),
            child: const Text('Create Manually'),
          ),
          TextButton(
            onPressed: () => Get.back(result: 'ai'),
            child: const Text('Generate with AI'),
          ),
        ],
      ),
    );

    if (choice == null) return; // User cancelled

    bool? result;

    if (choice == 'manual') {
      // Navigate to manual creation dialog
      result = await Get.to<bool>(
        () => const SaveDietPlanDialog(),
        binding: SaveDietPlanBinding(),
      );
    } else if (choice == 'ai') {
      // Navigate to AI generation page
      result = await Get.to<bool>(
        () => const AiDietPlanGeneratorPage(),
        binding: AiDietPlanGeneratorBinding(),
      );
    }
    // Refresh the list if diet plan was created successfully
    if ((result != null && result == true)) {
      searchQuery = '';
      currentPage = 1;
      pagingController.refresh();
    }
  }

  Future<void> onEditPressed(DietPlanEntity dietPlan) async {
    final bool? result = await Get.to<bool>(
      () => const SaveDietPlanDialog(),
      binding: SaveDietPlanBinding(dietPlanEntity: dietPlan),
    );
    if (result != null && result == true) {
      searchQuery = '';
      currentPage = 1;
      pagingController.refresh();
    }
  }

  void openDietPlanDetails(DietPlanEntity dietPlan) {
    Get.to(
      () => const DietPlanDetailsView(),
      binding: DietPlanDetailsBinding(dietPlan: dietPlan),
    );
  }
}
