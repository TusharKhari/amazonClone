// ignore_for_file: prefer_const_literals_to_create_immutables,prefer_const_constructors_in_immutables, camel_case_types,prefer_const_constructors

import 'package:amazon/common/widgets/loader.dart';
import 'package:amazon/constants/utils.dart';
import 'package:amazon/features/cart/services/cart_services.dart';
import 'package:amazon/features/product_details/services/product_details_services.dart';
import 'package:amazon/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../models/product.dart';
import '../../product_details/screens/product_details_screen.dart';

class CartProduct extends StatefulWidget {
  final int index;
  CartProduct({Key? key, required this.index}) : super(key: key);

  @override
  State<CartProduct> createState() => _CartProductState();
}

class _CartProductState extends State<CartProduct> {
  final ProductDetailServices productDetailServices = ProductDetailServices();
  final CartServices cartServices = CartServices();
  Product? productQty;
  void increaseQuantity(Product product) {
    productDetailServices.addToCart(context: context, product: product);
  }

  void decreaseQuantity(Product product) {
    cartServices.removeFromCart(context: context, product: product);
  }

  @override
  Widget build(BuildContext context) {
    
    final productCart = context.watch<UserProvider>().user.cart[widget.index];

    final product = Product.fromMap(productCart['product']);

    final quantity = productCart["quantity"];
    // {"product" : {}, "quantity"}
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, ProductDetailScreen.routeName,
            arguments: product);
      },
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.symmetric(
              horizontal: 10,
            ),
            child: Row(
              children: [
                Image.network(
                  product.images[0],
                  fit: BoxFit.contain,
                  height: 135,
                  width: 120,
                ),
                Column(
                  children: [
                    Container(
                      width: 235,
                      padding: EdgeInsets.symmetric(
                        horizontal: 10,
                      ),
                      child: Text(
                        product.name,
                        style: TextStyle(
                          fontSize: 16,
                        ),
                        maxLines: 2,
                      ),
                    ),
                    Container(
                      width: 235,
                      padding: EdgeInsets.only(
                        left: 10,
                        top: 5,
                      ),
                      child: Text(
                        '\$${product.price}',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                        maxLines: 2,
                      ),
                    ),
                    Container(
                      width: 235,
                      padding: EdgeInsets.only(
                        left: 10,
                      ),
                      child: Text(
                          //'Eligible for free shipping',
                          ''
                          //
                          ),
                    ),
                    Container(
                      width: 235,
                      padding: EdgeInsets.only(
                        left: 10,
                        top: 5,
                      ),
                      child:
                          // product == null ? Loader():
                          product.quantity == 0.0
                              ? Text(
                                  'Out Of Stock \n Please remove from the cart',
                                  style: TextStyle(
                                      // fontSize: 20,
                                      // fontWeight: FontWeight.bold,
                                      color: Colors.red),
                                )
                              : Text(
                                  'In Stock',
                                  //  productQty!.quantity.toString(),
                                  style: TextStyle(
                                      // fontSize: 20,
                                      // fontWeight: FontWeight.bold,
                                      color: Colors.teal),
                                  maxLines: 2,
                                ),
                    ),
                  ],
                )
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black12, width: 1.5),
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.black12),
                  child: Row(
                    children: [
                      InkWell(
                        onTap: () {
                          decreaseQuantity(product);
                          //  print( "decreaseQuantity(product) ");
                        },
                        child: Container(
                          width: 35,
                          height: 32,
                          alignment: Alignment.center,
                          child: Icon(
                            Icons.remove,
                            size: 18,
                          ),
                        ),
                      ),
                      DecoratedBox(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(0),
                            border:
                                Border.all(color: Colors.black12, width: 1.5),
                            color: Colors.white),
                        child: Container(
                          width: 35,
                          height: 32,
                          // color: Colors.white,
                          alignment: Alignment.center,
                          child: Text(quantity.toString()),
                        ),
                      ),
                      InkWell(
                        onTap: () => increaseQuantity(product),
                        child: Container(
                          width: 35,
                          height: 32,
                          alignment: Alignment.center,
                          child: Icon(
                            Icons.add,
                            size: 18,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                    onPressed: () {
                      decreaseQuantity(product);
                      showSnackBar(context, "press until quantity become zero");
                    },
                    icon: Icon(Icons.delete_outline_sharp))
              ],
            ),
          ),
        ],
      ),
    );
  }
}
