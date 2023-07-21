import 'package:event_management_system/user_dashboard/views/explore_tab.dart';
import 'package:event_management_system/user_dashboard/views/my_events_tab.dart';
import 'package:event_management_system/user_dashboard/views/settings_tab.dart';
import 'package:flutter/material.dart';

const Color lightGrey = Color.fromRGBO(239, 239, 239, 1);
const Color yellow = Color(0xfffed813);
const Color activeCyan = Color(0xff0a7e97);
const Color counterCyan = Color(0xff154c79);
const Color backgroundColor = Color(0xffebecee);
const Color white = Colors.white;
Color snackbarColor = Colors.red.shade400;

List<Color> backgroundGradient = const [
  //Color(0xffa0e9ce),
  //Color(0xffa2e0eb),

  Color(0xff80d9e9),
  counterCyan,

  //Color.fromARGB(255, 198, 230, 236),

  //activeCyan,
];

List<Color> lightBackgroundGradient = const [
  //Color.fromARGB(255, 196, 239, 247),
  Color.fromARGB(255, 204, 220, 223),
  // Color.fromARGB(255, 230, 245, 248),
  white,
];

const List<Widget> tabs = [
  MyEventsTab(),
  ExploreTab(),
  SettingsTab(),
];

const List<String> featuredEventImages = [
  "assets/concert_image/concert_one.png",
  "assets/concert_image/concert_two.png",
  "assets/concert_image/concert_three.png",
  "assets/concert_image/music_one.jpg",
  "assets/concert_image/music_two.png",
];
