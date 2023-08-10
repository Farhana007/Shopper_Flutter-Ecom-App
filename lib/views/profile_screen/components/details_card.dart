import 'package:shoppers/consts/consts.dart';

Widget detailsCard({width, String? count, String? title}) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      count!.text.color(darkFontGrey).size(16).fontFamily(bold).make(),
      5.heightBox,
      title!.text.color(darkFontGrey).make(),
    ],
  )
      .box
      .padding(const EdgeInsets.all(4))
      .height(80)
      .white
      .rounded
      .width(width)
      .make();
}
