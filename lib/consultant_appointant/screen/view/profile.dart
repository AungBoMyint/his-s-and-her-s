import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

import '../../controller/home_controller.dart';
import '../../data/constant.dart';
import '../../routes/routes.dart';

class ProfileView extends GetView<HomeController> {
  const ProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => controller.authorized.value ? _LoginUser() : LogoutUser(),
    );
  }
}

class LogoutUser extends GetView<HomeController> {
  const LogoutUser({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        SizedBox(
          height: 50,
        ),
    Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, bottom: 10),
      child: Image.asset("assets/logo.png",
    height: 120,
      ),
    ),
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
          child: Obx(
            () => TextFormField(
              controller: controller.phoneState.value
                  ? controller.verificationController
                  : controller.phoneController,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: controller.phoneState.value
                    ? 'Enter your code'
                    : 'Phone Number(+959***)',
              ),
            ),
          ),
        ),
        Container(
          width: double.infinity,
          height: 50,
          margin: const EdgeInsets.only(top: 30, right: 20, left: 20),
          child: Obx(
            () => ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(homeIndicatorColor),
              ),
              onPressed: controller.login,
              child: Text(
                controller.phoneState.value ? 'Verify' : 'Send Code',
              ),
            ),
          ),
        )
      ],
    );
  }
}

class _LoginUser extends StatelessWidget {
  const _LoginUser({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final HomeController controller = Get.find();
    return Column(
      children: [
        Container(
          width: double.infinity,
          height: 150,
          margin: EdgeInsets.only(left: 20, right: 20, top: 20),
          child: Card(
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 50),
                  child: ClipRRect(
                    // borderRadius: BorderRadius.circular(100),
                    child: Image.asset("assets/logo.png",
                      height: 100,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Expanded(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Obx(
                      () => Text(
                        controller.user.value.user!.phoneNumber!,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ))
              ],
            ),
          ),
        ),
        Obx(
          () => controller.user.value.isAdmin
              ? Expanded(
                  child: _AdminPanel(),
                )
              : Container(),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: controller.logout,
                child: Text(
                  "Logout",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.amber,
                  ),
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}

class _AdminPanel extends StatelessWidget {
  const _AdminPanel({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(top: 40, bottom: 20, left: 20, right: 20),
          child: Text(
            "Admin Feature",
            style: TextStyle(
              fontSize: 23,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            Get.toNamed(createExpertPage);
          },
          child: Container(
            height: 60,
            margin: EdgeInsets.only(
              left: 20,
              right: 20,
            ),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Create New Property"),
                    Icon(Icons.upload),
                  ],
                ),
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            Get.toNamed(managePage);
          },
          child: Container(
            height: 60,
            margin: EdgeInsets.only(
              left: 20,
              right: 20,
            ),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Manage Property"),
                    Icon(Icons.edit),
                  ],
                ),
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            Get.toNamed(purchasePage);
          },
          child: Container(
            height: 60,
            margin: EdgeInsets.only(
              left: 20,
              right: 20,
            ),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Appointments"),
                    Icon(Icons.shop),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
