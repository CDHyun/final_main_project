import 'package:final_main_project/view/loginpage.dart';
import 'package:final_main_project/view/register.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class First extends StatelessWidget {
  const First({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: 200.h,
            ),
            Image.asset(
              "assets/images/login2.png",
              width: 320.w,
              fit: BoxFit.fill, //이미지 가득채우기
            ),
            SizedBox(
              height: 100.h,
            ),
            ElevatedButton(
              onPressed: () {
                Get.to(const LoginPage());
              },
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  //  버튼 모양 깎기
                  borderRadius: BorderRadius.circular(5), // 10은 파라미터
                ),
                minimumSize: const Size(300, 48),
                backgroundColor: Theme.of(context).colorScheme.primary,
                foregroundColor: Theme.of(context).colorScheme.background,
              ),
              child: const Text(
                "로그인",
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            ElevatedButton(
              onPressed: () {
                Get.to(const Register());
              },
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  //  버튼 모양 깎기
                  borderRadius: BorderRadius.circular(5), // 10은 파라미터
                ),
                minimumSize: const Size(300, 48),
                backgroundColor: Theme.of(context).colorScheme.primary,
                foregroundColor: Theme.of(context).colorScheme.background,
              ),
              child: const Text(
                "회원가입",
                style: TextStyle(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
