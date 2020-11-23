import 'package:flutter/material.dart';
import 'views/chats.dart';

void main() {
  runApp(MessengerCloneApp());
}

class MessengerCloneApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Messenger clone app',
      theme: ThemeData(
        brightness: Brightness.dark,
        accentColor: Color.fromRGBO(0, 137, 255, 10),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: ChatsView(),
    );
  }
}