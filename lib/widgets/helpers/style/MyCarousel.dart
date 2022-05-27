import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class MyCarousel extends StatelessWidget {
  MyCarousel({Key? key, required this.images}) : super(key: key);
  List<String> images;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 1, bottom: 10),
      child: CarouselSlider(
        options: CarouselOptions(
          height: 200.0,
          enableInfiniteScroll: false,
          enlargeCenterPage: true,
        ),
        items: images.map((image) {
          return Builder(
            builder: (BuildContext context) {
              return Container(
                  width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.symmetric(horizontal: 5.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child: Image.network(
                      image,
                      fit: BoxFit.cover,
                    ),
                  ));
            },
          );
        }).toList(),
      ),
    );
  }
}
