import 'package:shoppers/consts/consts.dart';
import 'package:shoppers/consts/lists.dart';
import 'package:shoppers/controllers/cart_controller.dart';
import 'package:shoppers/views/home_screen/home.dart';
import 'package:shoppers/views/widgets_common/loading_indicator.dart';
import 'package:shoppers/views/widgets_common/our_button.dart';
import 'package:get/get.dart';

class PaymentMethod extends StatelessWidget {
  const PaymentMethod({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<CartController>();
    return Obx(
      () => Scaffold(
        backgroundColor: whiteColor,
        appBar: AppBar(
          title: "Choose Payment Method"
              .text
              .fontFamily(semibold)
              .color(darkFontGrey)
              .make(),
        ),
        bottomNavigationBar: SizedBox(
          height: 60,
          child: controller.placingOrder.value
              ? Center(
                  child: loadingIndicator(),
                )
              : ourButton(
                  onPress: () async {
                    await controller.placeMyOrder(
                        orderPaymentMethod:
                            paymentMethodList[controller.paymentIndex.value],
                        totalAmount: controller.totalP.value);

                    await controller.clearCart();
                    VxToast.show(context, msg: "Order placed succesfully");
                    Get.offAll(const Home());
                  },
                  color: amberColor,
                  textColor: whiteColor,
                  title: "Place my order"),
        ),
        body: Container(
          padding: const EdgeInsets.all(8),
          child: Obx(
            () => Column(
                children: List.generate(paymentMethodsImgList.length, (index) {
              return GestureDetector(
                onTap: () {
                  controller.changeIndex(index);
                },
                child: Container(
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: controller.paymentIndex.value == index
                              ? amberColor
                              : Colors.transparent,
                          width: 4),
                      borderRadius: BorderRadius.circular(12)),
                  margin: const EdgeInsets.only(bottom: 8),
                  child: Stack(
                    alignment: Alignment.topRight,
                    children: [
                      Image.asset(
                        colorBlendMode: controller.paymentIndex.value == index
                            ? BlendMode.darken
                            : BlendMode.color,
                        paymentMethodsImgList[index],
                        color: controller.paymentIndex.value == index
                            ? Colors.black.withOpacity(0.4)
                            : Colors.transparent,
                        width: double.infinity,
                        height: 120,
                        fit: BoxFit.cover,
                      ),
                      controller.paymentIndex.value == index
                          ? Transform.scale(
                              scale: 1.3,
                              child: Checkbox(
                                  activeColor: Colors.green,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                  value: true,
                                  onChanged: (value) {}),
                            )
                          : Container(),
                      Positioned(
                          bottom: 5,
                          right: 10,
                          child: paymentMethodList[index]
                              .text
                              .fontFamily(semibold)
                              .color(whiteColor)
                              .size(16)
                              .make())
                    ],
                  ),
                ),
              );
            })),
          ),
        ),
      ),
    );
  }
}
