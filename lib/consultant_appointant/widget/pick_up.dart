import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/home_controller.dart';
import '../model/expert.dart';
import '../screen/detail.dart';


class PickUp extends StatelessWidget {
  final ExpertModel expertModel;

  final int current;
  const PickUp({
    Key? key,
    required this.expertModel,
    required this.current,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final HomeController _home = Get.find();
    return GestureDetector(
      onTap: () {
        Get.to(
          DetailPage(expertModel: expertModel),
        );
      },
      child: Container(
        width: MediaQuery.of(context).size.width - 40,
        height: 200,
        margin: EdgeInsets.only(right: 20),
        // decoration: BoxDecoration(
        //   color: Colors.grey,
        //   borderRadius: BorderRadius.circular(10),
        // ),
        child: Card(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: CachedNetworkImage(
                  imageUrl: expertModel.photolink,
                  width: MediaQuery.of(context).size.width - 40,
                  height: 200,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                left: 20,
                bottom: 40,
                child: Text(
                  expertModel.name,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Positioned(
                left: 20,
                bottom: 20,
                child: Row(
                  children: List.generate(
                    _home.getByType('South Oakalarpa').length > 5
                        ? 5
                        : _home.getByType('South Oakalarpa').length,
                    (index) => Container(
                      width: 10,
                      height: 10,
                      margin: EdgeInsets.only(right: 5),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: index == current ? Colors.amber : Colors.white,
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
