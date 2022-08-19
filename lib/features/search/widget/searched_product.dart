import 'package:amazon/common/widgets/stars.dart';
import 'package:amazon/features/product_details/screens/product_details_screen.dart';
import 'package:amazon/models/product.dart';
import 'package:flutter/material.dart';
// ignore_for_file: prefer_const_literals_to_create_immutables,prefer_const_constructors_in_immutables, camel_case_types,prefer_const_constructors

class SearchedProduct extends StatelessWidget {
  final Product product;
  const SearchedProduct({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double totalRating = 0;
    // double rating = 0;
    double avgRating = 0;
    for (int i = 0; i < product.rating!.length; i++) {
      totalRating += product.rating![i].rating;
      // if (widget.product.rating![i].userId ==
      //     Provider.of<UserProvider>(context, listen: false).user.id) {
      //   myRating = widget.product.rating![i].rating;
      // }
    }
    if (totalRating != 0) {
      avgRating = totalRating / product.rating!.length;
    }
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
                  width: 135,
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
                        child: Stars(rating: avgRating)),
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
                      product.quantity == 0 ? Text(
                        'Out of Stock',
                        style: TextStyle(
                            // fontSize: 20,
                            // fontWeight: FontWeight.bold,
                            color: Colors.red),
                        maxLines: 2,
                      ) :
                      Text(
                        'In Stock',
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
          )
        ],
      ),
    );
  }
}
