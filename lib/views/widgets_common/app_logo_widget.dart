import 'package:shoppers/consts/consts.dart';

Widget applogoWidget({width, height}) {
  return Image.asset(icAppLogo)
      .box
      .white
      .size(77, 77)
      .padding(const EdgeInsets.all(8))
      .rounded
      .make();
}
