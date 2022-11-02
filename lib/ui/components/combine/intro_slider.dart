import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'intro_slider_item.dart';

class IntroSlider extends StatelessWidget {
  List<String> photos;
  IntroSlider({required
    this.photos
  });
  @override
  Widget build(BuildContext context) {

    return (photos.length == 0 ) ?
    Container(color: Colors.grey,) :
    Container(
      height: 28.125 * 7,
      //color: Colors.blueAccent,
      child: CarouselSlider(
          options: CarouselOptions(
            autoPlayCurve: Curves.fastOutSlowIn,
            enlargeCenterPage: true,
            autoPlay: true,
            initialPage: 2,
            height: 28.125 * 8,
            enableInfiniteScroll: true,
          ),
          items: List.generate(photos.length, (index) => Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              child: IntroSliderItem(photo:photos[index]),
            ),
          ))
      ),
    );
  }
}
