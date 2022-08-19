// copied most of the things from admin services

import 'dart:convert';

import 'package:amazon/constants/error_handling.dart';
import 'package:amazon/constants/global_variable.dart';
import 'package:amazon/constants/utils.dart';
import 'package:amazon/models/product.dart';
import 'package:amazon/models/user.dart';
import 'package:amazon/providers/user_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class AddressServices {
  void saveUserAddress({
    required BuildContext context,
    required String address,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      http.Response res = await http.post(
          Uri.parse(
            "$uri/api/save-user-address",
          ),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            "x-auth-token": userProvider.user.token
          },
          body: jsonEncode({
            "address": address,
          }));

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          User user = userProvider.user.copyWith(
            address: jsonDecode(res.body)['address'],
          );
          userProvider.setUserFromModel(user);
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
      print(e);
    }
  }

  // placing order

  void placeOrder({
    required BuildContext context,
    required String address,
    required double totalSum,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      http.Response res = await http.post(Uri.parse("$uri/api/order"),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            "x-auth-token": userProvider.user.token
          },
          body: jsonEncode({
            "cart": userProvider.user.cart,
            "address": address,
            "totalPrice": totalSum,
          }));
      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          showSnackBar(context, 'Your Order Has Been Placed!');
          User user = userProvider.user.copyWith(
            cart: [],
          );
          userProvider.setUserFromModel(user);
          Navigator.pop(context);
        },
      );
    } catch (e) {
      showSnackBar(context, "$e");
      print(e);
    }
  }

  // delete product
  // void deleteProduct(
  //     {required BuildContext context,
  //     required Product product,
  //     required VoidCallback onSuccess}) async {
  //   final userProvider = Provider.of<UserProvider>(context, listen: false).user;

  //   try {
  //     http.Response res = await http.post(
  //       Uri.parse("$uri/admin/delete-product"),
  //       headers: {
  //         'Content-Type': 'application/json; charset=UTF-8',
  //         "x-auth-token": userProvider.token
  //       },
  //       body: jsonEncode({
  //         "id": product.id,
  //       }),
  //     );

  //     httpErrorHandle(
  //       response: res,
  //       context: context,
  //       onSuccess: () {
  //         onSuccess();
  //       },
  //     );
  //   } catch (e) {
  //     showSnackBar(context, e.toString());
  //     print(e);
  //   }
  // }

//

}

//
