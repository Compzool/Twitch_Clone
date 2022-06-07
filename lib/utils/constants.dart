import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:twitch_clone/screens/feed_screen.dart';
import 'package:twitch_clone/screens/go_live.dart';

//CONTROLLERS
final firebaseAuth = FirebaseAuth.instance;
final firebaseStorage = FirebaseStorage.instance;
final firestore = FirebaseFirestore.instance;

//Screens

List<Widget> pages = [
  FeedScreen(),
  GoLiveScreen(),
  const Center(child: Text('Browse')),
  //ProfileScreen(),
];
