import 'package:amazon/common/widgets/loader.dart';
import 'package:amazon/models/product.dart';
import 'package:flutter/material.dart';

import '../../../constants/global_variable.dart';
import '../../home/services/home_services.dart';
import '../../search/screens/search_screen.dart';
import '../screens/product_details_screen.dart';

// ignore_for_file: prefer_const_literals_to_create_immutables,prefer_const_constructors_in_immutables, camel_case_types,prefer_const_constructors

class AllProducts extends StatefulWidget {
  static const String routeName = '/allProducts';
  AllProducts({super.key});

  @override
  State<AllProducts> createState() => _AllProductsState();
}

class _AllProductsState extends State<AllProducts> {
  List<Product>? allProductList;
  final HomeServices homeServices = HomeServices();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchAllProducts();
  }

  fetchAllProducts() async {
    allProductList = await homeServices.fetchAllProducts(
      context: context,
      // category: widget.category,
    );
    setState(() {});
  }

  void navigateToSearchScreen(String query) {
    Navigator.pushNamed(context, SearchScreen.routeName, arguments: query);
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
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
                    // homeServices.fetchAllProducts(context: context);
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
      body: allProductList == null
          ? Loader()
          :
          // Text(allProductList![0].name)
          Column(children: [
              // Container(
              //   padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              //   alignment: Alignment.topLeft,
              //   child: Text(
              //     'Keep shopping ',
              //     style: TextStyle(fontSize: 20),
              //   ),
              // ),
              Expanded(
                child: GridView.builder(
                    shrinkWrap: true,
                    // scrollDirection: Axis.horizontal,
                    padding: EdgeInsets.only(left: 5),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        //childAspectRatio: 1.4,
                        mainAxisSpacing: 2,
                        crossAxisSpacing: 2),
                    itemCount: allProductList!.length,
                    itemBuilder: (context, index) {
                      final product = allProductList![index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(
                              context, ProductDetailScreen.routeName,
                              arguments: product);
                        },
                        child: Container(
                          // padding: EdgeInsets.all(50),
                          //  width: double.maxFinite,
                          // height: 300,

                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.black12,
                              width: 0.2,
                            ),
                            // color: Colors.red,
                          ),
                          child: Column(
                            children: [
                              Image.network(
                                product.images[0],
                                width: 150,
                                fit: BoxFit.fitWidth,
                                height: size.height * 0.16,
                              ),
                              Text(
                                "Rs.   ${product.price}",
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              ),
                              Text(
                                product.name,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
              ),
            ]),
    );
  }
}
