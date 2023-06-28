import 'dart:math';
import 'package:flutter/material.dart';
import 'package:tiktok_clone/controller/auth_controller.dart';
import 'package:tiktok_clone/view/screens/add_video_screen.dart';
import 'package:tiktok_clone/view/screens/home_video_screen.dart';
import 'package:tiktok_clone/view/screens/profile_screen.dart';
import 'package:tiktok_clone/view/screens/search_screen.dart';

List pages = [
  HomeVideoScreen(),
  SearchScreen(),
  const AddVideoScreen(),
  const Text("Messages Screen coming soon!"),
  ProfileScreen(uid: authController.user.uid),
];

// getRandomColor() => Colors.primaries[Random().nextInt(Colors.primaries.length)];
getRandomColor() => [
      Colors.blueAccent,
      Colors.redAccent,
      Colors.greenAccent,
    ][Random().nextInt(3)];

//COLORS
const backgroundColor = Colors.black;
var buttonColor = Colors.red[400];
const borderColor = Colors.grey;

//controller
var authController = AuthController.instance;
