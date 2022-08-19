import 'package:amazon/common/widgets/loader.dart';
import 'package:amazon/features/account/widgets/single_product.dart';
import 'package:amazon/features/admin/services/admin_services.dart';
import 'package:amazon/features/order_details/screens/order_details.dart';
import 'package:amazon/models/order.dart';
import 'package:amazon/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({Key? key}) : super(key: key);

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  List<Order>? orders;
  AdminServices adminServices = AdminServices();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchOrders();
  }

  void fetchOrders() async {
    orders = await adminServices.fetchAllOrders(context);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    var user = Provider.of<UserProvider>(context).user;
    return orders == null
        ? const Loader()
        : GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2),
            itemCount: orders!.length,
            itemBuilder: (context, index) {
              final orderData = orders![index];
              return user.type == "admin" && orders![index].status == 1
                  ? InkWell(
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          OrderDetailsScreen.routeName,
                          arguments: orderData,
                        );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            width: 1.5,
                            color: Colors.black12,
                          ),
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.white,
                        ),
                        child: const Center(
                            child: Text(
                          'Done',
                          style: TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                            color: Colors.green,
                          ),
                        )),
                      ),
                    )
                  : GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          OrderDetailsScreen.routeName,
                          arguments: orderData,
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 1, vertical: 8),
                        child: SizedBox(
                          height: 140,
                          child: SingleProduct(
                              image: orderData.products[0].images[0]),
                        ),
                      ),
                    );
            },
          );
  }
}
