import 'package:shoppers/consts/consts.dart';
import 'package:shoppers/views/category_screen/category_details.dart';
import 'package:get/get.dart';

Widget featuredButton({icon, String? title}) {
  return Row(
    children: [
      Image.asset(
        icon,
        width: 60,
        fit: BoxFit.fill,
      ),
      10.widthBox,
      title!.text.color(darkFontGrey).fontFamily(semibold).make()
    ],
  )
      .box
      .width(200)
      .margin(const EdgeInsets.symmetric(horizontal: 4))
      .rounded
      .padding(const EdgeInsets.all(4))
      .outerShadowSm
      .white
      .make()
      .onTap(() {
    Get.to(() => CategoryDetails(title: title));
  });
}
