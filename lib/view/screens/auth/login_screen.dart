import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tiktok_clone/constants.dart';
import 'package:tiktok_clone/controller/auth_controller.dart';
import 'package:tiktok_clone/view/screens/auth/signup_screen.dart';
import 'package:tiktok_clone/view/widgets/glitch_effect.dart';
import 'package:tiktok_clone/view/widgets/text_input.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
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
              "Login",
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.w900,
              ),
            ),
            const SizedBox(
              height: 25,
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
              height: 25,
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.symmetric(horizontal: 20),
              child: TextInputField(
                controller: _passwordController,
                myLabelText: "Password",
                myIcon: Icons.lock,
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            InkWell(
              onTap: () {
                AuthController.instance
                    .loginUser(_emailController.text, _passwordController.text);
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
                    "Login",
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
                  "Don\'t have an account ?",
                  style: TextStyle(fontSize: 20),
                ),
                const SizedBox(
                  width: 10,
                ),
                InkWell(
                  onTap: () {
                    Get.to(() => SignupScreen());
                  },
                  child: Text(
                    "Register",
                    style: TextStyle(fontSize: 20, color: buttonColor),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
