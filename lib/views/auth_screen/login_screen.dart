import 'package:shoppers/consts/consts.dart';
import 'package:shoppers/consts/lists.dart';
import 'package:shoppers/controllers/auth_controller.dart';
import 'package:shoppers/views/auth_screen/signup_screen.dart';
import 'package:shoppers/views/home_screen/home.dart';
import 'package:shoppers/views/widgets_common/app_logo_widget.dart';
import 'package:shoppers/views/widgets_common/bg_widget.dart';
import 'package:shoppers/views/widgets_common/custom_textfield.dart';
import 'package:shoppers/views/widgets_common/our_button.dart';
import 'package:get/get.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(AuthController());

    return bgWidget(
        child: Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Column(
          children: [
            (context.screenHeight * 0.1).heightBox,
            applogoWidget(),
            10.heightBox,
            "Log in to $appname".text.fontFamily(bold).white.size(18).make(),
            15.heightBox,
            Obx(
              () => Column(
                children: [
                  customTextField(
                      title: email,
                      hint: emailHint,
                      isPass: false,
                      controller: controller.emailController),
                  customTextField(
                      title: password,
                      hint: passwordHint,
                      isPass: true,
                      controller: controller.passwordController),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {},
                      child: forgotPass.text.make(),
                    ),
                  ),
                  5.heightBox,
                  controller.isLoging.value
                      ? const CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation(amberColor),
                        )
                      : ourButton(
                          color: amberColor,
                          title: login,
                          textColor: whiteColor,
                          onPress: () async {
                            controller.isLoging(true);
                            await controller
                                .loginMethod(context: context)
                                .then((value) {
                              if (value != null) {
                                VxToast.show(context, msg: loggedin);
                                Get.offAll(() => const Home());
                              } else {
                                controller.isLoging(false);
                              }
                            });
                          }).box.width(context.screenWidth - 50).make(),
                  5.heightBox,
                  createNewAccount.text.color(fontGrey).make(),
                  5.heightBox,
                  ourButton(
                      color: lightgolden,
                      title: signup,
                      textColor: amberColor,
                      onPress: () {
                        Get.to(const SignupScreen());
                      }).box.width(context.screenWidth - 50).make(),
                  10.heightBox,
                  loginwith.text.color(fontGrey).make(),
                  5.heightBox,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                        3,
                        (index) => Padding(
                              padding: const EdgeInsets.all(8),
                              child: CircleAvatar(
                                radius: 25,
                                backgroundColor: lightGrey,
                                child: Image.asset(
                                  socialIconList[index],
                                  width: 30,
                                ),
                              ),
                            )),
                  )
                  //ourButton(title: login, onPress: (){},color: amberColor,textColor: whiteColor).box.width(context.screenWidth-50).make()
                ],
              )
                  .box
                  .white
                  .rounded
                  .padding(const EdgeInsets.all(16))
                  .width(context.screenWidth - 70)
                  .shadowSm
                  .make(),
            ),
          ],
        ),
      ),
    ));
  }
}
