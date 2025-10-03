import 'package:flutter/material.dart';
import 'package:gaia_nutrition_plans/features/diet_plan_feature/presentation_layer/diet_plans_presentation/diet_plans_page.dart';
import 'package:gaia_nutrition_plans/features/food_feature/presentation_layer/foods_list_presentation/foods_list_page.dart';
import 'package:gaia_nutrition_plans/features/user_feature/domain_layer/use_cases/get_current_user_profile_use_case.dart';
import 'package:gaia_nutrition_plans/features/user_feature/presentation_layer/profile_presentation/profile_page.dart';
import 'package:get/get.dart';

class IndexController extends GetxController {
  int _currentIndex = 0;
  final GetCurrentUserProfileUseCase getCurrentUserUseCase;
  final PageController _pageController = PageController();

  int get currentIndex => _currentIndex;
  PageController get pageController => _pageController;

  final List<BottomNavigationBarItem> navigationItems = [
    const BottomNavigationBarItem(
      icon: Icon(Icons.table_chart_outlined),
      activeIcon: Icon(Icons.table_chart),
      label: 'Diet Plans',
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.restaurant_menu_outlined),
      activeIcon: Icon(Icons.restaurant_menu),
      label: 'Foods',
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.person_outline),
      activeIcon: Icon(Icons.person),
      label: 'Profile',
    ),
  ];

  final List<String> pageTitles = ['Diet Plans', 'Foods', 'Profile'];

  // Pages widgets
  final List<Widget> pagesWidgets = const [
    DietPlansPage(),
    FoodsListPage(),
    ProfilePage(),
  ];

  IndexController({required this.getCurrentUserUseCase});

  String get currentPageTitle => pageTitles[_currentIndex];

  void changeTab(int index) {
    if (_currentIndex != index) {
      _currentIndex = index;
      _pageController.jumpToPage(index);
      update();
    }
  }

  void onPageChanged(int index) {
    _currentIndex = index;
    update();
  }

  @override
  void onClose() {
    _pageController.dispose();
    super.onClose();
  }
}
