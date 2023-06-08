import 'package:amazon/constants/global_variable.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class CarouselImage extends StatelessWidget {
  const CarouselImage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    VoidCallback? onTap;
    List onClick = [
      " print('object 1');"
          " print('object 2');"
          " print('object 3');"
          " print('object 4');"
          " print('object 5');"
    ];
    return CarouselSlider(
      options: CarouselOptions(
        //autoPlay: true,
        viewportFraction: 1,
        height: 200,
      ), 
      items:
          //
          GlobalVariables.carouselImages.map((i) {
        return
            //
            Builder(
          builder: (BuildContext context) {
            //print(i);
            return Image.network(
              i,
              fit: BoxFit.cover,
              height: 200,
            );
          },
        );
      }).toList(),
      //
  
      //
    );
  }
}

    //       GlobalVariables.carouselImages.map((e) {
      //  //   print(e);
      //     return InkWell(
      //       onTap: () {
      //         onClick.map((i) {
      //           return print(i);
      //         });
      //       },
      //       child: Image.network(
      //         e,
      //         fit: BoxFit.cover,
      //         height: 200,
      //       ),
      //     );
      //   }).toList(),