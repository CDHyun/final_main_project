import 'package:final_main_project/view/use_coin_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

Widget useCoin(BuildContext context) {
  return SizedBox(
    width: 155.w,
    height: 78.h,
    child: TextButton.icon(
      onPressed: () {
        Get.bottomSheet(
          Container(
            height: 591.h,
            color: Colors.white,
            child: const UseCoin(),
          ),
          isScrollControlled: true,
        );
      },
      icon: Icon(
        Icons.list_alt,
        color: Theme.of(context).colorScheme.primary,
      ),
      label: Text(
        '사용내역',
        style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Theme.of(context).colorScheme.primary,
            fontSize: 20),
      ),
      style: TextButton.styleFrom(
        shape: BeveledRectangleBorder(
          borderRadius: BorderRadius.circular(0.1),
        ),
      ),
    ),
  );
}
