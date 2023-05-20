import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:login/auth_controller.dart';
import 'package:login/pages/login_page.dart';
import 'package:login/pages/profile_page.dart';
import 'package:login/pages/user_posts.dart';
import 'package:login/pages/wish_list.dart';

import 'package:login/pages/add_post.dart';
import 'package:login/pages/feed_page.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

/*class _WelcomePageState extends State<WelcomePage> {
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
//return Scaffold();
    return Scaffold(
      backgroundColor: Colors.white,
      body: PageView(
        children: [
          FeedScreen(),
          WishList(),
          AddPostScreen(),
          UserPostList(),
          ProfilePage(
            uid: FirebaseAuth.instance.currentUser!.uid,
          ),
        ],
      ),
      bottomNavigationBar: Container(
        height: height * 0.13,
        decoration: BoxDecoration(
            // borderRadius: BorderRadius.circular(30),
            image: DecorationImage(
                image: AssetImage("img/loginbtn.png"), fit: BoxFit.cover)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 10),
          child: GNav(
              //gap: 4,
              //  backgroundColor: Colors.black,
              iconSize: 50,
              color: Colors.white,
              activeColor: Colors.white,
              tabBackgroundColor: Colors.grey.shade500,
              hoverColor: Colors.grey.shade500,
              tabs: [
                GButton(
                  icon: Icons.home,
                  text: "",
                ),
                GButton(icon: Icons.favorite_border, text: ""),
                GButton(icon: Icons.add, text: ""),
                GButton(
                  icon: Icons.image,
                  // text: " ",
                 ),
                GButton(icon: Icons.person, text: ""),
              ]),
        ),
      ),
    );
  }
}

*/
class _WelcomePageState extends State<WelcomePage> {
  var userData = {};
  var uid = FirebaseAuth.instance.currentUser!.uid;
  bool isLoading = true;
  var postLength = 0;
  var followers = 0;
  var following = 0;
  bool isFollowing = false;
  int _counter = 0;
  bool isTravel = true;
  var AppColor = Colors.green;
  int _selectedIndex = 0;
  static const List<Widget> _widgetOptions = <Widget>[
    FeedScreen(),
    WishList(),
    AddPostScreen(),
    UserPostList(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

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
          await FirebaseFirestore.instance.collection("users").doc(uid).get();
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
              .where("uid", isEqualTo: uid)
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

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: isLoading == false
          ? Scaffold(
              appBar: PreferredSize(
                preferredSize: Size.fromHeight(50),
                child: GestureDetector(
                  // Wrap the AppBar widget with GestureDetector
                  onDoubleTap: () {
                    // Handle double tap event
                    setState(() {
                      // Change the color of the app bar
                      if (isTravel) {
                        AppColor = Colors.orange;
                        isTravel = false;
                      } else {
                        AppColor = Colors.green;
                        isTravel = true;
                      }
                    });
                  },
                  child: AppBar(
                    title: Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: Row(children: <Widget>[
                        GestureDetector(
                          child: CircleAvatar(
                            backgroundColor: Colors.white70,
                            radius: 20,
                            backgroundImage: NetworkImage(userData["photoUrl"]),
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ProfilePage(
                                        uid: uid,
                                      )),
                            );

                            setState(() {});
                          },
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          userData["username"],
                        ),
                      ]),
                    ),
                    backgroundColor: AppColor, // Use the color variable
                  ),
                ),
              ),
              body: Center(
                child: _widgetOptions.elementAt(_selectedIndex),
              ),
              bottomNavigationBar: BottomNavigationBar(
                  backgroundColor: AppColor,
                  items: const <BottomNavigationBarItem>[
                    BottomNavigationBarItem(
                      icon: Icon(Icons.home),
                      //  title: Text('Home'),
                      label: "FeedScreen",
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.favorite),
                      //  title: Text('Home'),
                      label: "WishList",
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.add),
                      label: "AddPostScreen",
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.list),
                      //title: Text('Profile'),
                      label: "UserPostList",
                    ),
                  ],
                  //type: BottomNavigationBarType.shifting,
                  currentIndex: _selectedIndex,
                  selectedItemColor: Colors.white,
                  unselectedItemColor: Colors.black,
                  iconSize: 40,
                  onTap: _onItemTapped,
                  type: BottomNavigationBarType.fixed,
                  elevation: 5),
            )
          : const Center(
              child: CircularProgressIndicator(
                color: Colors.white,
              ),
            ),
    );
  }
}
