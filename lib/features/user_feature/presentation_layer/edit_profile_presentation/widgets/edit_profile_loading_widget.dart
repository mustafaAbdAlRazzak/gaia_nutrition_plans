import 'package:flutter/material.dart';
import 'package:gaia_nutrition_plans/core/constant/app_spaces.dart';

class EditProfileLoadingWidget extends StatelessWidget {
  const EditProfileLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(),
          SizedBox(height: mediumSpace),
          Text('Loading profile data...'),
        ],
      ),
    );
  }
}
