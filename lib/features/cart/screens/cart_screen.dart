import 'package:amazon/common/widgets/custom_button.dart';
import 'package:amazon/features/address/screens/address_screen.dart';
import 'package:amazon/features/admin/screens/add_product_screen.dart';
import 'package:amazon/features/cart/widgets/cart_product.dart';
import 'package:amazon/features/cart/widgets/cart_subtotal.dart';
import 'package:amazon/features/home/widgets/address_box.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../constants/global_variable.dart';
import '../../../providers/user_provider.dart';
import '../../search/screens/search_screen.dart';
// ignore_for_file: prefer_const_literals_to_create_immutables,prefer_const_constructors_in_immutables, camel_case_types,prefer_const_constructors

class CartScreen extends StatefulWidget {
  CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  void navigateToSearchScreen(String query) {
    Navigator.pushNamed(context, SearchScreen.routeName, arguments: query);
  }

  void navigateToAddress(int sum) {
    Navigator.pushNamed(
      context,
      AddressScreen.routeName,
      arguments: sum.toString(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final user = context.watch<UserProvider>().user;
    int sum = 0;
    user.cart
        .map((e) => sum += e['quantity'] * e["product"]['price'] as int)
        .toList();

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
                child: Icon(
                  Icons.mic,
                  color: Colors.black,
                  size: 25,
                ),
              )
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
          child: Column(
        children: [
          AddressBox(),
          CartSubtotal(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CustomButton(
              text: "Proceed to Buy (${user.cart.length}) items",
              onTap: () {
                navigateToAddress(sum);
              },
              color: Colors.yellow[600],
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Container(
            color: Colors.black.withOpacity(0.08),
            height: 1,
          ),
          SizedBox(
            height: 5,
          ),
          ListView.builder(
              shrinkWrap: true,
              itemCount: user.cart.length,
              itemBuilder: (context, index) {
                return CartProduct(index: index);
              })
        ],
      )),
    );
  }
}
