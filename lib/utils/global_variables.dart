import 'package:flutter/material.dart';
import 'package:testproject/screens/add_post_screen.dart';
import 'package:testproject/screens/feed_screen.dart';

const webScreenSize = 800;
const homeScreenItems = [
  FeedScreen(),
  Text('search'),
  AddPostScreen(),
  Text('notif'),
  Text('profile'),
];
