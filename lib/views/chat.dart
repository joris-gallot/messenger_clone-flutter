import 'package:flutter/material.dart';
import 'package:messenger_clone_ui_mobile/models/user.dart';
import 'package:lipsum/lipsum.dart' as lipsum;
import '../constants.dart';
import 'dart:math';

class ChatView extends StatefulWidget {
  ChatView({Key key, this.user}) : super(key: key);
  final User user;

  @override
  _ChatViewState createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> {
  final random = Random();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;
    final messageInputController = TextEditingController();

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
                                ))
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
                                )),
                            Text(
                              'En ligne',
                              style: TextStyle(
                                  fontSize: SUB_TITLE_TEXT_SIZE,
                                  color: Color.fromRGBO(172, 172, 172, 10)),
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
                            print('phone');
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
                            print('camera');
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
        )),
      ),
      body: ListView.builder(
          padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
          itemCount: 30,
          itemBuilder: (BuildContext context, int index) {
            var isMyMessage = random.nextBool();

            return Align(
              alignment:
                  isMyMessage ? Alignment.centerRight : Alignment.centerLeft,
              child: Container(
                constraints: BoxConstraints(maxWidth: deviceWidth - 80),
                margin: EdgeInsets.only(bottom: 5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  color: isMyMessage
                      ? Color.fromRGBO(0, 137, 255, 10)
                      : Color.fromRGBO(62, 62, 62, 10),
                ),
                child: Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Text(
                    lipsum.createWord(numWords: random.nextInt(20) + 1),
                    maxLines: 4,
                  ),
                ),
              ),
            );
          }),
      bottomNavigationBar: Transform.translate(
        offset: Offset(0.0, -1 * MediaQuery.of(context).viewInsets.bottom),
        child: BottomAppBar(
          child: TextField(
            controller: messageInputController,
            decoration: InputDecoration(
                contentPadding:
                    EdgeInsets.symmetric(vertical: 10.0, horizontal: 20),
                suffixIcon: IconButton(
                  onPressed: () {
                    FocusScope.of(context).unfocus();
                    messageInputController.clear();
                  },
                  icon: Icon(Icons.send),
                ),
                filled: true,
                hintText: 'Écrire un message...'),
          ),
        ),
      ),
    );
  }
}
