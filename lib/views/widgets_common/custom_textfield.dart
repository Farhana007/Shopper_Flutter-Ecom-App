import 'package:shoppers/consts/consts.dart';

Widget customTextField({String? title, String? hint, controller, isPass}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      title!.text.color(amberColor).fontFamily(semibold).size(16).make(),
      5.heightBox,
      TextFormField(
        obscureText: isPass,
        controller: controller,
        decoration: InputDecoration(
            isDense: true,
            fillColor: lightGrey,
            hintText: hint,
            hintStyle:
                const TextStyle(fontFamily: semibold, color: textfieldGrey),
            filled: true,
            border: InputBorder.none,
            focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: amberColor))),
      ),
      5.heightBox,
    ],
  );
}
