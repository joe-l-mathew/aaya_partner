import 'package:aaya_partner/controller/worker_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VerificationPendingScreen extends StatelessWidget {
  const VerificationPendingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    WorkerController workerController = Get.find();
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Text(
                "Aadhar: ${workerController.userData.value!.workerVerificationStatus.isAadharVerified}"),
            Text(
                "Pancard: ${workerController.userData.value!.workerVerificationStatus.isPanVerified}"),
            Text(
                "Image: ${workerController.userData.value!.workerVerificationStatus.isImageVerified}"),
            Text(
                "Complete verification: ${workerController.userData.value!.workerVerificationStatus.isVerified}"),
          ],
        ),
      ),
    );
  }
}
