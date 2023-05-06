import 'dart:ffi';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:login/auth_controller.dart';
import 'package:login/pages/signup_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: Column(children: [
        Container(
          width: width,
          height: height * 0.3,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("img/loginimg.png"), fit: BoxFit.fill)),
        ),
        Container(
          margin: const EdgeInsets.only(left: 20, right: 20),
          width: width,
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(
              "Hello",
              style: TextStyle(fontSize: 70, fontWeight: FontWeight.bold),
            ),
            Text(
              "Sign into your account",
              style: TextStyle(fontSize: 20, color: Colors.grey[500]),
            ),
            SizedBox(
              height: 50,
            ),
            Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [
                    BoxShadow(
                        blurRadius: 10,
                        offset: Offset(1, 1),
                        color: Colors.grey.withOpacity(0.4))
                  ]),
              child: TextField(
                controller: emailController,
                decoration: InputDecoration(
                    hintText: "Email",
                    prefixIcon: Icon(
                      Icons.email,
                      color: Colors.deepOrangeAccent,
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide:
                            BorderSide(color: Colors.white, width: 1.0)),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide:
                            BorderSide(color: Colors.white, width: 1.0)),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30))),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [
                    BoxShadow(
                        blurRadius: 10,
                        offset: Offset(1, 1),
                        color: Colors.grey.withOpacity(0.4))
                  ]),
              child: TextField(
                controller: passwordController,
                obscureText: true,
                decoration: InputDecoration(
                    hintText: "Password",
                    prefixIcon: Icon(
                      Icons.password,
                      color: Colors.deepOrangeAccent,
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide:
                            BorderSide(color: Colors.white, width: 1.0)),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide:
                            BorderSide(color: Colors.white, width: 1.0)),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30))),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Expanded(child: Container()),
                Text("Forgot your Password?"),
              ],
            )
          ]),
        ),
        SizedBox(
          height: 50,
        ),
        GestureDetector(
          onTap: () {
            AuthController.instance.login(
                emailController.text.trim(), passwordController.text.trim());
          },
          child: Container(
            width: width * 0.5,
            height: height * 0.08,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                image: DecorationImage(
                    image: AssetImage("img/loginbtn.png"), fit: BoxFit.fill)),
            child: Center(
              child: Text(
                "Sign in",
                style: TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),
          ),
        ),
        SizedBox(
          height: width * 0.08,
        ),
        RichText(
            text: TextSpan(
                text: "Don\'t have an account?",
                style: TextStyle(color: Colors.grey[500], fontSize: 20),
                children: [
              TextSpan(
                text: " Create",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
                recognizer: TapGestureRecognizer()
                  ..onTap = () => Get.to(() => SignUpPage()),
              ),
            ])),
      ]),
    );
  }
}
