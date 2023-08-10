import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shoppers/consts/consts.dart';
import 'package:shoppers/services/firestore_services.dart';
import 'package:shoppers/views/category_screen/item_details.dart';
import 'package:shoppers/views/widgets_common/loading_indicator.dart';
import 'package:get/get.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key, this.title});
  final String? title;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: "$title".text.color(darkFontGrey).make(),
      ),
      backgroundColor: whiteColor,
      body: FutureBuilder(
        future: FirestoreServices.searchProducts(title),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: loadingIndicator(),
            );
          } else if (snapshot.data!.docs.isEmpty) {
            return "No products found".text.makeCentered();
          } else {
            var data = snapshot.data!.docs;
            var filtered = data
                .where((element) => element['p_name']
                    .toString()
                    .toLowerCase()
                    .contains(title!.toLowerCase()))
                .toList();
            return Container(
              padding: const EdgeInsets.all(8.0),
              child: GridView(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                    mainAxisExtent: 300),
                children: filtered
                    .mapIndexed((currentValue, index) => Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Image.network(
                              filtered[index]['p_img'][0],
                              width: 200,
                              height: 200,
                              fit: BoxFit.cover,
                            ),
                            const Spacer(),
                            "${filtered[index]['p_name']}"
                                .text
                                .color(darkFontGrey)
                                .fontFamily(semibold)
                                .make(),
                            10.heightBox,
                            "${filtered[index]['p_price']}"
                                .numCurrency
                                .text
                                .fontFamily(bold)
                                .color(amberColor)
                                .size(16)
                                .make()
                          ],
                        )
                            .box
                            .roundedSM
                            .margin(const EdgeInsets.symmetric(horizontal: 4))
                            .padding(
                              const EdgeInsets.all(12),
                            )
                            .white
                            .outerShadowMd
                            .make()
                            .onTap(() {
                          Get.to(() => ItemDetails(
                              title: filtered[index]['p_name'],
                              data: filtered[index]));
                        }))
                    .toList(),
              ),
            );
          }
        },
      ),
    );
  }
}
