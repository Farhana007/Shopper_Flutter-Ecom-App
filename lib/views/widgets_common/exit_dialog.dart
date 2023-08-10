import 'package:shoppers/consts/consts.dart';
import 'package:shoppers/views/widgets_common/our_button.dart';
import 'package:flutter/services.dart';

Widget exitDialog(context) {
  return Dialog(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        "Confirm".text.color(darkFontGrey).size(18).fontFamily(bold).make(),
        const Divider(),
        10.heightBox,
        "Are you sure you want to exit"
            .text
            .color(darkFontGrey)
            .size(16)
            .make(),
        10.heightBox,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ourButton(
                color: amberColor,
                textColor: whiteColor,
                onPress: () {
                  SystemNavigator.pop();
                },
                title: "Yes"),
            ourButton(
                color: amberColor,
                textColor: whiteColor,
                onPress: () {
                  Navigator.pop(context);
                },
                title: "No"),
          ],
        )
      ],
    ).box.padding(const EdgeInsets.all(12)).color(lightGrey).rounded.make(),
  );
}
