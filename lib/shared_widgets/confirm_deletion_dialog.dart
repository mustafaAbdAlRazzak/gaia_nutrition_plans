import 'package:get/get.dart';

void openConfirmDeletionDialog(void Function() onConfirm) {
  Get.defaultDialog(
    title: "Confirm Deletion",
    middleText: "Are you sure you want to delete this diet plan?",
    textConfirm: "Delete",
    textCancel: "Cancel",
    radius: 12,
    onConfirm: onConfirm,
    onCancel: () {
      Get.back();
    },
  );
}
