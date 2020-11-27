import 'package:flutter/material.dart';
import 'package:messenger_clone_ui_mobile/models/user.dart';
import 'dart:math';
import '../constants.dart';

class ChatView extends StatefulWidget {
  ChatView({Key key, this.user}) : super(key: key);
  final User user;

  @override
  _ChatViewState createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(80.0),
        child: AppBar(
          flexibleSpace: SafeArea(
            child: Padding(
              padding: EdgeInsets.fromLTRB(55, 0, 20, 0),
              child: ListView(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Stack(
                            children: [
                              CircleAvatar(
                                radius: 32,
                                backgroundImage: NetworkImage(widget.user.image),
                              ),
                              Positioned(
                                right: -2,
                                bottom: 0,
                                child: Container(
                                  width: 19,
                                  height: 19,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: Theme.of(context).primaryColor,
                                        width: 3,
                                      ),
                                      color: Color.fromRGBO(0, 255, 10, 20)),
                                )
                              )
                            ],
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(widget.user.firstname,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: TITLE_TEXT_SIZE,
                                )
                              ),
                              Text(
                                'En ligne',
                                style: TextStyle(
                                    fontSize: SUB_TITLE_TEXT_SIZE,
                                    color: Color.fromRGBO(
                                        172, 172, 172, 10)),
                              )
                            ],
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          InkWell(
                            customBorder: CircleBorder(),
                            onTap: () {
                              print('open settings');
                            },
                            child: Padding(
                              padding: EdgeInsets.all(5),
                              child: Center(
                                child: Icon(
                                  Icons.phone,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          InkWell(
                            customBorder: CircleBorder(),
                            onTap: () {
                              print('open settings');
                            },
                            child: Padding(
                              padding: EdgeInsets.all(5),
                              child: Center(
                                child: Icon(
                                  Icons.videocam,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ],
              ),
            ),
          )
        ),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // Navigate back to first route when tapped.
          },
          child: Text('Go back!'),
        ),
      ),
    );
  }
}
