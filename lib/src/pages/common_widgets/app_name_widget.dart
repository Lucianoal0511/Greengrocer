import 'package:flutter/material.dart';
import '../../config/custom_colors.dart';
import '../../services/utils_services.dart';

class AppNameWidget extends StatelessWidget {
  const AppNameWidget({
    Key? key,
    required this.utilsServices,
    this.greenTitleColor,
    this.textSize = 30,
  }) : super(key: key);

  final UtilsServices utilsServices;
  final Color? greenTitleColor;
  final double textSize;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        utilsServices.showToast(message: 'Bem-vindo a sua loja de mercearia :)');
      },
      child: Text.rich(TextSpan(
          style: TextStyle(
            fontSize: textSize,
          ),
          children: [
            TextSpan(
                text: 'Green',
                style: TextStyle(color: greenTitleColor ?? CustomColors.customSwatchColor)),
            TextSpan(
                text: 'grocer',
                style: TextStyle(color: CustomColors.customContrastColor)),
          ])),
    );
  }
}