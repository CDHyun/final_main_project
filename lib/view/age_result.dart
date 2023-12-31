import 'dart:io';

import 'package:final_main_project/styles/button_style.dart';
import 'package:final_main_project/styles/text_style.dart';
import 'package:final_main_project/viewmodel/age_vm.dart';
import 'package:final_main_project/widget/age/age_percent_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class AgeResultScreen extends StatefulWidget {
  const AgeResultScreen({super.key});

  @override
  State<AgeResultScreen> createState() => _AgeResultScreenState();
}

class _AgeResultScreenState extends State<AgeResultScreen> {
  @override
  Widget build(BuildContext context) {
    final vm = Get.find<AgeVM>();

    var result = vm.result;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: Obx(
          () => Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                  width: 230.w,
                  height: 230.h,
                  child: Image.file(File(vm.croppedFaceImage.value!.path))),
              SizedBox(
                height: 20.h,
              ),
              (vm.result.value.age == '')
                  ? const CircularProgressIndicator()
                  : Text(
                      '당신의 나이는 ${result.value.age}입니다.',
                      style: onBackgroundTextStyle(context, 25),
                    ),
              SizedBox(
                height: 20.h,
              ),
              agePercentIndicator(
                  context, 10, result.value.percent10 * 100, Colors.red),
              agePercentIndicator(
                  context, 20, result.value.percent20 * 100, Colors.orange),
              agePercentIndicator(
                  context, 30, result.value.percent30 * 100, Colors.amber),
              agePercentIndicator(
                  context, 40, result.value.percent40 * 100, Colors.green),
              agePercentIndicator(
                  context, 50, result.value.percent50 * 100, Colors.blue),
              agePercentIndicator(
                  context, 60, result.value.percent60 * 100, Colors.blue[900]!),
              agePercentIndicator(
                  context, 70, result.value.percent70 * 100, Colors.purple),
              SizedBox(
                height: 50.h,
              ),
              ElevatedButton(
                style: primaryButtonStyle(context),
                onPressed: () {
                  vm.resetResults();
                  Get.back();
                },
                child: Text(
                  '다시 테스트하기',
                  style: buttonTextStyle(context),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
