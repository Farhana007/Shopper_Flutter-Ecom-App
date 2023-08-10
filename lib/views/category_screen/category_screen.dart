import 'package:shoppers/consts/consts.dart';
import 'package:shoppers/consts/lists.dart';
import 'package:shoppers/controllers/product_controller.dart';
import 'package:shoppers/views/category_screen/category_details.dart';
import 'package:shoppers/views/widgets_common/bg_widget.dart';
import 'package:get/get.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ProductController());
    return bgWidget(
        child: Scaffold(
      appBar: AppBar(title: category.text.white.fontFamily(bold).make()),
      body: Container(
        padding: const EdgeInsets.all(12),
        child: GridView.builder(
            shrinkWrap: true,
            itemCount: 9,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              mainAxisSpacing: 8,
              crossAxisSpacing: 8,
              mainAxisExtent: 200,
            ),
            itemBuilder: (context, index) {
              return Column(
                children: [
                  Image.asset(
                    categoriesImages[index],
                    height: 120,
                    width: 200,
                    fit: BoxFit.cover,
                  ),
                  10.heightBox,
                  categoreisList[index]
                      .text
                      .color(darkFontGrey)
                      .align(TextAlign.center)
                      .make(),
                ],
              )
                  .box
                  .white
                  .rounded
                  .clip(Clip.antiAlias)
                  .outerShadow
                  .make()
                  .onTap(() {
                controller.getSubCategories(categoreisList[index]);
                Get.to(CategoryDetails(title: categoreisList[index]));
              });
            }),
      ),
    ));
  }
}
