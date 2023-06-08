import 'package:amazon/common/widgets/loader.dart';
import 'package:amazon/features/admin/modals/sales.dart';
import 'package:amazon/features/admin/services/admin_services.dart';
import 'package:d_chart/d_chart.dart';
//import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';

class AnalyticsScreen extends StatefulWidget {
  const AnalyticsScreen({Key? key}) : super(key: key);

  @override
  State<AnalyticsScreen> createState() => _AnalyticsScreenState();
}

class _AnalyticsScreenState extends State<AnalyticsScreen> {
  final AdminServices adminServices = AdminServices();
  int? totalSales;
  List<Sales>? earnings;
  var map1;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getEarnings();
  }

  void getEarnings() async {
    var earningData = await adminServices.getEarnings(context);
    totalSales = earningData['totalEarnings'];
    earnings = earningData["sales"];
      map1 = { for (var e in earnings!) e.label : e.earning };
print(map1);
 
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return earnings == null || totalSales == null
        ? const Loader()
        : Column(
            children: [
              Text(
                "Total sales : \$$totalSales",
                style:
                     const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              //  SizedBox(
              //   height: 250,
              //   // child: CategoryProductsChart(seriesList: [
              //   //   // charts.Series(
              //   //   //     id: 'Sales',
              //   //   //     data: earnings!,
              //   //   //     domainFn: (Sales sales, _) => sales.label,
              //   //   //     measureFn: (Sales sales, _) => sales.earning,)
              //   // ]),
              //   child: Column(
              //     children: [
              //       Text(earnings![0].label),
              //        Text(earnings![0].earning.toString()),
              //        const Divider(),
              //         Text(earnings![1].label),
              //        Text(earnings![1].earning.toString()),
              //            const Divider(),
              //         Text(earnings![2].label),
              //        Text(earnings![2].earning.toString()),
              //            const Divider(),
              //         Text(earnings![3].label),
              //        Text(earnings![3].earning.toString()),
              //            const Divider(),
              //         Text(earnings![4].label),
              //        Text(earnings![4].earning.toString()),
              //     ],
              //   ),
              // ),
              //====

              Expanded(
                child: DChartBar(
                  data:
                    [
                      {
                          'id': 'Bar',
                          'data': 
                            [
                  {'domain': 'mobile', 'measure': earnings![0].earning},
                  {'domain': 'essentials', 'measure': earnings![1].earning},
                  {'domain': 'books', 'measure': earnings![2].earning},
                  {'domain': 'application', 'measure': earnings![3].earning},
                  {'domain': 'fashion', 'measure': earnings![4].earning},
                          ],
                      },
                  ],
                //  [map1],
                  domainLabelPaddingToAxisLine: 16,
                  axisLineTick: 2,
                  axisLinePointTick: 2,
                  axisLinePointWidth: 10,
                  axisLineColor: Colors.green,
                  measureLabelPaddingToAxisLine: 16,
                  barColor: (barData, index, id) => Colors.green,
                  showBarValue: true,
              ),
              ),
              //======
            ],
          );
  }
}
