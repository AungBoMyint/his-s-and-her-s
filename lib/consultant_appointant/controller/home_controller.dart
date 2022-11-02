import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import '../../ui/routes/main_route.dart';
import '../data/constant.dart';
import '../model/expert.dart';
import '../model/purchase.dart';
import '../model/user.dart';
import '../service/auth.dart';
import '../service/database.dart';



class HomeController extends GetxController {
  final Auth _auth = Auth();
  final Database _database = Database();

  final RxBool authorized = false.obs;
  final Rx<AuthUser> user = AuthUser().obs;

  final RxBool phoneState = false.obs;

  final TextEditingController phoneController = TextEditingController();
  final TextEditingController verificationController = TextEditingController();

  final RxString _codeSentId = ''.obs;
  final RxInt _codeSentToken = 0.obs;

  Future<void> login() async {
    try {
      if (_codeSentId.value.isNotEmpty || phoneState.value) {
        await confirm();
        return;
      }
      await _auth.login(
        phoneNumber: phoneController.text,
        verificationCompleted: (PhoneAuthCredential phoneAuthCredential) {},
        codeAutoRetrievalTimeout: (String verificationId) {},
        codeSent: (String verificationId, int? forceResendingToken) {
          _codeSentId.value = verificationId;
          _codeSentToken.value = forceResendingToken ?? 0;
          update([_codeSentId, _codeSentToken]);
        },
        verificationFailed: (FirebaseAuthException error) {},
      );
      phoneState.value = true;
    } catch (e) {
      print("login error $e");
    }
  }

  Future<void> confirm() async {
    try {
      await _auth.loginWithCerdential(PhoneAuthProvider.credential(
        verificationId: _codeSentId.value,
        smsCode: verificationController.text,
      ));
      _codeSentId.value = '';
      phoneState.value = false;
      phoneController.clear();
      verificationController.clear();
    } catch (e) {
      print("confirm error is $e");
    }
  }

  Future<void> logout() async {
    try {
      await _auth.logout();
    } catch (e) {
      print("logout error is $e");
    }
  }

  // Future<void> uploadProfile() async {
  //   try {
  //     final XFile? _file =
  //         await _imagePicker.pickImage(source: ImageSource.gallery);

  //     if (_file != null) {
  //       await _api.uploadFile(
  //         _file.path,
  //         fileName: user.value.user?.uid,
  //         folder: profileUrl,
  //       );
  //       await _database.write(
  //         expertCollection,
  //         data: {
  //           'link': user.value.user?.uid,
  //         },
  //         path: user.value.user?.uid,
  //       );
  //       user.value.update(
  //         newProfileImage: '$baseUrl$profileUrl${user.value.user?.uid}',
  //       );
  //       update([user]);
  //     }
  //   } catch (e) {
  //     print("profile upload error $e");
  //   }
  // }

  @override
  void onInit() {
    super.onInit();

    // Minim commodo sit eiusmod sunt ea ex. Laborum elit duis ullamco dolore. Cillum duis quis aute consequat eu ut id anim occaecat commodo consectetur minim tempor qui. In consectetur adipisicing deserunt aliqua labore.

// Lorem aliquip nostrud laboris esse eu proident eu sit consectetur commodo sint. Sit commodo ut amet cillum. Consectetur occaecat aliquip consectetur cillum.

// Deserunt anim nisi esse pariatur exercitation esse quis quis et sunt magna aliqua. Nulla nisi commodo nulla et magna labore duis culpa esse duis reprehenderit aute id irure. Do est adipisicing laboris tempor duis ipsum.

    _auth.onAuthChange().listen((_) async {
      if (_ == null) {
        authorized.value = false;
        user.value = AuthUser();
      }
      if (_ != null) {
        ///To create admin role
        await _database.write(
          userCollection,
          path: _.uid,
          data: {
            'uid': _.uid,
            'role': 'admin',
          },
        );
        final DocumentSnapshot<Map<String, dynamic>> _userData =
            await _database.read(userCollection, path: _.uid);
        authorized.value = true;
        user.value = AuthUser(
          user: _,
          isAdmin: _userData.data()?['role'] == 'admin',
        );

        if (user.value.isAdmin) getAdminPurchase;
        getMyPurchase;
      }

    });
    _expertsListener;
  }

  final RxList<ExpertModel> _experts = <ExpertModel>[].obs;
  final RxList<ExpertModel> _searchExperts = <ExpertModel>[].obs;

  final RxString expertId = ''.obs;

  void setEditExpertId(String id) => expertId.value = id;

  List<ExpertModel> getAllExpert() =>
      _searchExperts.isEmpty ? _experts : _searchExperts;

  List<ExpertModel> getSearchExpert() =>
      _searchExperts.isEmpty ? _experts : _searchExperts;

  void searchExpert(String e) => _searchExperts.value = _experts
      .where(
        (p0) => p0.name.toLowerCase().contains(e.toLowerCase()),
      )
      .toList();

