import 'package:final_main_project/widget/more/charge/coin_Charging_widget.dart';
import 'package:final_main_project/widget/more/etc_widget.dart';
import 'package:final_main_project/widget/more/holding_coin_widget.dart';
import 'package:final_main_project/widget/more/logout_widget.dart';
import 'package:final_main_project/widget/more/notification_widget.dart';
import 'package:final_main_project/widget/more/card/card_widget.dart';
import 'package:final_main_project/widget/more/use/use_coin_widget.dart';
import 'package:final_main_project/widget/more/userpage_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class More extends StatelessWidget {
  const More({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: false,
          automaticallyImplyLeading: false,
          title: const Text(
            "MAPPY 더보기",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: Container(
                width: 360.w,
                height: 160.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Theme.of(context).colorScheme.inversePrimary,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 15.h,
                    ),
                    // 유저 코인 보유 사항
                    holdingCoin(context),
                    // 끝
                    SizedBox(
                      height: 10.h,
                    ),
                    // 유저 충전, 사용
                    Container(
                      width: 315.w,
                      height: 40.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Theme.of(context).colorScheme.background,
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // 충전하기
                          coinCharging(context),
                          const Padding(
                            padding: EdgeInsets.fromLTRB(0, 8, 0, 8),
                            child: VerticalDivider(
                              thickness: 1,
                              width: 5,
                            ),
                          ),
                          // 사용 내역
                          useCoin(context)
                        ],
                      ),
                    ), // 유저 금액 내역끝
                  ],
                ),
              ),
            ),
            // 유저기본정보 끝
            SizedBox(
              height: 30.h,
            ),
            // 유저 프로필
            userpage(context),
            // 유저 프로필 끝
            SizedBox(
              height: 25.h,
            ),
            // 카드등록
            cardWidget(context),
            // 카드등록 끝
            SizedBox(
              height: 25.h,
            ),
            // 알람
            notification(context),
            // 알람 끝
            SizedBox(
              height: 25.h,
            ),
            // 기타
            etcWidget(context),
            // 기타 끝
            SizedBox(
              height: 25.h,
            ),
            // 로그아웃
            logOut(context),
            // 로그아웃 끝
          ],
        ),
      ),
    );
  }
}
