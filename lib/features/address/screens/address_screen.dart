import 'package:amazon/constants/utils.dart';
import 'package:amazon/features/address/services/address_services.dart';
import 'package:amazon/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:pay/pay.dart';
import 'package:provider/provider.dart';
import '../../../common/widgets/custom_textField.dart';
import '../../../constants/global_variable.dart';
// ignore_for_file: prefer_const_literals_to_create_immutables,prefer_const_constructors_in_immutables, camel_case_types,prefer_const_constructors

class AddressScreen extends StatefulWidget {
  static const String routeName = "/address";
  final String totalAmount;
  AddressScreen({Key? key, required this.totalAmount}) : super(key: key);

  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  final TextEditingController flatBuildingController = TextEditingController();
  final TextEditingController areaController = TextEditingController();
  final TextEditingController pinCodeController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController phoneNoController = TextEditingController();
  final TextEditingController receiverNameController = TextEditingController();
  final _addressFormKey = GlobalKey<FormState>();

  String addressToBeUsed = "";
  List<PaymentItem> paymentItems = [];
  final AddressServices addressServices = AddressServices();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    paymentItems.add(PaymentItem(
      amount: widget.totalAmount,
      label: "Total Amount",
      status: PaymentItemStatus.final_price,
    ));
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    flatBuildingController.dispose();
    areaController.dispose();
    pinCodeController.dispose();
    cityController.dispose();
    phoneNoController.dispose();
    receiverNameController.dispose();
  }

  void onApplePayResult(res) {
    if (Provider.of<UserProvider>(context, listen: false)
        .user
        .address
        .isEmpty) {
      addressServices.saveUserAddress(
        context: context,
        address: addressToBeUsed,
      );
    }
    addressServices.placeOrder(
        context: context,
        address: addressToBeUsed,
        totalSum: double.parse(widget.totalAmount));
  }

  void onGooglePayResult(res) {
    if (Provider.of<UserProvider>(context, listen: false)
        .user
        .address
        .isEmpty) {
      addressServices.saveUserAddress(
        context: context,
        address: addressToBeUsed,
      );
    }
    addressServices.placeOrder(
        context: context,
        address: addressToBeUsed,
        totalSum: double.parse(widget.totalAmount));
  }

  void payPressed(String addressFromProvider) {
    addressToBeUsed = '';

    bool isForm = flatBuildingController.text.isNotEmpty ||
        areaController.text.isNotEmpty ||
        pinCodeController.text.isNotEmpty ||
        cityController.text.isNotEmpty ||
        phoneNoController.text.isNotEmpty||
        receiverNameController.text.isNotEmpty;

    if (isForm) {
      if (_addressFormKey.currentState!.validate()) {
        addressToBeUsed =
            "${receiverNameController.text}, ${flatBuildingController.text}, ${areaController.text} , ${cityController.text}, PIN - ${pinCodeController.text}, Phone No. - ${phoneNoController.text}";
      } else {
        throw Exception("Please enter all the values");
      }
    } else if (addressFromProvider.isNotEmpty) {
      addressToBeUsed = addressFromProvider;
    } else {
      showSnackBar(context, 'ERROR');
    }
    // print(addressToBeUsed);
  }

  @override
  Widget build(BuildContext context) {
    // var address = context.watch<UserProvider>().user.address;
    var address = context.watch<UserProvider>().user.address;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: AppBar(
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: GlobalVariables.appBarGradient,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              if (address.isNotEmpty)
                Column(
                  children: [
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black12),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          address,
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      'OR',
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              Form(
                key: _addressFormKey,
                child: Column(
                  children: [
                    CustomTextField(
                      controller: receiverNameController,
                      hintText: 'Receiver\'s Name',
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    CustomTextField(
                      controller: phoneNoController,
                      hintText: 'Mobile No.',
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    CustomTextField(
                      controller: flatBuildingController,
                      hintText: 'Flat, House no, Building',
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    CustomTextField(
                      controller: areaController,
                      hintText: 'Area, Street, Village',
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    CustomTextField(
                      controller: pinCodeController,
                      hintText: 'Pincode',
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    CustomTextField(
                      controller: cityController,
                      hintText: 'Town/City/District/State',
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    ApplePayButton(
                        onPressed: () {
                          payPressed(address);
                        },
                        width: double.infinity,
                        height: 50,
                        margin: EdgeInsets.only(top: 15),
                        style: ApplePayButtonStyle.whiteOutline,
                        type: ApplePayButtonType.buy,
                        paymentConfigurationAsset: "applepay.json",
                        onPaymentResult: onApplePayResult,
                        paymentItems: paymentItems),
                    SizedBox(
                      height: 10,
                    ),
                    GooglePayButton(
                      onPressed: () {
                        payPressed(address);
                      },
                      height: 50,
                      margin: EdgeInsets.only(top: 15),
                     // style: GooglePayButtonStyle.black,
                      type: GooglePayButtonType.buy,
                      paymentConfigurationAsset: 'gpay.json',
                      onPaymentResult: onApplePayResult,
                      paymentItems: paymentItems,
                      loadingIndicator: Center(
                        child: CircularProgressIndicator(),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
