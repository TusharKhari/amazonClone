// ignore_for_file: prefer_const_literals_to_create_immutables,prefer_const_constructors_in_immutables, camel_case_types,prefer_const_constructors

import 'package:amazon/features/home/services/home_services.dart';
import 'package:amazon/features/home/widgets/address_box.dart';
import 'package:amazon/features/home/widgets/carousel_slider.dart';
import 'package:amazon/features/home/widgets/deal_of_day.dart';
import 'package:amazon/features/home/widgets/top_categories.dart';
import 'package:amazon/features/search/screens/search_screen.dart';
import 'package:amazon/models/product.dart';
import 'package:flutter/material.dart';
import '../../../constants/global_variable.dart';
import '../../product_details/allProducts/all_product_screen.dart';
import '../../product_details/screens/product_details_screen.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = '/home';
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // HomeServices homeServices = HomeServices();
  Product? product;
  void navigateToAllProducts(BuildContext context) {
    Navigator.pushNamed(context, AllProducts.routeName);
  }

  void navigateToSearchScreen(String query) {
    Navigator.pushNamed(context, SearchScreen.routeName, arguments: query);
  }

  void navigateToDetailsScreen() {
    Navigator.pushNamed(
      context,
      ProductDetailScreen.routeName,
      arguments: product,
    );
  }

  @override
  Widget build(BuildContext context) {
    //final user = Provider.of<UserProvider>(context).user;
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(60),
          child: AppBar(
            flexibleSpace: Container(
              decoration: BoxDecoration(
                gradient: GlobalVariables.appBarGradient,
              ),
            ),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Container(
                    height: 42,
                    margin: EdgeInsets.only(left: 15),
                    child:
                        // material class is used for elevation
                        Material(
                      borderRadius: BorderRadius.circular(7),
                      elevation: 1,
                      child: TextFormField(
                        onFieldSubmitted: navigateToSearchScreen,
                        decoration: InputDecoration(
                            prefixIcon: InkWell(
                              onTap: () {},
                              child: Padding(
                                padding: EdgeInsets.only(left: 6),
                                child: Icon(
                                  Icons.search,
                                  color: Colors.black,
                                  size: 23,
                                ),
                              ),
                            ),
                            filled: true,
                            fillColor: Colors.white,
                            contentPadding: EdgeInsets.only(
                              top: 10,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(7),
                              ),
                              borderSide: BorderSide.none,
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(7),
                              ),
                              borderSide: BorderSide(
                                color: Colors.black38,
                                width: 1,
                              ),
                            ),
                            hintText: 'Search Amazon.Khari',
                            hintStyle: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 17,
                            )),
                      ),
                    ),
                  ),
                ),
                Container(
                  color: Colors.transparent,
                  height: 42,
                  margin: EdgeInsets.symmetric(
                    horizontal: 10,
                  ),
                  child: InkWell(
                    onTap: () {
                      //  homeServices.fetchAllProducts(context: context);
                    },
                    child: Icon(
                      Icons.mic,
                      color: Colors.black,
                      size: 25,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
        body:
            //
            SingleChildScrollView(
          child: Column(
            children: [
              Text(
                'Type a Double Story',
                style: TextStyle(
                  fontSize: 22,
                  color: Colors.green,
                ),
              ),
              AddressBox(),
              SizedBox(
                height: 10,
              ),
              TopCategories(),
              SizedBox(
                height: 10,
              ),
              CarouselImage(),
              DealOfDay(),
              Divider(
                thickness: 2,
                color: Colors.black12,
              ),
              ElevatedButton(
                onPressed: () {
                  navigateToAllProducts(context);
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Explore all the products >',
                    style: TextStyle(
                      fontSize: 22,
                    ),
                  ),
                ),
              ),
              // FutureBuilder(
              //     future: homeServices.fetchAllProducts(context: context),
              //     builder: ((context, snapshot) {
              //       return Text('data');
              //     }))
            ],
          ),
        ));
  }
}
