import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:login/auth_controller.dart';

class WelcomePage extends StatelessWidget {
  String email;
  WelcomePage({super.key, required this.email});
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
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
        SizedBox(
          height: 50,
        ),
        Container(
          margin: const EdgeInsets.only(left: 20),
          width: width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Welcome",
                style: TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                    color: Colors.black54),
              ),
              Text(
                email,
                style: TextStyle(fontSize: 18, color: Colors.grey[500]),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 200,
        ),
        GestureDetector(
          onTap: () {
            AuthController.instance.logout();
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
                "Sign out",
                style: TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),
          ),
        ),
      ]),
    );
  }
}
