import 'package:flutter/material.dart';
import 'package:guidedlayout2_1748/View/Profile/Profile.dart';

// import 'package:guidedlayout2_1748/View/Profile/profile.dart';
import 'package:guidedlayout2_1748/View/home.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context){
    return const MaterialApp(
      home: ProfilePage(),
    );
  }
}