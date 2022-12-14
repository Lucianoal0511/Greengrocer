import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:greengrocer/src/pages_routes/app_pages.dart';
import '../../config/custom_colors.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Future.delayed(const Duration(seconds: 2), () {
      // Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (c) {
      //   return const SignInScreen();
      // }));
      //No lugar do Navigator
      Get.offNamed(PagesRoutes.signInRoute);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              CustomColors.customSwatchColor,
              CustomColors.customSwatchColor.shade700,
            ],
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text.rich(TextSpan(
                style: const TextStyle(
                  fontSize: 40,
                ),
                children: [
                  const TextSpan(
                    text: 'Green',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  TextSpan(
                    text: 'grocer',
                    style: TextStyle(
                      color: CustomColors.customContrastColor,
                    ),
                  )
                ])),
            const SizedBox(
              height: 10,
            ),
            const CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation(Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
