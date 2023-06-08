// ignore_for_file: prefer_const_literals_to_create_immutables,prefer_const_constructors_in_immutables, camel_case_types,prefer_const_constructors

import 'package:amazon/constants/global_variable.dart';
import 'package:amazon/features/admin/screens/analytics_screen.dart';
import 'package:amazon/features/admin/screens/order_screen.dart';
import 'package:amazon/features/admin/screens/post_screen.dart';
import 'package:flutter/material.dart';

import '../../account/services/account_services.dart';
import '../../product_details/allProducts/all_product_screen.dart';
import '../../search/screens/search_screen.dart';

class AdminScreen extends StatefulWidget {
  AdminScreen({Key? key}) : super(key: key);

  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  int _page = 0;
  double bottomBarWidth = 42;
  double bottomBarBorderWidth = 5;

  List<Widget> pages = [
    PostScreen(),
    AnalyticsScreen(),
    // Center(
    //   child: Text('Analytics'),
    // ),
    OrdersScreen(),
    // Center(
    //   child: Text('cart'),
    // ),
  ];

  void updatePage(int page) {
    setState(() {
      _page = page;
    });
  }

//  void navigateToAllProducts(BuildContext context) {
//     Navigator.pushNamed(context, AllProducts.routeName);
//   }

  void navigateToSearchScreen(String query) {
    Navigator.pushNamed(context, SearchScreen.routeName, arguments: query);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: AppBar(
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: GlobalVariables.appBarGradient,
            ),
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                alignment: Alignment.topLeft,
                child: Image.asset(
                  'assets/images/amazon_in.png',
                  width: 80,
                  height: 45,
                  color: Colors.black,
                ),
              ),
              _page == 0 ?
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
                      cursorHeight: 0,
                      cursorWidth: 0,
                     // enabled: false,
                      onFieldSubmitted: navigateToSearchScreen,
                      decoration: InputDecoration(
                          // prefixIcon: InkWell(
                          //   onTap: () {},
                          //   child: Padding(
                          //     padding: EdgeInsets.only(left: 6),
                          //     child: Icon(
                          //       Icons.search,
                          //       color: Colors.black,
                          //       size: 23,
                          //     ),
                          //   ),
                          // ),
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
              ) : SizedBox(),
              SizedBox(width: 5),
              Text(
                'Admin',
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
              ),
            ],
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.all(0),
              child: IconButton(
                onPressed: () => AccountServices().logOut(context),
                icon: Icon(Icons.logout_outlined),
              ),
            ),
          ],
        ),
      ),
      body:
          //
          pages[_page],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _page,
        selectedItemColor: GlobalVariables.selectedNavBarColor,
        unselectedItemColor: GlobalVariables.unselectedNavBarColor,
        backgroundColor: GlobalVariables.backgroundColor,
        iconSize: 28,
        onTap: updatePage,
        items: [
          // posts
          BottomNavigationBarItem(
            icon: Container(
              width: bottomBarWidth,
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: _page == 0
                        ? GlobalVariables.selectedNavBarColor
                        : GlobalVariables.backgroundColor,
                    width: bottomBarBorderWidth,
                  ),
                ),
              ),
              child: Icon(
                Icons.home_outlined,
              ),
            ),
            label: "",
          ),
          // analytics
          BottomNavigationBarItem(
            icon: Container(
              width: bottomBarWidth,
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: _page == 1
                        ? GlobalVariables.selectedNavBarColor
                        : GlobalVariables.backgroundColor,
                    width: bottomBarBorderWidth,
                  ),
                ),
              ),
              child: Icon(
                Icons.analytics_outlined,
              ),
            ),
            label: "",
          ),
          // orders
          BottomNavigationBarItem(
            icon: Container(
              width: bottomBarWidth,
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: _page == 2
                        ? GlobalVariables.selectedNavBarColor
                        : GlobalVariables.backgroundColor,
                    width: bottomBarBorderWidth,
                  ),
                ),
              ),
              child: Icon(
                Icons.all_inbox_outlined,
              ),
            ),
            label: "",
          ),
        ],
      ),
    );
  }
}
