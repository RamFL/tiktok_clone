import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tiktok_clone/constants.dart';
import 'package:tiktok_clone/controller/auth_controller.dart';
import 'package:tiktok_clone/view/screens/auth/login_screen.dart';
import 'package:tiktok_clone/view/widgets/glitch_effect.dart';
import 'package:tiktok_clone/view/widgets/text_input.dart';

class SignupScreen extends StatelessWidget {
  SignupScreen({Key? key}) : super(key: key);

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _setpasswordController = TextEditingController();
  final TextEditingController _retypepasswordController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GlithEffect(
                child: const Text(
                  "TikTok Clone",
                  style: TextStyle(
                    fontSize: 35,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              const Text(
                "Welcome to Apna TikTok !",
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w900,
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              Stack(
                children: [
                  const CircleAvatar(
                    radius: 64,
                    backgroundImage: NetworkImage(
                        "https://icon-library.com/images/default-user-icon/default-user-icon-13.jpg"),
                  ),
                  Positioned(
                    bottom: -10,
                    left: 80,
                    child: IconButton(
                      onPressed: () {
                        AuthController.instance.pickImage();
                      },
                      icon: const Icon(
                        Icons.add_a_photo,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.symmetric(horizontal: 20),
                child: TextInputField(
                  controller: _usernameController,
                  myLabelText: "UserName",
                  myIcon: Icons.person,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.symmetric(horizontal: 20),
                child: TextInputField(
                  controller: _emailController,
                  myLabelText: "Email",
                  myIcon: Icons.email,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.symmetric(horizontal: 20),
                child: TextInputField(
                  controller: _setpasswordController,
                  myLabelText: "Set Password",
                  myIcon: Icons.lock,
                  toHide: true,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.symmetric(horizontal: 20),
                child: TextInputField(
                  controller: _retypepasswordController,
                  myLabelText: "Retype Password",
                  myIcon: Icons.lock,
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              InkWell(
                onTap: () {
                  AuthController.instance.signUp(
                      _usernameController.text,
                      _emailController.text,
                      _setpasswordController.text,
                      AuthController.instance.profilePhoto);
                },
                child: Container(
                  width: MediaQuery.of(context).size.width - 40,
                  height: 50,
                  decoration: BoxDecoration(
                    color: buttonColor,
                    borderRadius: const BorderRadius.all(
                      Radius.circular(5),
                    ),
                  ),
                  child: const Center(
                    child: Text(
                      "SignUp",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Already have an account ?",
                    style: TextStyle(fontSize: 20),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  InkWell(
                    onTap: () {
                      Get.to(() => LoginScreen());
                    },
                    child: Text(
                      "Login",
                      style: TextStyle(fontSize: 20, color: buttonColor),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
