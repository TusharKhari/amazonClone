

import 'dart:convert';

import 'package:amazon/constants/error_handling.dart';
import 'package:amazon/constants/global_variable.dart';
import 'package:amazon/constants/utils.dart';
import 'package:amazon/models/product.dart';
import 'package:amazon/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class SearchServices {
  Future<List<Product>> fetchSearchProducts({
    required BuildContext context,
    required String searchQuery,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false).user;
    List<Product> productList = [];
    try {
      http.Response res = await http.get(
        Uri.parse("$uri/api/products/search/$searchQuery"),
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
  
}