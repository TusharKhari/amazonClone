// ignore_for_file: prefer_const_literals_to_create_immutables,prefer_const_constructors_in_immutables, camel_case_types,prefer_const_constructors

import 'dart:io';

import 'package:amazon/common/widgets/custom_button.dart';
import 'package:amazon/common/widgets/custom_textField.dart';
import 'package:amazon/constants/global_variable.dart';
import 'package:amazon/constants/utils.dart';
import 'package:amazon/features/admin/services/admin_services.dart';
import 'package:amazon/providers/functions_provider.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../account/services/account_services.dart';

class AddProductScreen extends StatefulWidget {
  static const String routeName = "/add-product";
  AddProductScreen({Key? key}) : super(key: key);

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final TextEditingController productNameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController quantityController = TextEditingController();
  final AdminServices adminServices = AdminServices();

  String category = 'Mobiles';
  List<File> images = [];
  final _addProductFormKey = GlobalKey<FormState>();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    productNameController.dispose();
    descriptionController.dispose();
    priceController.dispose();
    quantityController.dispose();
  }

  List<String> productCategories = [
    "Mobiles",
    "Essentials",
    "Appliances",
    "Books",
    "Fashion",
  ];
  void sellProduct() {
    if (_addProductFormKey.currentState!.validate() && images.isNotEmpty) {
      adminServices.sellProduct(
          context: context,
          name: productNameController.text,
          description: descriptionController.text,
          price: double.parse(priceController.text),
          quantity: double.parse(quantityController.text),
          category: category,
          images: images);
         
    }
  }

  void selectImages() async {
    var res = await pickImages();
    setState(() {
      images = res;
    });
  }

  @override
  Widget build(BuildContext context) {
    var pro = Provider.of<FunctionProvider>(context, listen: false);
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: AppBar(
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: GlobalVariables.appBarGradient,
            ),
          ),
          title: Text(
            'Add Product',
            style: TextStyle(color: Colors.black),
          ),
       
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _addProductFormKey,
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 10,
            ),
            child: Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                images.isNotEmpty
                    ?
                    //
                    CarouselSlider(
                        options: CarouselOptions(
                          //autoPlay: true,
                          viewportFraction: 1,
                          height: 200,
                        ),
                        items:
                            //
                            images.map((i) {
                          return
                              //
                              Builder(
                            builder: (BuildContext context) {
                              //print(i);
                              return Image.file(
                                i,
                                fit: BoxFit.cover,
                                height: 150,
                              );
                            },
                          );
                        }).toList(),
                        //

                        //
                      )
                    :
                    //
                    GestureDetector(
                        onTap:
                            //
                            selectImages,
                        //     () async {
                        //   var res = await pickImages();
                        //   pro.setImage(images, res);
                        // },
                        //
                        child: DottedBorder(
                          borderType: BorderType.RRect,
                          radius: Radius.circular(10),
                          dashPattern: [10, 4],
                          strokeCap: StrokeCap.round,
                          child: Container(
                            width: double.infinity,
                            height: 150,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10)),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.folder_open,
                                  size: 40,
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                Text(
                                  'Select Product Images',
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.grey.shade400,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                SizedBox(
                  height: 30,
                ),
                CustomTextField(
                  hintText: 'Product Name',
                  controller: productNameController,
                ),
                SizedBox(
                  height: 10,
                ),
                CustomTextField(
                  hintText: 'Description',
                  controller: descriptionController,
                  maxLines: 7,
                ),
                SizedBox(
                  height: 10,
                ),
                CustomTextField(
                  hintText: 'Price',
                  controller: priceController,
                ),
                SizedBox(
                  height: 10,
                ),
                CustomTextField(
                  hintText: 'Quantity',
                  controller: quantityController,
                ),
                SizedBox(
                  width: double.infinity,
                  child: DropdownButton(
                    value: category,
                    onChanged: (String? newVal) {
                      setState(() {
                        category = newVal!;
                      });
                      // pro.getOldVal(category);
                      // pro.getNewVal(newVal);
                      // pro.setVal();
                      //  pro.f(category, newVal);
                      // print('aps ' + category + " " + newVal.toString());
                    },
                    items: productCategories.map((String item) {
                      return DropdownMenuItem(
                        child: Text(item),
                        value: item,
                      );
                    }).toList(),
                    icon: Icon(Icons.keyboard_arrow_down),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                CustomButton(
                  text: 'Sell',
                  onTap: sellProduct,
                ),
                SizedBox(height: 5,),
              ],
            ),
          ),
        ),
      ),
      //===============
    );
  }
}
