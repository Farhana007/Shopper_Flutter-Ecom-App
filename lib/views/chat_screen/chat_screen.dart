import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shoppers/consts/consts.dart';
import 'package:shoppers/controllers/chats_controller.dart';
import 'package:shoppers/services/firestore_services.dart';
import 'package:shoppers/views/chat_screen/components/sender_bubble.dart';
import 'package:shoppers/views/widgets_common/loading_indicator.dart';
import 'package:get/get.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ChatsController());

    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title: "${controller.friendName}"
            .text
            .fontFamily(semibold)
            .color(darkFontGrey)
            .make(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            Expanded(
                child: StreamBuilder(
                    stream: FirestoreServices.getChatMessages(
                        controller.chatDocId.toString()),
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (!snapshot.hasData) {
                        return Center(
                          child: loadingIndicator(),
                        );
                      } else if (snapshot.data!.docs.isEmpty) {
                        return Center(
                          child:
                              "Send a message".text.color(darkFontGrey).make(),
                        );
                      } else {
                        return ListView(
                            children: snapshot.data!.docs
                                .mapIndexed((currentValue, index) {
                          var data = snapshot.data!.docs[index];
                          return Align(
                              alignment: data['uid'] == currentUser!.uid
                                  ? Alignment.centerRight
                                  : Alignment.centerLeft,
                              child: senderBubble(data));
                        }).toList());
                      }
                    })),
            10.heightBox,
            Row(
              children: [
                Obx(
                  () => controller.isLoading.value
                      ? Center(
                          child: loadingIndicator(),
                        )
                      : Expanded(
                          child: TextField(
                            controller: controller.msgController,
                            decoration: const InputDecoration(
                              hintText: "Type a message...",
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: textfieldGrey,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: textfieldGrey,
                                ),
                              ),
                            ),
                          ),
                        ),
                ),
                IconButton(
                  onPressed: () {
                    controller.sendMsg(controller.msgController.text);
                    controller.msgController.clear();
                  },
                  icon: const Icon(Icons.send),
                  color: Colors.blue,
                )
              ],
            )
                .box
                .height(80)
                .padding(const EdgeInsets.all(12))
                .margin(const EdgeInsets.only(bottom: 8))
                .make(),
          ],
        ),
      ),
    );
  }
}
