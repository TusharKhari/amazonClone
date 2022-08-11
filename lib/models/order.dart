import 'dart:convert';

import 'package:amazon/models/product.dart';

class Order {
  final String id;
  final List<Product> products;
  final List<int> quantity;
  final String address;
  final String userId;
  final int orderedAt;
  final int status;
  final double totalPrice;
  Order({
    required this.id,
    required this.products,
    required this.quantity,
    required this.address,
    required this.userId,
    required this.orderedAt,
    required this.status,
    required this.totalPrice,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'products': products.map((x) => x.toMap()).toList(),
      'quantity': quantity,
      'address': address,
      'userId': userId,
      'orderedAt': orderedAt,
      'status': status,
      'totalPrice': totalPrice,
    };
  }

  factory Order.fromMap(Map<String, dynamic> map) {
    return Order(
      id: map['_id'] ?? '',
      products: List<Product>.from(
          map['products']?.map((x) => Product.fromMap(x['product']))),
      quantity: List<int>.from(
        map['products']?.map(
          (x) => x['quantity'],
        ),
      ),
      address: map['address'] ?? '',
      userId: map['userId'] ?? '',
      orderedAt: map['orderedAt']?.toInt() ?? 0,
      status: map['status']?.toInt() ?? 0,
      totalPrice: map['totalPrice']?.toDouble() ?? 0.0,
    );
  }

  String toJson() => json.encode(toMap());

  factory Order.fromJson(String source) => Order.fromMap(json.decode(source));
}
//by me
// import 'dart:convert';

// import 'package:amazon/models/product.dart';

// class Order {
//   final String id;
//   final List<Product> products;
//   final List<int> quantity;
//   final String address;
//   final String userId;
//   final int orderedAt; // seen from order.js
//   final int status;
//   final double totalPrice;
//   Order(  {
//     required this.id,
//     required this.products,
//     required this.quantity,
//     required this.address,
//     required this.userId,
//     required this.orderedAt,
//     required this.status,
//     required this.totalPrice,
//   });

//   Map<String, dynamic> toMap() {
//     return {
//       'id': id,
//       'products': products.map((x) => x.toMap()).toList(),
//       'quantity': quantity,
//       'address': address,
//       'userId': userId,
//       'orderedAt': orderedAt,
//       'status': status,
//       'totalPrice' : totalPrice,
//     };
//   }

//   /// toMap is correct he have to change  from map
//   ///    we have access to one product only in db
//   /// product array , 0:object, consist of product and quantity

//   // factory Order.fromMap(Map<String, dynamic> map) {
//   //   return Order(
//   //     map['id'] ?? '',
//   //     List<Product>.from(map['products']?.map((x) => Product.fromMap(x))),
//   //     List<int>.from(map['quantity']),
//   //     map['address'] ?? '',
//   //     map['userId'] ?? '',
//   //     map['orderedAt']?.toInt() ?? 0,
//   //     map['status']?.toInt() ?? 0,
//   //   );
//   // }
//   factory Order.fromMap(Map<String, dynamic> map) {
//     return Order(
//       id: map['_id'] ?? '', // _id is in database
//       products: List<Product>.from(
//           map['products']?.map((x) => Product.fromMap(x['product']))),
//       quantity: List<int>.from(map['products']?.map((x) => x['quantity'])),
//       address: map['address'] ?? '',
//       userId: map['userId'] ?? '',
//       orderedAt: map['orderedAt']?.toInt() ?? 0,
//       status: map['status']?.toInt() ?? 0,
//       totalPrice : map['totalPrice']?.toDouble ?? 0.0,
//     );
//   }

//   String toJson() => json.encode(toMap());

//   factory Order.fromJson(String source) => Order.fromMap(json.decode(source));
// }
