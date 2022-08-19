import 'package:amazon/common/widgets/loader.dart';
import 'package:amazon/features/home/services/home_services.dart';
import 'package:amazon/features/product_details/allProducts/all_product_screen.dart';
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

  void navigateToAllProducts(BuildContext context) {
    Navigator.pushNamed(context, AllProducts.routeName);
  }

  void navigateToDetailsScreen() {
    Navigator.pushNamed(
      context,
      ProductDetailScreen.routeName,
      arguments: product,
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // fetchAllProducts();
    fetchDealOfDay();
  }

  // void fetchAllProducts() async {
  //   product = await homeServices.fetchAllProducts(
  //     context: context,
  //   );
  //   setState(() {});
  //  }
  void fetchDealOfDay() async {
    product = await homeServices.fetchDealOfDay(
      context: context,
    );
    setState(() {});
  }


  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: product == null
          ? Loader()
          : product!.name.isEmpty
              ? SizedBox()
              : Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                        InkWell(
                          onTap: () {
                            navigateToAllProducts(context);
                          },
                          child: Text(
                            "See all the deals  ",
                            style: TextStyle(
                              color: Colors.cyan[800],
                              fontSize: 22,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                      ],
                    ),
                    InkWell(
                      onTap: navigateToDetailsScreen,
                      child: Image.network(
                        product!.images[0],
                        fit: BoxFit.fitHeight,
                        height: 235,
                      ),
                    ),
                    Container(
                      alignment: Alignment.topLeft,
                      padding: EdgeInsets.only(
                        left: 15,
                      ),
                      child: Text(
                        "",
                        // "\$ 100",
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
                        '',
                        // 'khari',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    // SingleChildScrollView(
                    //   scrollDirection: Axis.horizontal,
                    //   child: Row(
                    //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //     children:
                    //         //
                    //         product!.images
                    //             .map(
                    //               (e) => InkWell(
                    //                  onTap: navigateToDetailsScreen,
                    //                  child: Padding(
                    //                   padding: const EdgeInsets.symmetric(horizontal: 8),
                    //                   child: Image.network(
                    //                     e,
                    //                     fit: BoxFit.fitWidth,
                    //                     width: 100,
                    //                     height: 100,
                    //                   ),
                    //                 ),
                    //               ),
                    //             )
                    //             .toList(),

                    //   ),
                    // ),

                    // Container(
                    //   padding: EdgeInsets.symmetric(
                    //     vertical: 15,
                    //   ).copyWith(left: 15),
                    //   alignment: Alignment.topLeft,
                    //   child:
                    //   InkWell(
                    //     onTap: () {
                    //       navigateToAllProducts(context);
                    //     },
                    //     child: Text(
                    //       "See all the deals",
                    //       style: TextStyle(
                    //         color: Colors.cyan[800],
                    //       ),
                    //     ),
                    //   ),
                    // ),
                   
                    //   FutureBuilder(
                    // future: homeServices.fetchAllProducts(context: context),
                    // builder: ((context, snapshot) {
                    //   return Text('data');
                    // }))
                  ],
                ),
    );
  }
}
