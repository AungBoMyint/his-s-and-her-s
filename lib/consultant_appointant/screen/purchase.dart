import 'package:flutter/material.dart';
import 'package:flutter_swipe_action_cell/core/cell.dart';
import 'package:get/get.dart';

import '../controller/home_controller.dart';

class PurchasePage extends StatelessWidget {
  const PurchasePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final HomeController _home = Get.find();
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: Get.back,
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
        title: Text(
          "Booking History",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: TextField(
              onChanged: _home.searchPurchse,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Search',
              ),
            ),
          ),
          Expanded(
            child: Obx(
              () => ListView.builder(
                itemCount: _home.getPurchase().length,
                itemBuilder: (_, i) => SwipeActionCell(
                  key: ValueKey(_home.getPurchase()[i].id),
                  trailingActions: [
                    SwipeAction(
                      icon: Icon(
                        Icons.info,
                        color: Colors.white,
                      ),
                      color: Colors.blue,
                      onTap: (CompletionHandler hander) {
                        hander(false);
                        Get.defaultDialog(
                            radius: 0,
                            title: 'Booking Detail',
                            content: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    // Text("Date"),
                                    Text(_home.getPurchase()[i].dateTime),
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    // Text("Time"),
                                    Text(_home.getPurchase()[i].timeOfDay),
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    // Text("Expert Name"),
                                    Text(_home
                                        .getExpert(
                                            _home.getPurchase()[i].expertId)
                                        .name),
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    // Text("Expert Rate"),
                                    Text(_home
                                        .getExpert(
                                            _home.getPurchase()[i].expertId)
                                        .rate),
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    // Text("Username"),
                                    Text(_home.getPurchase()[i].username),
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    // Text("Phone"),
                                    Text(_home.getPurchase()[i].phone),
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    // Text("Email"),
                                    Text(_home.getPurchase()[i].address),
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                              ],
                            ));
                      },
                    )
                  ],
                  child: Card(
                    margin: EdgeInsets.only(left: 20, right: 20, top: 10),
                    child: Padding(
                      padding: const EdgeInsets.only(
                        top: 10,
                        left: 20,
                        right: 20,
                        bottom: 10,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Username"),
                              Text(_home.getPurchase()[i].username),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Phone"),
                              Text(
                                _home.getPurchase()[i].phone,
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Expert"),
                              Text(
                                _home
                                    .getExpert(_home.getPurchase()[i].expertId)
                                    .name,
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Date"),
                              Text(
                                _home.getPurchase()[i].dateTime,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
