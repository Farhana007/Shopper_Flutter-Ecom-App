import 'package:shoppers/consts/consts.dart';
import 'package:shoppers/controllers/cart_controller.dart';
import 'package:shoppers/views/cart_screen/payment_screen.dart';
import 'package:shoppers/views/widgets_common/custom_textfield.dart';
import 'package:shoppers/views/widgets_common/our_button.dart';
import 'package:get/get.dart';

class ShippingScreen extends StatelessWidget {
  const ShippingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<CartController>();
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
          title: "Shipping Info"
              .text
              .fontFamily(semibold)
              .color(darkFontGrey)
              .make()),
      bottomNavigationBar: SizedBox(
        height: 60,
        child: ourButton(
            onPress: () {
              if (controller.addressController.text.length < 10) {
                VxToast.show(context, msg: "Please enter address properly");
              }
              if (controller.cityController.text.length <= 2) {
                VxToast.show(context, msg: "Please enter city properly");
              }
              if (controller.stateController.text.length <= 2) {
                VxToast.show(context, msg: "Please enter state properly");
              }
              if (controller.postalController.text.length < 5) {
                VxToast.show(context,
                    msg: "Please enter postal control properly");
              }
              if (controller.phoneController.text.length < 9) {
                VxToast.show(context,
                    msg: "Please enter phone number properly");
              } else {
                Get.to(() => const PaymentMethod());
              }
            },
            color: amberColor,
            textColor: whiteColor,
            title: "Continue"),
      ),
      body: Container(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            customTextField(
                hint: 'Address',
                isPass: false,
                title: "Address",
                controller: controller.addressController),
            customTextField(
                hint: 'City',
                isPass: false,
                title: "City",
                controller: controller.cityController),
            customTextField(
                hint: 'State',
                isPass: false,
                title: "State",
                controller: controller.stateController),
            customTextField(
                hint: 'Postal Code',
                isPass: false,
                title: "Postal Code",
                controller: controller.postalController),
            customTextField(
                hint: 'Phone',
                isPass: false,
                title: "Phone",
                controller: controller.phoneController),
          ],
        ),
      ),
    );
  }
}
