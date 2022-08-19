// ignore_for_file: prefer_const_literals_to_create_immutables,prefer_const_constructors_in_immutables, camel_case_types,prefer_const_constructors
import 'package:amazon/common/widgets/loader.dart';
import 'package:amazon/constants/global_variable.dart';
import 'package:amazon/features/account/services/account_services.dart';
import 'package:amazon/features/account/widgets/single_product.dart';
import 'package:amazon/features/order_details/screens/order_details.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../models/order.dart';
import '../../../providers/user_provider.dart';

class Orders extends StatefulWidget {
  Orders({Key? key}) : super(key: key);

  @override
  State<Orders> createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
  List<Order>? orders;
  final AccountServices accountServices = AccountServices();

  @override
  void initState() {
    super.initState();
    fetchOrders();
  }

  void fetchOrders() async {
    orders = await accountServices.fetchMyOrders(
      context: context,
    );
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;
    return orders == null
        ? Loader()
        : Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: EdgeInsets.only(
                      left: 15,
                    ),
                    child: Text(
                      'Your Orders',
                      style: TextStyle(
                        fontSize: 18,
                        // color: Colors.black
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(
                      right: 15,
                    ),
                    child: Text(
                      'See All',
                      style: TextStyle(
                        color: GlobalVariables.selectedNavBarColor,
                      ),
                    ),
                  ),
                ],
              ),
              // display orders

              GridView.builder(
                  shrinkWrap: true,
                  // scrollDirection: Axis.horizontal,
                  padding: EdgeInsets.only(left: 30),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    // childAspectRatio: 1.4,
                    // mainAxisSpacing: 10,
                  ),
                  itemCount: orders!.length,
                  itemBuilder: (context, index) {
                    //  final product = allProductList![index];
                    return
                     GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(
                                context,
                                OrderDetailsScreen.routeName,
                                arguments: orders![index],
                              );
                            },
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 158,
                                  child: DecoratedBox(
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Colors.black12,
                                        width: 0.5,
                                      ),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.all(10),
                                      child: SingleProduct(
                                          image: orders![index]
                                              .products[0]
                                              .images[0]),
                                      //
                                      //child:
                                      // Image.network(
                                      //   product.images[0],
                                      //   width: 150,
                                      //   fit: BoxFit.fitWidth,
                                      // ),
                                    ),
                                  ),
                                ),
                                // Container(
                                //   alignment: Alignment.topLeft,
                                //   padding: EdgeInsets.only(
                                //     left: 0,
                                //     top: 5,
                                //     right: 15,
                                //   ),
                                //   child: Text(
                                //     product.name,
                                //     maxLines: 1,
                                //     overflow: TextOverflow.ellipsis,
                                //   ),
                                // ),
                              ],
                            ),
                          );
                  }),
              // Container(
              //   height: 100,
              //   padding: EdgeInsets.only(
              //     left: 10,
              //     top: 20,
              //     right: 0,
              //   ),
              //   child:  ListView.builder(

              //       itemCount: orders!.length,
              //       //  scrollDirection: Axis.horizontal,
              //       itemBuilder: ((context, index) {
              //         return
              //             //
              //             GestureDetector(
              //           onTap: () {
              //             Navigator.pushNamed(
              //               context,
              //               OrderDetailsScreen.routeName,
              //               arguments: orders![index],
              //             );
              //           },
              //           child: user.type == "admin" &&
              //                   orders![index].status == 1
              //               ? SizedBox()
              //               : SingleProduct(
              //                   image: orders![index].products[0].images[0]),
              //         );
              //       })),
              // ),
            ],
          );
  }
}
