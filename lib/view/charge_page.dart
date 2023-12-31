import 'package:final_main_project/viewmodel/purchase_vm.dart';
import 'package:final_main_project/widget/more/charge/charge_widget.dart';
import 'package:final_main_project/widget/more/untiy_Ads_Widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ChargeWidget extends StatelessWidget {
  const ChargeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = Get.put(PurchaseVM());
    return Scaffold(
      appBar: AppBar(
        title: const Text('코인 구매'),
        shape: const Border(
          bottom: BorderSide(
            color: Colors.grey,
            width: 0.5,
          ),
        ),
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          Text(
            '현재 보유 코인',
            style: TextStyle(color: Theme.of(context).colorScheme.onBackground),
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.monetization_on,
                color: Colors.green,
                size: 25,
              ),
              Obx(
                () {
                  // 코인 변화 rx로 실시간관리
                  return Text(
                    vm.myCoin.value.toString(),
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onBackground,
                      fontSize: 20,
                      fontFamily: 'Lato',
                      fontWeight: FontWeight.w700,
                      height: 0,
                    ),
                  );
                },
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            width: 360.w,
            height: MediaQuery.of(context).size.height * 0.685,
            color: Theme.of(context).colorScheme.onInverseSurface,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                adsWidget(context),
                SizedBox(
                  height: 15.h,
                ),
                coinTile("코인 100개", "₩ 1,500", context),
                SizedBox(
                  height: 15.h,
                ),
                coinTile("코인 200개", "₩ 3,000", context),
                SizedBox(
                  height: 15.h,
                ),
                coinTile("코인 300개", "₩ 4,400", context),
                SizedBox(
                  height: 15.h,
                ),
                coinTile("코인 500개", "₩ 7,500", context),
                SizedBox(
                  height: 15.h,
                ),
                coinTile("코인 1000개", "₩ 15,000", context),
              ],
            ),
          )
        ],
      ),
    );
  }
}
