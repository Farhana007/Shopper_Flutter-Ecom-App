import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shoppers/consts/consts.dart';
import 'package:shoppers/services/firestore_services.dart';
import 'package:shoppers/views/widgets_common/loading_indicator.dart';

class WishlistScreen extends StatelessWidget {
  const WishlistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            "My Wishlist".text.fontFamily(semibold).color(darkFontGrey).make(),
      ),
      backgroundColor: whiteColor,
      body: StreamBuilder(
        stream: FirestoreServices.getAllWishlist(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: loadingIndicator(),
            );
          } else if (snapshot.data!.docs.isEmpty) {
            return "No items in wishlist yet!"
                .text
                .fontFamily(semibold)
                .color(darkFontGrey)
                .makeCentered();
          } else {
            var data = snapshot.data!.docs;
            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: data.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ListTile(
                        leading: SizedBox(
                          width: 80,
                          child: Image.network(
                            '${data[index]['p_img']}',
                            fit: BoxFit.cover,
                          ),
                        ),
                        title: "${data[index]['p_name']}"
                            .text
                            .size(16)
                            .fontFamily(semibold)
                            .make(),
                        subtitle: "${data[index]['p_price']}"
                            .numCurrency
                            .text
                            .color(Colors.red)
                            .fontFamily(semibold)
                            .make(),
                        trailing: const Icon(
                          Icons.favorite,
                          color: amberColor,
                        ).onTap(() async {
                          await firestore
                              .collection(productsCollection)
                              .doc(data[index].id)
                              .set({
                            'p_wishlist':
                                FieldValue.arrayRemove([currentUser!.uid])
                          }, SetOptions(merge: true));
                        }),
                      );
                    },
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
