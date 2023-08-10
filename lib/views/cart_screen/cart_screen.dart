import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shoppers/consts/consts.dart';
import 'package:shoppers/controllers/cart_controller.dart';
import 'package:shoppers/services/firestore_services.dart';
import 'package:shoppers/views/cart_screen/shipping_screen.dart';
import 'package:shoppers/views/widgets_common/loading_indicator.dart';
import 'package:shoppers/views/widgets_common/our_button.dart';
import 'package:get/get.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(CartController());
    return Scaffold(
      bottomNavigationBar: SizedBox(
        //width: context.screenWidth - 60,
        height: 60,
        child: ourButton(
            color: amberColor,
            onPress: () {
              Get.to(() => const ShippingScreen());
            },
            textColor: whiteColor,
            title: "Proceed to shipping"),
      ),
      backgroundColor: whiteColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: "Shopping Cart"
            .text
            .color(darkFontGrey)
            .fontFamily(semibold)
            .make(),
      ),
      body: StreamBuilder(
        stream: FirestoreServices.getCart(currentUser!.uid),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return loadingIndicator();
          } else if (snapshot.data!.docs.isEmpty) {
            return "Cart is empty!"
                .text
                .color(darkFontGrey)
                .fontFamily(semibold)
                .makeCentered();
          } else {
            var data = snapshot.data!.docs;
            controller.calculate(data);
            controller.productSnapshot = data;

            return Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: data.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          leading: SizedBox(
                              width: 80,
                              height: 80,
                              child: Image.network(
                                '${data[index]['img'][0]}',
                                fit: BoxFit.cover,
                              )),
                          title: "${data[index]['title']}"
                              .text
                              .size(16)
                              .fontFamily(semibold)
                              .make(),
                          subtitle: "${data[index]['tprice']}"
                              .numCurrency
                              .text
                              .color(Colors.red)
                              .fontFamily(semibold)
                              .make(),
                          trailing: const Icon(
                            Icons.delete,
                            color: Color.fromARGB(255, 118, 118, 118),
                          ).onTap(() {
                            FirestoreServices.deleteDocument(data[index].id);
                          }),
                        );
                      },
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      "Total Price"
                          .text
                          .color(darkFontGrey)
                          .fontFamily(semibold)
                          .make(),
                      Obx(
                        () => controller.totalP.value.numCurrency.text
                            .color(Colors.red)
                            .fontFamily(semibold)
                            .make(),
                      )
                    ],
                  )
                      .box
                      .padding(const EdgeInsets.all(12))
                      .color(lightgolden)
                      .roundedSM
                      .width(context.screenWidth - 60)
                      .make(),
                  10.heightBox,
                  // SizedBox(
                  //   width: context.screenWidth - 60,
                  //   child: ourButton(
                  //       color: amberColor,
                  //       onPress: () {},
                  //       textColor: whiteColor,
                  //       title: "Proceed to shipping"),
                  // )
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
