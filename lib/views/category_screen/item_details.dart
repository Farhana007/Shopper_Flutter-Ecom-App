import 'package:shoppers/consts/consts.dart';
import 'package:shoppers/consts/lists.dart';
import 'package:shoppers/controllers/product_controller.dart';
import 'package:shoppers/views/chat_screen/chat_screen.dart';
import 'package:shoppers/views/widgets_common/our_button.dart';
import 'package:get/get.dart';

class ItemDetails extends StatelessWidget {
  const ItemDetails({super.key, required this.title, required this.data});
  final String? title;
  final dynamic data;
  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ProductController());
    return WillPopScope(
      onWillPop: () async {
        controller.resetValue();
        return true;
      },
      child: Scaffold(
        backgroundColor: whiteColor,
        appBar: AppBar(
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                controller.resetValue();
                Get.back();
              },
            ),
            title: title!.text.color(darkFontGrey).fontFamily(bold).make(),
            actions: [
              IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.share,
                  )),
              Obx(
                () => IconButton(
                    onPressed: () {
                      if (controller.isFav.value) {
                        controller.removeFromWishlist(data.id, context);
                        controller.isFav(false);
                      } else {
                        controller.addToWishlist(data.id, context);
                        controller.isFav(true);
                      }
                    },
                    icon: Icon(
                      Icons.favorite_outlined,
                      color: controller.isFav.value ? amberColor : darkFontGrey,
                    )),
              )
            ]),
        body: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      VxSwiper.builder(
                          autoPlay: true,
                          aspectRatio: 16 / 9,
                          height: 350,
                          viewportFraction: 1.0,
                          itemCount: data['p_img'].length,
                          itemBuilder: (context, index) {
                            return Image.network(
                              data['p_img'][index],
                              width: double.infinity,
                              fit: BoxFit.fitHeight,
                            );
                          }),
                      10.heightBox,
                      title!.text
                          .fontFamily(semibold)
                          .color(darkFontGrey)
                          .size(16)
                          .make(),
                      10.heightBox,
                      VxRating(
                        isSelectable: false,
                        value: double.parse(data['p_rating']),
                        onRatingUpdate: (value) {},
                        selectionColor: golden,
                        normalColor: textfieldGrey,
                        size: 25,
                        count: 5,
                        maxRating: 5,
                      ),
                      10.heightBox,
                      "${data['p_price']}"
                          .numCurrency
                          .text
                          .color(Colors.red)
                          .fontFamily(bold)
                          .size(18)
                          .make(),
                      10.heightBox,
                      Row(
                        children: [
                          Expanded(
                              child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              "Seller".text.white.fontFamily(semibold).make(),
                              5.heightBox,
                              "${data['p_seller']}"
                                  .text
                                  .fontFamily(semibold)
                                  .size(16)
                                  .color(darkFontGrey)
                                  .make(),
                            ],
                          )),
                          const CircleAvatar(
                            backgroundColor: Colors.white,
                            child: Icon(
                              Icons.message_rounded,
                              color: darkFontGrey,
                            ),
                          ).onTap(() {
                            Get.to(() => const ChatScreen(), arguments: [
                              data['p_seller'],
                              data['vendor_id']
                            ]);
                          })
                        ],
                      )
                          .box
                          .height(60)
                          .padding(const EdgeInsets.symmetric(horizontal: 16))
                          .color(textfieldGrey)
                          .make(),
                      20.heightBox,
                      Obx(
                        () => Column(
                          children: [
                            Row(
                              children: [
                                SizedBox(
                                  width: 100,
                                  child: "Color :"
                                      .text
                                      .color(textfieldGrey)
                                      .make(),
                                ),
                                Row(
                                  children: List.generate(
                                      data['p_colors'].length,
                                      (index) => Stack(
                                              alignment: Alignment.center,
                                              children: [
                                                VxBox()
                                                    .size(40, 40)
                                                    .margin(const EdgeInsets
                                                            .symmetric(
                                                        horizontal: 4))
                                                    .color(Color(
                                                            data['p_colors']
                                                                [index])
                                                        .withOpacity(1.0))
                                                    .roundedFull
                                                    .make()
                                                    .onTap(() {
                                                  controller
                                                      .changeColorIndex(index);
                                                }),
                                                Visibility(
                                                    visible: index ==
                                                        controller
                                                            .colorIndex.value,
                                                    child: const Icon(
                                                      Icons.done,
                                                      color: Colors.white,
                                                    ))
                                              ])),
                                ),
                              ],
                            ).box.padding(const EdgeInsets.all(8)).make(),
                            //const Divider(),
                            Row(
                              children: [
                                SizedBox(
                                  width: 100,
                                  child: "Quantity :"
                                      .text
                                      .color(textfieldGrey)
                                      .make(),
                                ),
                                Obx(
                                  () => Row(
                                    children: [
                                      IconButton(
                                          onPressed: () {
                                            controller.decreaseQuantity();
                                            controller.calculateTotalPrice(
                                                int.parse(data['p_price']));
                                          },
                                          icon: const Icon(Icons.remove)),
                                      controller.quantity.value.text
                                          .color(darkFontGrey)
                                          .size(16)
                                          .fontFamily(bold)
                                          .make(),
                                      IconButton(
                                          onPressed: () {
                                            controller.increaseQuantity(
                                                int.parse(data['p_quantity']));
                                            controller.calculateTotalPrice(
                                                int.parse(data['p_price']));
                                          },
                                          icon: const Icon(Icons.add)),
                                      10.widthBox,
                                      "(${data['p_quantity']} available)"
                                          .text
                                          .color(textfieldGrey)
                                          .make(),
                                    ],
                                  ),
                                ),
                              ],
                            ).box.padding(const EdgeInsets.all(8)).make(),
                            //const Divider(),
                            Row(
                              children: [
                                SizedBox(
                                  width: 100,
                                  child: "Total :"
                                      .text
                                      .color(textfieldGrey)
                                      .make(),
                                ),
                                Row(
                                  children: [
                                    "${controller.totalPrice.value}"
                                        .numCurrency
                                        .text
                                        .fontFamily(bold)
                                        .color(Colors.red)
                                        .make()
                                  ],
                                ),
                              ],
                            ).box.padding(const EdgeInsets.all(8)).make()
                          ],
                        ).box.white.shadowSm.make(),
                      ),
                      10.heightBox,
                      "Description"
                          .text
                          .color(darkFontGrey)
                          .fontFamily(semibold)
                          .make(),
                      10.heightBox,
                      "${data['p_description']}"
                          .text
                          .color(darkFontGrey)
                          .make(),
                      10.heightBox,
                      ListView(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        children: List.generate(
                            itemDetailsButtonsList.length,
                            (index) => ListTile(
                                  title: itemDetailsButtonsList[index]
                                      .text
                                      .color(darkFontGrey)
                                      .fontFamily(semibold)
                                      .make(),
                                  trailing: const Icon(Icons.arrow_forward),
                                )),
                      ),
                      20.heightBox,
                      productyoumaylike.text
                          .size(16)
                          .color(darkFontGrey)
                          .fontFamily(bold)
                          .make(),
                      10.heightBox,
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: List.generate(
                              6,
                              (index) => Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Image.asset(
                                        imgP1,
                                        width: 150,
                                        fit: BoxFit.cover,
                                      ),
                                      10.heightBox,
                                      "Laptop 4GB/6GB"
                                          .text
                                          .color(darkFontGrey)
                                          .fontFamily(semibold)
                                          .make(),
                                      10.heightBox,
                                      "\$600"
                                          .text
                                          .fontFamily(bold)
                                          .color(amberColor)
                                          .size(16)
                                          .make()
                                    ],
                                  )
                                      .box
                                      .roundedSM
                                      .margin(const EdgeInsets.symmetric(
                                          horizontal: 4))
                                      .white
                                      .padding(const EdgeInsets.all(8))
                                      .make()),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              width: double.infinity,
              height: 60,
              child: ourButton(
                  color: amberColor,
                  onPress: () {
                    if (controller.quantity.value == 0) {
                      VxToast.show(context,
                          msg: "Choose at-least one product to add to cart");
                    } else {
                      controller.addToCart(
                        color: data['p_colors'][controller.colorIndex.value],
                        context: context,
                        title: data['p_name'],
                        vendorId: data['vendor_id'],
                        img: data['p_img'][0],
                        qyt: controller.quantity.value,
                        sellername: data['p_seller'],
                        tprice: controller.totalPrice.value,
                      );
                      VxToast.show(context, msg: "Added to Cart");
                    }
                  },
                  textColor: whiteColor,
                  title: "Add to cart"),
            )
          ],
        ),
      ),
    );
  }
}
