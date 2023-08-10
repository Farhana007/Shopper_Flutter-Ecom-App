import 'package:shoppers/consts/consts.dart';

Widget homeButtons({width, height, title, icon, onPress}) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Image.asset(
        icon,
        width: 26,
      ).onTap(onPress),
      10.heightBox,
      "$title".text.color(darkFontGrey).fontFamily(semibold).make()
    ],
  ).box.rounded.size(width, height).shadowSm.white.make();
}
