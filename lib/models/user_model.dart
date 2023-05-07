class MyUser {
  final String email;
  final String uid;
  final String photoUrl;
  final String username;
  final List followers;
  final List following;

  MyUser({
    required this.email,
    required this.uid,
    required this.photoUrl,
    required this.username,
    required this.followers,
    required this.following,
  });

  factory MyUser.fromSnap({required Map<String, dynamic> snapshot}) {
    return MyUser(
      email: snapshot["email"],
      uid: snapshot["uid"],
      photoUrl: snapshot["photoUrl"],
      username: snapshot["username"],
      followers: snapshot["followers"],
      following: snapshot["following"],
    );
  }

  Map<String, dynamic> toJson() => {
        "username": username,
        "uid": uid,
        "email": email,
        "followers": [],
        "following": [],
        "photoUrl": photoUrl,
      };
}
