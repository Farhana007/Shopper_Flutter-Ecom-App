import 'package:shoppers/consts/consts.dart';

Widget ourButton({title, onPress, color, textColor}) {
  return ElevatedButton(
      onPressed: onPress,
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        padding: const EdgeInsets.all(12),
      ),
      child: "$title".text.color(textColor).fontFamily(bold).make());
}