  ExpertModel getExpert(String id) {
    try {
      return _experts.firstWhere(
        (p0) => p0.id == id,
      );
    } catch (e) {
      return ExpertModel(
          photolink: '',
          photolink2: '',
          photolink3: '',
          name: '',
          type: '',
          description: '',
          job: '',
          rate: '',
          rating: '',
          rating2: '',
          jobTitle: '',
          jobDescription: '',
          propertyAddress: '',


      );
    }
  }

  void disposeSearch() => _searchExperts.clear();

  List<ExpertModel> getByType(String type) =>
      _experts.where((p0) {
        if(p0.type==type){
          debugPrint("***Cartypefound");
        }else{debugPrint("***CartypNOtfound");}
        return p0.type == type;
      }).toList();

  Future<void> deleteExpert(String id) async {
    if (isloading.value) return;
    isloading.value = true;
    try {
      await _database.delete(expertCollection, path: id);
    } catch (e) {
      print(e);
    }
    isloading.value = false;
  }

  StreamSubscription get _expertsListener =>
      _database.watch(expertCollection).listen((event) {
        if (event.docs.isEmpty) {
          _experts.clear();
        } else {
          _experts.value = event.docs
              .map((e) => ExpertModel.fromJson(e.data(), e.id))
              .toList();
        }
      });

  ///is loading
  final RxBool isloading = false.obs;

  ///date
  final Rx<DateTime> bookingDate = DateTime.now().obs;

  void setBookingDate(DateTime dateTime) {
    bookingDate.value = dateTime;
  }

  ///time
  final Rx<TimeOfDay> bookingTime = TimeOfDay.now().obs;

  void setBookingTime(TimeOfDay timeOfDay) {
    bookingTime.value = timeOfDay;
  }

  final Rx<String> address = ''.obs;

  final Rx<String> name = ''.obs;

  final Rx<String> phone = ''.obs;

  void setAddress(String data) {
    address.value = data;
  }

  void setName(String data) {
    name.value = data;
  }

  void setPhone(String data) {
    phone.value = data;
  }

  Future<void> booking(String id) async {
    if (isloading.value) return;
    isloading.value = true;
    try {
       _database.write(
        purchaseCollection,
        data: PurchaseModel(
          dateTime:
              "${bookingDate.value.year}/${bookingDate.value.month}/${bookingDate.value.day}",
          timeOfDay: "${bookingTime.value.hour}:${bookingTime.value.minute}",
          address: address.value,
          username: name.value,
          phone: phone.value,
          expertId: id,
          userId: "",
        ).toJson(),
      ).then((value){
         Get.snackbar('Booking Status', 'Your booking has been confirmed');
         Navigator.popUntil(Get.context!, ModalRoute.withName(MainRoute.routeName));
       });

      //Future.delayed(const Duration(seconds: 2),() => Get.back())// Get.back();
    } catch (e) {
      print(e);
    }
    setBookingDate(DateTime.now());
    setBookingTime(TimeOfDay.now());
    setAddress('');
    setPhone('');
    setName('');
    isloading.value = false;
  }

  Future<void> deleteBooking(String id) async {
    if (isloading.value) return;
    isloading.value = true;
    try {
      await _database.delete(purchaseCollection, path: id);
    } catch (e) {
      print(e);
    }
    isloading.value = false;
  }

  ///my booking
  final RxList<PurchaseModel> myPurchase = <PurchaseModel>[].obs;

  StreamSubscription get getMyPurchase => _database
          .watchWhere(
        purchaseCollection,
        user.value.user!.uid,
      )
          .listen((event) {
        if (event.docs.isEmpty) {
          myPurchase.clear();
        } else {
          myPurchase.value = event.docs
              .map((e) => PurchaseModel.fromJson(e.data(), e.id))
              .toList();
        }
      });

  final RxList<PurchaseModel> _adminPurchase = <PurchaseModel>[].obs;

  final RxList<PurchaseModel> _searchPurchse = <PurchaseModel>[].obs;

  List<PurchaseModel> getPurchase() =>
      _searchPurchse.isEmpty ? _adminPurchase : _searchPurchse;

  void searchPurchse(String e) => _searchPurchse.value = _adminPurchase
      .where(
        (p0) =>
            p0.dateTime.toLowerCase().contains(e.toLowerCase()) ||
            p0.username.toLowerCase().contains(e.toLowerCase()) ||
            getExpert(p0.expertId).name.toLowerCase().contains(e) ||
            p0.phone.toLowerCase() == e.toLowerCase() ||
            p0.address.toLowerCase().contains(e),
      )
      .toList();

  StreamSubscription get getAdminPurchase => _database
          .watch(
        purchaseCollection,
      )
          .listen((event) {
        if (event.docs.isEmpty) {
          _adminPurchase.clear();
        } else {
          _adminPurchase.value = event.docs
              .map((e) => PurchaseModel.fromJson(e.data(), e.id))
              .toList();
        }
      });
}
