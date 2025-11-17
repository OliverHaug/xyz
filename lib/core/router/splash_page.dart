import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../session/session_controller.dart';

class SplashPage extends GetView<SessionController> {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (controller.isLoggedIn) {
        Get.offAllNamed('/community');
      } else {
        Get.offAllNamed('/start');
      }
    });

    return const Scaffold(body: Center(child: CircularProgressIndicator()));
  }
}
