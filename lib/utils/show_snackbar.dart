import 'package:flutter/material.dart';
//import 'package:instagram_flutter/utils/colors.dart';

showSnackbar({
  required BuildContext context,
  required String content,
}) {
  return ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      shape: const RoundedRectangleBorder(),
      backgroundColor: Colors.blue,
      content: Text(
        content,
        style: const TextStyle(
          color: Colors.white,
        ),
      ),
      duration: const Duration(seconds: 2),
    ),
  );
}
