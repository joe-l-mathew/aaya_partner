import 'package:aaya_partner/theme/colors/dark_colors.dart';
import 'package:aaya_partner/theme/colors/light_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class ThemeController extends GetxController {
  RxBool isDarkMode = false.obs;

  ThemeData get theme => isDarkMode.value ? _darkTheme : _lightTheme;

  ThemeData get _lightTheme => ThemeData(
      primaryColor: LightColors.primaryColor,
      scaffoldBackgroundColor: LightColors.scaffoldColor,
      disabledColor: LightColors.bottomContainerColor,
      secondaryHeaderColor: LightColors.secondaryColor,
      highlightColor: LightColors.teritioryColor,
      cardColor: LightColors.bottomNavColor
      // bottomAppBarColor: LightColors.bottomNavColor
      ,
      dividerColor: LightColors.dividerColor

      // Define other properties for the light theme.
      );

  ThemeData get _darkTheme => ThemeData(
      primaryColor: DarkColors.primaryColor,
      scaffoldBackgroundColor: DarkColors.scaffoldColor

      // Define other properties for the dark theme.
      );

  void toggleTheme() {
    isDarkMode.value = !isDarkMode.value;
  }
}
