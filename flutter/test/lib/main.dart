import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test/bindings/discovering_the_congestion_binding.dart';
import 'package:test/bindings/forget_password_screen_bindings.dart';
import 'package:test/bindings/home_page_screen_bindings.dart';
import 'package:test/bindings/initialbindings.dart';
import 'package:test/bindings/login_screen_bindings.dart';
import 'package:test/bindings/lucky_wheel_screen_bindings.dart';
import 'package:test/bindings/packages_screen_bindings.dart';
import 'package:test/bindings/qr_binding.dart';
import 'package:test/bindings/reset_password_screen_bindings.dart';
import 'package:test/bindings/sign_up_screen_bindings.dart';
import 'package:test/bindings/splash_screen_bindings.dart';
import 'package:test/bindings/study_companion_screen_bindings.dart';
import 'package:test/bindings/success_reset_password_screen_bindings.dart';
import 'package:test/bindings/success_sign_up_bindings.dart';
import 'package:test/bindings/type_booking_bindings.dart';
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
import 'package:test/view/screen/home/packages_screen.dart';
import 'package:test/view/screen/home/qrcode_screen.dart';
import 'package:test/view/screen/home/study_companion_screen.dart';
import 'package:test/view/screen/reservation/crowded_hall_without_reservation.dart';
import 'package:test/view/screen/reservation/discovering_the_congestion_screen.dart';
import 'package:test/view/screen/reservation/room_details_screen.dart';
import 'package:test/view/screen/reservation/typebooking_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final storage = StorageHandler();
  await storage.init();
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
        GetPage(
          name: "/",
          page: () => Splashscreen(),
          binding: SplashScreenBindings(),
        ),
        GetPage(
          name: "/login",
          page: () => Loginscreen(),
          binding: LoginScreenBindings(),
        ),
        GetPage(
          name: "/signup",
          page: () => Signupscreen(),
          binding: SignUpScreenBindings(),
        ),
        GetPage(
          name: "/forgetpassword",
          page: () => Forgetpasswordscreen(),
          binding: ForgetPasswordScreenBindings(),
        ),
        GetPage(
          name: "/resetpassword",
          page: () => Resetpasswordscreen(),
          binding: ResetPasswordScreenBindings(),
        ),
        GetPage(
          name: "/successsignup",
          page: () => SuccessSignup(),
          binding: SuccessSignUpBindings(),
        ),
        GetPage(
          name: "/succesresetpassword",
          page: () => Successresetpassword(),
          binding: SuccessResetPasswordScreenBindings(),
        ),
        GetPage(
          name: "/homepagescreen",
          page: () => HomepageScreen(),
          binding: HomePageScreenBindings(),
        ),
        GetPage(
          name: "/qrcodescreen",
          page: () => QrcodeScreen(),
          binding: QrBinding(),
        ),
        GetPage(
          name: "/typebookingscreen",
          page: () => TypebookingScreen(),
          binding: TypeBookingBindings(),
        ),
        GetPage(
          name: "/luckywheelscreen",
          page: () => LuckywheelScreen(),
          binding: LuckyWheelScreenBindings(),
        ),

        GetPage(
          name: "/studycompanionscreen",
          page: () => StudyCompanionScreen(),
          binding: StudyCompanionScreenBindings(),
        ),
        GetPage(name: "/roomdetailsscreen", page: () => RoomDetailsScreen()),
        GetPage(
          name: "/discoveringthecongestionscreen",
          page: () => DiscoveringTheCongestionScreen(),
          binding: DiscoveringTheCongestionBinding(),
        ),
        GetPage(
          name: "/crowdedhallwithoutreservation",
          page: () => CrowdedHallWithoutReservation(),
        ),
        GetPage(
          name: "/packagesscreen",
          page: () => PackagesScreen(),
          binding: PackagesScreenBindings(),
        ),
      ],
    );
  }
}
