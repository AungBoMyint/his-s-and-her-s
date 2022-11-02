import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/home_controller.dart';
import '../../widget/general_card.dart';
import '../../widget/pick_up.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  void initState() {
    super.initState();
    Get.put(HomeController());
  }
  @override
  void dispose() {

    super.dispose();

    Get.delete();
;  }
  @override
  Widget build(BuildContext context) {
    final HomeController _homeController = Get.find();
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.only(bottom: 20),
        children: [
          ///Pickup
          Container(
            height: 200,
            margin: EdgeInsets.only(top: 20),
            child: Obx(
              () => ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.only(left: 20),
                itemCount: _homeController.getByType('Consultation').length > 5
                    ? 5
                    : _homeController.getByType('Consultation').length,
                itemBuilder: (_, i) => PickUp(
                  current: i,
                  expertModel: _homeController.getByType('Consultation')[i],
                ),
              ),
            ),
          ),

          ///Category 1 start
          // Padding(
          //   padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //     children: [
          //       Text(
          //         "Consultation",
          //         style: TextStyle(
          //           color: Colors.pinkAccent,
          //           fontSize: 16,
          //           wordSpacing: 2,
          //           letterSpacing: 2,
          //           fontWeight: FontWeight.bold,
          //         ),
          //       ),
          //       // GestureDetector(
          //       //   onTap: () {},
          //       //   child: Text(
          //       //     "See All",
          //       //     style: TextStyle(
          //       //       fontSize: 16,
          //       //       fontWeight: FontWeight.bold,
          //       //     ),
          //       //   ),
          //       // ),
          //     ],
          //   ),
          // ),
          Container(
            margin: EdgeInsets.only(top: 20),
            height: 210,
            child: Obx(
              () => ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.only(left: 20),
                itemCount: _homeController.getByType('Consultation').length > 5
                    ? 5
                    : _homeController.getByType('Consultation').length,
                itemBuilder: (_, i) => GeneralCard(
                  expertModel: _homeController.getByType('Consultation')[i],
                ),
              ),
            ),
          ),

          ///Category 1 end

          ///Category 1 start
          // Padding(
          //   padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //     children: [
          //       Text(
          //         "Housing",
          //         style: TextStyle(
          //           fontSize: 16,
          //           fontWeight: FontWeight.bold,
          //         ),
          //       ),
          //       GestureDetector(
          //         onTap: () {},
          //         child: Text(
          //           "See All",
          //           style: TextStyle(
          //             fontSize: 16,
          //             fontWeight: FontWeight.bold,
          //           ),
          //         ),
          //       ),
          //     ],
          //   ),
          // ),
          // Container(
          //   margin: EdgeInsets.only(top: 20),
          //   height: 210,
          //   child: Obx(
          //     () {
          //       debugPrint("****HousingCarttypelength: ${_homeController.getByType('car').length}");
          //       return ListView.builder(
          //       scrollDirection: Axis.horizontal,
          //       padding: EdgeInsets.only(left: 20),
          //       itemCount: _homeController.getByType('Housing').length > 5
          //           ? 5
          //           : _homeController.getByType('Housing').length,
          //       itemBuilder: (_, i) => GeneralCard(
          //         expertModel: _homeController.getByType('Housing')[i],
          //       ),
          //     );}
          //   ),
          // ),
          //
          // ///Category 1 end
          //
          // ///Category 1 start
          // Padding(
          //   padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //     children: [
          //       Text(
          //         "Luxurious Condominium",
          //         style: TextStyle(
          //           fontSize: 16,
          //           fontWeight: FontWeight.bold,
          //         ),
          //       ),
          //       GestureDetector(
          //         onTap: () {},
          //         child: Text(
          //           "See All",
          //           style: TextStyle(
          //             fontSize: 16,
          //             fontWeight: FontWeight.bold,
          //           ),
          //         ),
          //       ),
          //     ],
          //   ),
          // ),
          // Container(
          //   margin: EdgeInsets.only(top: 20),
          //   height: 210,
          //   child: Obx(
          //     () => ListView.builder(
          //       scrollDirection: Axis.horizontal,
          //       padding: EdgeInsets.only(left: 20),
          //       itemCount: _homeController.getByType('Luxurious Condominium').length > 5
          //           ? 5
          //           : _homeController.getByType('Luxurious Condominium').length,
          //       itemBuilder: (_, i) => GeneralCard(
          //         expertModel: _homeController.getByType('Luxurious Condominium')[i],
          //       ),
          //     ),
          //   ),
          // ),
          //
          // ///Category 1 end
          //
          // ///Category 2 start
          // Padding(
          //   padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //     children: [
          //       Text(
          //         "Villa",
          //         style: TextStyle(
          //           fontSize: 16,
          //           fontWeight: FontWeight.bold,
          //         ),
          //       ),
          //       GestureDetector(
          //         onTap: () {},
          //         child: Text(
          //           "See All",
          //           style: TextStyle(
          //             fontSize: 16,
          //             fontWeight: FontWeight.bold,
          //           ),
          //         ),
          //       ),
          //     ],
          //   ),
          // ),
          // Container(
          //   margin: EdgeInsets.only(top: 20),
          //   height: 210,
          //   child: ListView.builder(
          //     scrollDirection: Axis.horizontal,
          //     padding: EdgeInsets.only(left: 20),
          //     itemCount: _homeController.getByType('Villa').length > 5
          //         ? 5
          //         : _homeController.getByType('Villa').length,
          //     itemBuilder: (_, i) => GeneralCard(
          //       expertModel: _homeController.getByType('Villa')[i],
          //     ),
          //   ),
          // )

          ///Category 2 end
        ],
      ),
    );
  }
}
