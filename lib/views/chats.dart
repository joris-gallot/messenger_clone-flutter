import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:lipsum/lipsum.dart' as lipsum;
import 'dart:math';
import 'package:messenger_clone_ui_mobile/views/chat.dart';
import '../models/user.dart';

class ChatsView extends StatefulWidget {
  ChatsView() : super();

  @override
  _ChatsViewState createState() => _ChatsViewState();
}

class _ChatsViewState extends State<ChatsView> {
  final random = Random();
  Future _loadingUsers;

  @override
  void initState() {
    _loadingUsers = getUsers(); // only create the future once.
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _loadingUsers,
      builder: (context, projectSnap) {
        var childCount = 0;

        if (projectSnap.connectionState == ConnectionState.done &&
            projectSnap.hasData) {
          childCount = projectSnap.data["results"].length;
        }

        return ListView.builder(
          padding: EdgeInsets.all(0.0),
          itemCount: childCount,
          itemBuilder: (context, index) {
            var user = new User(projectSnap.data["results"][index]);

            if (projectSnap.connectionState != ConnectionState.done) {
              return Container(
                  margin: EdgeInsets.only(top: 20),
                  child: Center(child: CircularProgressIndicator()));
            }

            if (projectSnap.hasData == null) {
              return Container();
            }

            return InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ChatView(user: user)),
                );
              },
              child: Container(
                  padding: EdgeInsets.fromLTRB(30, 10, 30, 10),
                  color: Colors.black12,
                  child: Row(
                    children: [
                      Stack(
                        children: [
                          CircleAvatar(
                            radius: 30,
                            backgroundImage:
                                NetworkImage(user.image),
                          ),
                          Positioned(
                            right: -2,
                            bottom: 0,
                            child: random.nextBool()
                                ? Container(
                                    width: 15,
                                    height: 15,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                          color: Theme.of(context).primaryColor,
                                          width: 2,
                                        ),
                                        color: Color.fromRGBO(0, 255, 10, 20)),
                                  )
                                : Container(),
                          )
                        ],
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              user.firstname +
                                  " " +
                                  user.lastname,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: index == 0
                                    ? Colors.white
                                    : Color.fromRGBO(222, 222, 222, 10),
                                fontSize: 17,
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              lipsum.createParagraph(),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  color: index == 0
                                      ? Colors.white
                                      : Color.fromRGBO(222, 222, 222, 10),
                                  fontWeight: index == 0
                                      ? FontWeight.bold
                                      : FontWeight.normal),
                            )
                          ],
                        ),
                      )
                    ],
                  )),
            );
          },
        );
      },
    );
  }

  Future<Map> getUsers() async {
    String apiUrl = 'https://randomuser.me/api?results=30';
    var response = await http.get(apiUrl);

    return json.decode(response.body);
  }
}
