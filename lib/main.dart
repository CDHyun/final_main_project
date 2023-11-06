import 'package:final_main_project/view/firstpage.dart';
import 'package:final_main_project/view/tabbar_screen.dart';
import 'package:final_main_project/viewmodel/card_vm.dart';
import 'package:final_main_project/viewmodel/notification_vm.dart';
import 'package:final_main_project/viewmodel/theme_obs.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'firebase_options.dart';
import 'package:get/get.dart';

void main() async {
  // 최적화
  WidgetsFlutterBinding.ensureInitialized();
  // env파일 불러오기
  await dotenv.load();
  // 타임 시간대 설정
  tz.initializeTimeZones();
  tz.setLocalLocation(tz.getLocation('Asia/Seoul'));
  // 알람 권한 설정
  Get.put(NotificationVm());
  Future.delayed(const Duration(seconds: 3),
      () => Get.find<NotificationVm>().requestNotificationPermission());

  // 카카오
  KakaoSdk.init(nativeAppKey: 'faa13ab1a0485a4e5528d40c061caaef');

  // 파이어베이스 초기화
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

const seedColor = Color(0xff309cff);

class MyApp extends StatelessWidget {
  final themeController = Get.put(ThemeController());
  final userid = Get.put(CardVm());

  MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    CardVm().logout();

    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return Obx(() => GetMaterialApp(
              title: 'Flutter Demo',
              theme: ThemeData(
                colorScheme: ColorScheme.fromSeed(
                  // seedColor: Color.fromARGB(77, 0, 255, 68),
                  seedColor: Colors.redAccent,
                  brightness: themeController.isDarkMode.value
                      ? Brightness.dark
                      : Brightness.light,
                ),
                textTheme: GoogleFonts.notoSansNKoTextTheme(
                  Theme.of(context).textTheme,
                ),
                useMaterial3: true,
              ),
              home: userid.uId.value != ''
                  ? const TabBarScreen()
                  : const First(),
            ));
      },
    );
  }
}
