import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test/core/class/constant/apptheme.dart';
import 'package:test/core/services/services.dart';

class LocaleController extends GetxController {
  ThemeData apptheme = themeEnglish;
  Locale? language;
  MyServices myServices = Get.find();
  @override
  void onInit() {
    String? sharedpreflang = myServices.sharedPreferences.getString("lang");
    if (sharedpreflang == "ar") {
      language = const Locale("ar");
      apptheme = themeArabic;
    } else if (sharedpreflang == "en") {
      language = const Locale("en");
      apptheme = themeEnglish;
    } else {
      language = Locale(Get.deviceLocale!.languageCode);
      apptheme = themeEnglish;
    }
    super.onInit();
  }

  changelang(String langcode) {
    Locale locale = Locale(langcode);
    myServices.sharedPreferences.setString("lang", langcode);
    apptheme = langcode == "ar" ? themeArabic : themeEnglish;
    Get.changeTheme(apptheme);
    Get.updateLocale(locale);
  }
}
