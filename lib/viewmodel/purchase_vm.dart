import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_main_project/model/payment_model.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PurchaseVM extends GetxController {
  var isProcessing = false.obs;
  var isComplete = false.obs;
  RxInt myCoin = 0.obs;
  var payments = RxList<HistoryModel>();
  var uId = ''.obs;

  @override
  void onInit() async {
    super.onInit();
    payments.clear(); // 기존 리스트를 비웁니다.
    await loadUserID().then((value) {
      checkCoin();
      paymentCoin();
    });
  }

  // 유저 아이디 들고오기
  Future<void> loadUserID() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    uId.value = prefs.getString("p_userId") ?? '';
  }

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  // 코인 업데이트
  Future<void> updateCoin(int coin) async {
    String userid = uId.value;

    try {
      QuerySnapshot querySnapshot = await firestore
          .collection('user')
          .where('uid', isEqualTo: userid)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        String docId = querySnapshot.docs.first.id;

        // 현재 코인 값 가져오기
        DocumentSnapshot docSnapshot =
            await firestore.collection('user').doc(docId).get();
        int currentCoin = docSnapshot.get('coin');

        // 현재 코인 값에 새로운 코인 값을 더해 업데이트
        await firestore.collection('user').doc(docId).update({
          'coin': currentCoin + coin,
        });
      }
    } catch (e) {
      print(e.toString());
      // 에러 처리를 추가합니다.
    }
  }

  // 결제
  Future<void> makePayment(int coin) async {
    isProcessing.value = true;

    await Future.delayed(const Duration(seconds: 2));
    isProcessing.value = false;

    isComplete.value = true;
    await Future.delayed(const Duration(milliseconds: 500));
    await updateCoin(coin);

    Get.back();
    Get.back();
    Get.back();
    isComplete.value = false;
  }

  // 결재 내역 등록
  Future<void> insertPayment(int coin, String cardNum, int price) async {
    String userId = uId.value;

    // 'chat' 컬렉션 참조
    CollectionReference chat = FirebaseFirestore.instance.collection('chat');

    // 'userid'를 문서로 사용
    DocumentReference userDoc = chat.doc(userId);

    // 해당 'userid' 문서 아래의 'payments' 컬렉션 참조
    CollectionReference payments = userDoc.collection('payment');

    // 'messages' 컬렉션에 채팅 내용 추가
    await payments.add(
      {
        'cardNumber': cardNum, // 카드번호
        'coin': coin,
        'price': price, // 충전이든 사용이든 여기에 넣어주기.
        'usedate': Timestamp.fromDate(DateTime.now())
      },
    );
  }

  // 결재 내역 등록
  Future<void> insertHistory(int coin) async {
    String userId = uId.value;

    // 'chat' 컬렉션 참조
    CollectionReference chat = FirebaseFirestore.instance.collection('chat');

    // 'userid'를 문서로 사용
    DocumentReference userDoc = chat.doc(userId);

    // 해당 'userid' 문서 아래의 'payments' 컬렉션 참조
    CollectionReference historys = userDoc.collection('history');

    // 'messages' 컬렉션에 채팅 내용 추가
    await historys.add(
      {
        'category': "charge", // 카드번호
        'price': coin, // 충전이든 사용이든 여기에 넣어주기.
        'coinHistory': myCoin.value,
        'usedate': Timestamp.fromDate(DateTime.now())
      },
    );
  }

  // 결재 내역 등록
  Future<void> insertHistoryAds(int coin) async {
    String userId = uId.value;

    // 'chat' 컬렉션 참조
    CollectionReference chat = FirebaseFirestore.instance.collection('chat');

    // 'userid'를 문서로 사용
    DocumentReference userDoc = chat.doc(userId);

    // 해당 'userid' 문서 아래의 'payments' 컬렉션 참조
    CollectionReference historys = userDoc.collection('history');

    // 'messages' 컬렉션에 채팅 내용 추가
    await historys.add(
      {
        'category': "ads", // 카드번호
        'price': coin, // 충전이든 사용이든 여기에 넣어주기.
        'coinHistory': myCoin.value + 50,
        'usedate': Timestamp.fromDate(DateTime.now())
      },
    );
  }

  //보유 코인 개수 가져오기
  Future<void> checkCoin() async {
    print("여기다!!!");
    try {
      String userId = uId.value;
      print("ddddddd$userId");
      FirebaseFirestore.instance
          .collection("user")
          .where("uid", isEqualTo: userId)
          .snapshots()
          .listen((querySnapshot) {
        if (querySnapshot.docs.isNotEmpty) {
          myCoin.value = querySnapshot.docs[0]['coin'];
        }
      });
    } catch (error) {
      // print("코인 가져오기 오류: $error");
    }
  }

  // 구매한 코인 내역
  Future<void> paymentCoin() async {
    try {
      String userId = uId.value;
      FirebaseFirestore.instance
          .collection("chat")
          .doc(userId)
          .collection("history")
          .orderBy('usedate', descending: true)
          .snapshots()
          .listen(
        (querySnapshot) {
          if (querySnapshot.docs.isNotEmpty) {
            payments.clear(); // 기존 리스트를 비웁니다.
            querySnapshot.docs.forEach((doc) {
              payments.add(HistoryModel.fromDocument(doc)); // 새로운 데이터를 추가합니다.
            });
            // 추가적인 정렬이 필요한 경우 아래 코드를 사용합니다.
            payments.sort((a, b) => b.usedate.compareTo(a.usedate));
          }
        },
      );
    } catch (error) {
      // 에러 처리
    }
  }

  int getTotalPaidCoins() {
    return payments
        .where((payment) => payment.category == 'charge')
        .fold(0, (sum, item) => sum + item.price);
  }

  int getTotalFreeCoins() {
    return payments
        .where((payment) => payment.category == 'ads')
        .fold(0, (sum, item) => sum + item.price);
  }
}
