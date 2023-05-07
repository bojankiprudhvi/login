import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:login/auth_controller.dart';
import 'package:login/pages/login_page.dart';
class ProfilePage extends StatefulWidget {
  final String uid;
  const ProfilePage({super.key,required this.uid});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  var userData = {};
  bool isLoading = false;
  var postLength = 0;
  var followers = 0;
  var following = 0;
  bool isFollowing = false;

  @override
  void initState() {
    // FirebaseAuth.instance.signOut();
    super.initState();
    getData();
  }

  getData() async {
    try {
      setState(() {
        isLoading = true;
      });
      //  devtools.log(widget.uid);
      // devtools.log(FirebaseAuth.instance.currentUser!.uid);
      // Getting user's data
      DocumentSnapshot<Map<String, dynamic>> getUserData =
      await FirebaseFirestore.instance
          .collection("users")
          .doc(widget.uid)
          .get();
      setState(() {
        userData = getUserData.data()!;
        followers = getUserData.data()!["followers"].length;
        following = getUserData.data()!["following"].length;
        isFollowing = getUserData
            .data()!["followers"]
            .contains(FirebaseAuth.instance.currentUser!.uid);
      });

      // Getting posts length
      QuerySnapshot<Map<String, dynamic>> getPostsLength =
      await FirebaseFirestore.instance
          .collection("posts")
          .where("uid", isEqualTo: widget.uid)
          .get();

      setState(() {
        postLength = getPostsLength.docs.length;
      });

      setState(() {
        isLoading = false;
      });
    } catch (e) {
      //  devtools.log(e.toString());
    }
  }

  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
//return Scaffold();
    return isLoading == true
        ?  Container(
      color: Colors.white,

      child:Center(

        child: CircularProgressIndicator(
          color: Colors.redAccent,
        ),
      ),)
        :
    Scaffold(
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
              backgroundImage: NetworkImage(userData["photoUrl"]),
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
                userData["username"],
                style: TextStyle(fontSize: 18, color: Colors.grey[500]),
              ),
              Text(
                userData["email"],
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
            //Navigator.popUntil(context, (route) => route.isFirst);

            // AuthMethods().signout();
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                  const LoginPage(),
                ));
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
