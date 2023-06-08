import 'dart:convert';

import 'package:amazon/constants/error_handling.dart';
import 'package:amazon/constants/global_variable.dart';
import 'package:amazon/constants/utils.dart';
import 'package:amazon/models/product.dart';
import 'package:amazon/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class HomeServices {
 
  Future<List<Product>> fetchAllProducts({
    required BuildContext context,
    // required String category,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false).user;
    List<Product> allProductList = [];
    try {
      http.Response res = await http.get(
        Uri.parse("$uri/api/all-products"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          "x-auth-token": userProvider.token
        },
      );
      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          for (int i = 0; i < jsonDecode(res.body).length; i++) {
            allProductList.add(
              Product.fromJson(
                jsonEncode(
                  jsonDecode(res.body)[i],
                ),
              ),
            );
          }
         // allProductList = res.body;
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
        print(e.toString());
    }
    return allProductList;
  }

  Future<List<Product>> fetchCategoryProducts({
    required BuildContext context,
    required String category,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false).user;
    List<Product> productList = [];
    try {
      http.Response res = await http.get(
        Uri.parse("$uri/api/products?category=$category"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          "x-auth-token": userProvider.token
        },
      );
      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          for (int i = 0; i < jsonDecode(res.body).length; i++) {
            productList.add(
              Product.fromJson(
                jsonEncode(
                  jsonDecode(res.body)[i],
                ),
              ),
            );
          }
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
      //  print(e.toString());
    }
    return productList;
  }

  Future<Product> fetchDealOfDay({
    required BuildContext context,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false).user;
    Product product = Product(
        name: '',
        description: '',
        quantity: 0,
        images: [],
        category: '',
        price: 0);
    try {
      http.Response res = await http.get(
        Uri.parse("$uri/api/deal-of-day"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          "x-auth-token": userProvider.token
        },
      );
      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          product = Product.fromJson(res.body);
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
      //  print(e.toString());
    }
    return product;
  }

  // void fetchAllProducts({
  //   required BuildContext context,
  // }) async {
  //   var data;
  //   final userProvider = Provider.of<UserProvider>(context, listen: false).user;
  //   // Product product = Product(
  //   //     name: '',
  //   //     description: '',
  //   //     quantity: 0,
  //   //     images: [],
  //   //     category: '',
  //   //     price: 0);
  //   try {
  //     http.Response res = await http.get(
  //       Uri.parse("$uri/api/all-products"),
  //       headers: <String, String>{
  //         'Content-Type': 'application/json; charset=UTF-8',
  //         "x-auth-token": userProvider.token
  //       },
  //     );
  //     // data = jsonDecode(res.body);
  //     //  print(data);
  //     httpErrorHandle(
  //       response: res,
  //       context: context,
  //       onSuccess: () {
  //         //  product = Product.fromJson(res.body);
  //         data = jsonDecode(res.body);
  //         print('httpErrorHandle  $data');
  //       },
  //     );
  //   } catch (e) {
  //     showSnackBar(context, e.toString());
  //     //  print(e.toString());
  //   }
  //   // return product;
  // }

  //  Future <void> fetchAllProducts({
  //   required BuildContext context,
  // }) async {
  //   var data;
  //   final userProvider = Provider.of<UserProvider>(context, listen: false).user;
  //   Product product = Product(
  //       name: '',
  //       description: '',
  //       quantity: 0,
  //       images: [],
  //       category: '',
  //       price: 0);
  //   try {
  //     http.Response res = await http.get(
  //       Uri.parse("$uri/api/all-products"),
  //       headers: <String, String>{
  //         'Content-Type': 'application/json; charset=UTF-8',
  //         "x-auth-token": userProvider.token
  //       },
  //     );
  //     // data = jsonDecode(res.body);
  //     //  print(data);
  //     httpErrorHandle(
  //       response: res,
  //       context: context,
  //       onSuccess: () {
  //         //  product = Product.fromJson(res.body);
  //         data = jsonDecode(res.body);
  //         print('httpErrorHandle  $data');
  //       },
  //     );
  //   } catch (e) {
  //     showSnackBar(context, e.toString());
  //     //  print(e.toString());
  //   }
  //   // return product;
  // }

}
