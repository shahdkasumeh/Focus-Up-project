import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test/bindings/initialbindings.dart';
import 'package:test/bindings/qr_binding.dart';
import 'package:test/core/class/constant/storagehandler.dart';
import 'package:test/core/services/services.dart';
import 'package:test/localization/transliation.dart';
import 'package:test/view/screen/auth/forgetpassword/forgetpasswordscreen.dart';
import 'package:test/view/screen/auth/forgetpassword/successresetpassword.dart';
import 'package:test/view/screen/auth/loginscreen.dart';
import 'package:test/view/screen/auth/forgetpassword/resetpasswordscreen.dart';
import 'package:test/view/screen/auth/signupscreen.dart';
import 'package:test/view/screen/auth/splashscreen.dart';
import 'package:test/view/screen/auth/success_signup.dart';
import 'package:test/view/screen/home/homepage_screen.dart';
import 'package:test/view/screen/home/luckywheel_screen.dart';
import 'package:test/view/screen/home/qrcode_screen.dart';
import 'package:test/view/screen/home/study_companion_screen.dart';
import 'package:test/view/screen/reservation/discovering_the_congestion_screen.dart';
import 'package:test/view/screen/reservation/room_details_screen.dart';
import 'package:test/view/screen/reservation/typebooking_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await StorageHandler().init();
  await initialServices();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      translations: MyTranslation(),
      debugShowCheckedModeBanner: false,
      initialRoute: "/",
      initialBinding: InitialBindings(),
      getPages: [
        GetPage(name: "/", page: () => Splashscreen()),
        GetPage(name: "/login", page: () => Loginscreen()),
        GetPage(name: "/signup", page: () => Signupscreen()),
        GetPage(name: "/forgetpassword", page: () => Forgetpasswordscreen()),
        GetPage(name: "/resetpassword", page: () => Resetpasswordscreen()),
        GetPage(name: "/successsignup", page: () => SuccessSignup()),
        GetPage(
          name: "/succesresetpassword",
          page: () => Successresetpassword(),
        ),
        GetPage(name: "/homepagescreen", page: () => HomepageScreen()),
        GetPage(
          name: "/qrcodescreen",
          page: () => QrcodeScreen(),
          binding: QrBinding(),
        ),
        GetPage(name: "/typebookingscreen", page: () => TypebookingScreen()),
        GetPage(name: "/luckywheelscreen", page: () => LuckywheelScreen()),

        GetPage(
          name: "/studycompanionscreen",
          page: () => StudyCompanionScreen(),
        ),
        GetPage(name: "/roomdetailsscreen", page: () => RoomDetailsScreen()),
        GetPage(
          name: "/discoveringthecongestionscreen",
          page: () => DiscoveringTheCongestionScreen(),
        ),
      ],
    );
  }
}
