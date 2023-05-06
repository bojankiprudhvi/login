import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:login/auth_controller.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    List image = ["g.png", "f.png", "t.png"];
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
                  image: AssetImage("img/signup.png"), fit: BoxFit.fill)),
          child: Column(children: [
            SizedBox(
              height: height * 0.14,
            ),
            CircleAvatar(
              backgroundColor: Colors.white70,
              radius: 50,
              backgroundImage: AssetImage("img/profile1.png"),
            )
          ]),
        ),
        Container(
          margin: const EdgeInsets.only(left: 20, right: 20),
          width: width,
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
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
          ]),
        ),
        SizedBox(
          height: 50,
        ),
        GestureDetector(
          onTap: () {
            AuthController.instance.register(
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
                "Sign up",
                style: TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        RichText(
            text: TextSpan(
                recognizer: TapGestureRecognizer()..onTap = () => Get.back(),
                text: "Have an account?",
                style: TextStyle(fontSize: 20, color: Colors.grey[500]))),
        SizedBox(
          height: width * 0.08,
        ),
        RichText(
            text: TextSpan(
          text: "Sign up using one of the following methods",
          style: TextStyle(color: Colors.grey[500], fontSize: 16),
        )),
        Wrap(
          children: List<Widget>.generate(3, (index) {
            return Padding(
              padding: const EdgeInsets.all(10.0),
              child: CircleAvatar(
                radius: 30,
                backgroundColor: Colors.grey[500],
                child: CircleAvatar(
                  radius: 25,
                  backgroundImage: AssetImage("img/" + image[index]),
                ),
              ),
            );
          }),
        )
      ]),
    );
  }
}
