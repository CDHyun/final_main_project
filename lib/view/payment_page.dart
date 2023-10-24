import 'package:final_main_project/widget/more/card_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class PaymentPage extends StatelessWidget {
  const PaymentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('카드 등록'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            InkWell(
              onTap: () {
                // 카드
                Get.bottomSheet(
                  Container(
                    height: 600.h,
                    color: Colors.white,
                    child: cardwidget(),
                  ),
                  isScrollControlled: true,
                );
              },
              child: Container(
                width: 340.w,
                height: 150.h,
                color: Colors.grey[300],
                child: const Center(
                  child: Icon(Icons.add),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
