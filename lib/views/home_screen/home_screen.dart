import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shoppers/consts/consts.dart';
import 'package:shoppers/consts/lists.dart';
import 'package:shoppers/controllers/home_controller.dart';
import 'package:shoppers/services/firestore_services.dart';
import 'package:shoppers/views/category_screen/item_details.dart';
import 'package:shoppers/views/home_screen/components/featured_button.dart';
import 'package:shoppers/views/home_screen/components/search_screen.dart';
import 'package:shoppers/views/widgets_common/home_buttons.dart';
import 'package:shoppers/views/widgets_common/loading_indicator.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<HomeController>();
    return Scaffold(
      body: Container(
        width: context.screenWidth,
        height: context.screenHeight,
        color: lightGrey,
        padding: const EdgeInsets.all(12),
        child: SafeArea(
            child: Column(
          children: [
            Container(
              height: 60,
              alignment: Alignment.center,
              color: lightGrey,
              child: TextField(
                controller: controller.searchController,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  suffixIcon: const Icon(Icons.search).onTap(() {
                    if (controller.searchController.text.isNotEmptyAndNotNull) {
                      Get.to(() => SearchScreen(
                            title: controller.searchController.text,
                          ));
                    }
                  }),
                  fillColor: whiteColor,
                  filled: true,
                  hintText: searchAnything,
                  hintStyle: const TextStyle(color: textfieldGrey),
                ),
              ),
            ),
            20.heightBox,
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    VxSwiper.builder(
                      aspectRatio: 16 / 9,
                      autoPlay: true,
                      height: 150,
                      enlargeCenterPage: true,
                      itemCount: sliderList.length,
                      itemBuilder: (context, index) {
                        return Image.asset(
                          sliderList[index],
                          fit: BoxFit.fill,
                        )
                            .box
                            .rounded
                            .margin(const EdgeInsets.symmetric(horizontal: 8))
                            .clip(Clip.antiAlias)
                            .make();
                      },
                    ),
                    20.heightBox,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: List.generate(
                          2,
                          (index) => homeButtons(
                              width: context.screenWidth / 2.5,
                              height: context.screenHeight * 0.15,
                              title: index == 0 ? todayDeal : flashsale,
                              icon: index == 0 ? icTodaysDeal : icFlashDeal,
                              onPress: () {})),
                    ),
                    20.heightBox,
                    VxSwiper.builder(
                      aspectRatio: 16 / 9,
                      autoPlay: true,
                      height: 150,
                      enlargeCenterPage: true,
                      itemCount: secondSliderList.length,
                      itemBuilder: (context, index) {
                        return Image.asset(
                          secondSliderList[index],
                          fit: BoxFit.fill,
                        )
                            .box
                            .rounded
                            .margin(const EdgeInsets.symmetric(horizontal: 8))
                            .clip(Clip.antiAlias)
                            .make();
                      },
                    ),
                    20.heightBox,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: List.generate(
                        3,
                        (index) => homeButtons(
                          width: context.screenWidth / 3.5,
                          height: context.screenHeight * 0.15,
                          icon: index == 0
                              ? icTopCategories
                              : index == 1
                                  ? icBrands
                                  : icTopSeller,
                          onPress: () {},
                          title: index == 0
                              ? topCategories
                              : index == 1
                                  ? brands
                                  : topSellers,
                        ),
                      ),
                    ),
                    20.heightBox,
                    Align(
                        alignment: Alignment.centerLeft,
                        child: featuredCategories.text
                            .color(darkFontGrey)
                            .fontFamily(semibold)
                            .size(18)
                            .make()),
                    20.heightBox,
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: List.generate(
                            3,
                            (index) => Column(
                                  children: [
                                    featuredButton(
                                        icon: featuredImage1[index],
                                        title: featuredTitles1[index]),
                                    20.heightBox,
                                    featuredButton(
                                        icon: featuredImage2[index],
                                        title: featuredTitles2[index]),
                                  ],
                                )).toList(),
                      ),
                    ),
                    20.heightBox,
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(12),
                      decoration: const BoxDecoration(
                        color: amberColor,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          featuredProduct.text.white
                              .size(18)
                              .fontFamily(bold)
                              .make(),
                          10.heightBox,
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: FutureBuilder(
                              future: FirestoreServices.getFeatureProducts(),
                              builder: (context,
                                  AsyncSnapshot<QuerySnapshot> snapshot) {
                                if (!snapshot.hasData) {
                                  return Center(
                                    child: loadingIndicator(),
                                  );
                                } else if (snapshot.data!.docs.isEmpty) {
                                  return "No featured products"
                                      .text
                                      .white
                                      .makeCentered();
                                } else {
                                  var featuredData = snapshot.data!.docs;
                                  return Row(
                                    children: List.generate(
                                      featuredData.length,
                                      (index) => Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Image.network(
                                            featuredData[index]['p_img'][0],
                                            width: 150,
                                            height: 150,
                                            fit: BoxFit.cover,
                                          ),
                                          10.heightBox,
                                          "${featuredData[index]['p_name']}"
                                              .text
                                              .color(darkFontGrey)
                                              .fontFamily(semibold)
                                              .make(),
                                          10.heightBox,
                                          "${featuredData[index]['p_price']}"
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
                                          .margin(const EdgeInsets.symmetric(
                                              horizontal: 4))
                                          .white
                                          .padding(const EdgeInsets.all(8))
                                          .make()
                                          .onTap(() {
                                        Get.to(() => ItemDetails(
                                            title: featuredData[index]
                                                ['p_name'],
                                            data: featuredData[index]));
                                      }),
                                    ),
                                  );
                                }
                              },
                            ),
                          )
                        ],
                      ),
                    ),
                    20.heightBox,
                    VxSwiper.builder(
                      aspectRatio: 16 / 9,
                      autoPlay: true,
                      height: 150,
                      enlargeCenterPage: true,
                      itemCount: secondSliderList.length,
                      itemBuilder: (context, index) {
                        return Image.asset(
                          secondSliderList[index],
                          fit: BoxFit.fill,
                        )
                            .box
                            .rounded
                            .margin(const EdgeInsets.symmetric(horizontal: 8))
                            .clip(Clip.antiAlias)
                            .make();
                      },
                    ),
                    20.heightBox,
                    StreamBuilder(
                      stream: FirestoreServices.getAllProduct(),
                      builder: (BuildContext context,
                          AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (!snapshot.hasData) {
                          return loadingIndicator();
                        } else {
                          var allProducts = snapshot.data!.docs;
                          return GridView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: allProducts.length,
                            shrinkWrap: true,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              mainAxisSpacing: 8,
                              crossAxisSpacing: 8,
                              mainAxisExtent: 300,
                            ),
                            itemBuilder: (context, index) {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Image.network(
                                    allProducts[index]['p_img'][0],
                                    width: 200,
                                    height: 200,
                                    fit: BoxFit.cover,
                                  ),
                                  const Spacer(),
                                  "${allProducts[index]['p_name']}"
                                      .text
                                      .color(darkFontGrey)
                                      .fontFamily(semibold)
                                      .make(),
                                  10.heightBox,
                                  "${allProducts[index]['p_price']}"
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
                                  .margin(
                                      const EdgeInsets.symmetric(horizontal: 4))
                                  .padding(
                                    const EdgeInsets.all(12),
                                  )
                                  .white
                                  .make()
                                  .onTap(
                                () {
                                  Get.to(ItemDetails(
                                      title: allProducts[index]['p_name'],
                                      data: allProducts[index]));
                                },
                              );
                            },
                          );
                        }
                      },
                    )
                  ],
                ),
              ),
            ),
          ],
        )),
      ),
    );
  }
}
