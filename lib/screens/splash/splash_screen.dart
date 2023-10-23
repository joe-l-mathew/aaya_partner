import 'package:aaya_partner/screens/auth/login_screen.dart';
import 'package:aaya_partner/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    routeLogin();
    super.initState();
  }

  routeLogin() async {
    if (!await isLoggedIn()) {
      Get.offAll(() => const LoginScreen());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.1,
          ),
          Center(
            child: SvgPicture.asset("assets/svg/aaya_logo.svg"),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.1,
          ),
          Center(
              child: LoadingAnimationWidget.discreteCircle(
            color: Theme.of(context).scaffoldBackgroundColor,
            size: 20,
          ))
        ],
      ),
    );
  }
}
