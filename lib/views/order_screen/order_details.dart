import 'package:shoppers/consts/consts.dart';
import 'package:shoppers/views/order_screen/components/order_place_details.dart';
import 'package:shoppers/views/order_screen/components/order_status.dart';
import 'package:intl/intl.dart' as intl;

class OrderDetails extends StatelessWidget {
  const OrderDetails({super.key, this.data});
  final dynamic data;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title: "Order Details"
            .text
            .fontFamily(semibold)
            .color(darkFontGrey)
            .make(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              orderStatus(
                  color: amberColor,
                  icon: (Icons.done),
                  title: "Placed",
                  showDone: data['order_placed']),
              orderStatus(
                  color: Colors.blue,
                  icon: (Icons.thumb_up),
                  title: "Confirmed",
                  showDone: data['order_confirm']),
              orderStatus(
                  color: Colors.yellow,
                  icon: (Icons.fire_truck_outlined),
                  title: "On Delivery",
                  showDone: data['order_on_delivery']),
              orderStatus(
                  color: Colors.purple,
                  icon: (Icons.done_all_outlined),
                  title: "Delivered",
                  showDone: data['order_delivered']),
              const Divider(),
              10.heightBox,
              Column(
                children: [
                  orderPlaceDetail(
                      d1: data['order_code'],
                      d2: data['shipping_method'],
                      t1: "Order code",
                      t2: "Shipping method"),
                  orderPlaceDetail(
                      d1: intl.DateFormat()
                          .add_yMd()
                          .format(data['order_date'].toDate()),
                      d2: data['payment_method'],
                      t1: "Order date",
                      t2: "Payment method"),
                  orderPlaceDetail(
                      d1: "Unpaid",
                      d2: 'Order placed',
                      t1: "Payment status",
                      t2: "Order status"),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(left: 15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            10.heightBox,
                            "Shipping address".text.fontFamily(semibold).make(),
                            5.heightBox,
                            "${data['order_by_name']}".text.make(),
                            "${data['order_by_email']}".text.make(),
                            "${data['order_by_address']}".text.make(),
                            "${data['order_by_city']}".text.make(),
                            "${data['order_by_state']}".text.make(),
                            "${data['order_by_postal']}".text.make(),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 145,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            "Total ammount".text.fontFamily(semibold).make(),
                            "${data['total_ammount']}"
                                .numCurrency
                                .text
                                .fontFamily(bold)
                                .color(Colors.red)
                                .make(),
                          ],
                        ),
                      )
                    ],
                  ),
                ],
              )
                  .box
                  .roundedSM
                  .shadowMd
                  .white
                  .margin(const EdgeInsets.only(bottom: 4))
                  .make(),
              const Divider(),
              10.heightBox,
              "Ordered Product"
                  .text
                  .size(16)
                  .color(darkFontGrey)
                  .fontFamily(semibold)
                  .makeCentered(),
              20.heightBox,
              ListView(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                children: List.generate(data['orders'].length, (index) {
                  var order = data['orders'][index];
                  return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        orderPlaceDetail(
                          t1: order['title'],
                          t2: order['tprice'],
                          d1: "${order['qyt']}x",
                          d2: "Refundable",
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Container(
                            width: 30,
                            height: 20,
                            color: Color(order['color']),
                          ),
                        ),
                        const Divider(),
                      ]);
                }).toList(),
              )
                  .box
                  .roundedSM
                  .shadowMd
                  .white
                  .margin(const EdgeInsets.only(bottom: 4))
                  .make(),
              // 20.heightBox,
              // Row(
              //   children: [
              //     "SUB TOTAL"
              //         .text
              //         .fontFamily(semibold)
              //         .size(16)
              //         .color(darkFontGrey)
              //         .make(),
              //   ],
              // )
            ],
          ),
        ),
      ),
    );
  }
}
