import 'package:flutter/material.dart';
import 'package:socket_application/chatScreen/chatScreen.dart';

void main(){
  runApp(const ChatApp());
}

class ChatApp extends StatelessWidget {
  const ChatApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: chatScreen()
    );
  }
}