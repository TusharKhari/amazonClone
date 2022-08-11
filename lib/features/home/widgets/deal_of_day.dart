import 'package:amazon/common/widgets/loader.dart';
import 'package:amazon/features/home/services/home_services.dart';
import 'package:amazon/features/product_details/screens/product_details_screen.dart';
import 'package:flutter/material.dart';

import '../../../models/product.dart';
// ignore_for_file: prefer_const_literals_to_create_immutables,prefer_const_constructors_in_immutables, camel_case_types,prefer_const_constructors

class DealOfDay extends StatefulWidget {
  DealOfDay({Key? key}) : super(key: key);

  @override
  State<DealOfDay> createState() => _DealOfDayState();
}

class _DealOfDayState extends State<DealOfDay> {
  Product? product;
  final HomeServices homeServices = HomeServices();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchDealOfDay();
  }

  void fetchDealOfDay() async {
    product = await homeServices.fetchDealOfDay(
      context: context,
    );
    setState(() {});
  }

  void navigateToDetailsScreen() {
    Navigator.pushNamed(context, ProductDetailScreen.routeName, arguments: product,);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: product == null
          ? Loader()
          : product!.name.isEmpty
              ? SizedBox()
              : GestureDetector(
                onTap: navigateToDetailsScreen,
                  child: Column(
                    children: [
                      Container(
                        alignment: Alignment.topLeft,
                        padding: EdgeInsets.only(top: 15, left: 10),
                        child: Text(
                          'Deal of the day',
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                      ),
                      Image.network(
                        product!.images[0],
                        fit: BoxFit.fitHeight,
                        height: 235,
                      ),
                      Container(
                        alignment: Alignment.topLeft,
                        padding: EdgeInsets.only(
                          left: 15,
                        ),
                        child: Text(
                          "\$ 100",
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                      ),
                      Container(
                        alignment: Alignment.topLeft,
                        padding: EdgeInsets.only(
                          left: 25,
                          top: 5,
                          right: 40,
                        ),
                        child: Text(
                          'khari',
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children:
                              //
                              product!.images
                                  .map(
                                    (e) => InkWell(
                                      child: Image.network(
                                        e,
                                        fit: BoxFit.fitWidth,
                                        width: 100,
                                        height: 100,
                                      ),
                                      onTap: navigateToDetailsScreen,
                                    ),
                                  )
                                  .toList(),
                          //   [
                          //   Image.network(
                          //     'https://images.unsplash.com/photo-1658248385692-11c301f2d5e9?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHwzNXx8fGVufDB8fHx8&auto=format&fit=crop&w=900&q=60',
                          //     fit: BoxFit.fitWidth,
                          //     width: 100,
                          //     height: 100,
                          //   ),
                          //   Image.network(
                          //     'https://images.unsplash.com/photo-1658248385692-11c301f2d5e9?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHwzNXx8fGVufDB8fHx8&auto=format&fit=crop&w=900&q=60',
                          //     fit: BoxFit.fitWidth,
                          //     width: 100,
                          //     height: 100,
                          //   ),
                          //   Image.network(
                          //     'https://images.unsplash.com/photo-1658248385692-11c301f2d5e9?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHwzNXx8fGVufDB8fHx8&auto=format&fit=crop&w=900&q=60',
                          //     fit: BoxFit.fitWidth,
                          //     width: 100,
                          //     height: 100,
                          //   ),
                          //   Image.network(
                          //     'https://images.unsplash.com/photo-1658248385692-11c301f2d5e9?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHwzNXx8fGVufDB8fHx8&auto=format&fit=crop&w=900&q=60',
                          //     fit: BoxFit.fitWidth,
                          //     width: 100,
                          //     height: 100,
                          //   ),
                          // ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                          vertical: 15,
                        ).copyWith(left: 15),
                        alignment: Alignment.topLeft,
                        child: Text(
                          "See all the deals",
                          style: TextStyle(
                            color: Colors.cyan[800],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
    );
  }
}
