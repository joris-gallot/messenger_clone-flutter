import 'package:flutter/material.dart';
import '../constants.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:lipsum/lipsum.dart' as lipsum;
import 'dart:math';

class ChatsView extends StatefulWidget {
  ChatsView() : super();

  @override
  _ChatsViewState createState() => _ChatsViewState();
}

class _ChatsViewState extends State<ChatsView> {
  final random = Random();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: CustomScrollView(slivers: <Widget>[
      SliverAppBar(
          expandedHeight: 155.0,
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(35.0),
            child: Text(''),
          ),
          floating: false,
          pinned: true,
          snap: false,
          flexibleSpace: SafeArea(
            child: Padding(
              padding: EdgeInsets.fromLTRB(30, 10, 30, 10),
              child: ListView(
                children: [
                  Column(
                    children: [
                      Stack(
                        children: [
                          Positioned(
                              right: 0,
                              top: 0,
                              child: InkWell(
                                customBorder: CircleBorder(),
                                onTap: () {
                                  print('open settings');
                                },
                                child: Padding(
                                  padding: EdgeInsets.all(5),
                                  child: Center(
                                    child: Icon(
                                      Icons.settings,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              )),
                          Row(
                            children: [
                              Stack(
                                children: [
                                  CircleAvatar(
                                    radius: 30,
                                    backgroundImage:
                                        NetworkImage("https://i.pravatar.cc/300"),
                                  ),
                                  Positioned(
                                    right: -2,
                                    top: 0,
                                    child: Container(
                                      width: 20,
                                      height: 20,
                                      child: Center(
                                          child: Text(
                                        '3',
                                        style: TextStyle(
                                            fontSize: NOTIFICATION_TEXT_SIZE),
                                      )),
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                            color: Theme.of(context).primaryColor,
                                            width: 2,
                                          ),
                                          color: Colors.red),
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Discussions',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: TITLE_TEXT_SIZE,
                                      )),
                                  Text(
                                    'Martin Durant',
                                    style: TextStyle(
                                        fontSize: SUB_TITLE_TEXT_SIZE,
                                        color: Color.fromRGBO(172, 172, 172, 10)),
                                  )
                                ],
                              )
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 20,),
                      TextField(
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20),
                          suffixIcon: Icon(Icons.search),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(99)),
                            borderSide: BorderSide.none
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(99)),
                            borderSide: BorderSide.none,
                          ),
                          filled: true,
                          hintText: 'Rechercher...'
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          )),
      FutureBuilder(
        future: getUsers(null),
        builder: (context, projectSnap) {
          var childCount = 0;

          if (projectSnap.connectionState != ConnectionState.done ||
              projectSnap.hasData == null) {
            childCount = 1;
          } else {
            childCount = projectSnap.data["results"].length;
          }

          return SliverList(
            delegate: SliverChildBuilderDelegate((context, index) {
              var user = projectSnap.data["results"][index];

              if (projectSnap.connectionState != ConnectionState.done) {
                return Container(
                    margin: EdgeInsets.only(top: 20),
                    child: Center(child: CircularProgressIndicator()));
              }

              if (projectSnap.hasData == null) {
                return Container();
              }

              return Container(
                  padding: EdgeInsets.fromLTRB(30, 10, 30, 10),
                  color: Colors.black12,
                  child: Row(
                    children: [
                      Stack(
                        children: [
                          CircleAvatar(
                            radius: 30,
                            backgroundImage:
                                NetworkImage(user["picture"]["medium"]),
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
                              user["name"]["first"] +
                                  " " +
                                  user["name"]["last"],
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
                  ));
            }, childCount: childCount),
          );
        },
      ),
    ]));
  }

  Future<Map> getUsers(search) async {
    print(search);
    String apiUrl = 'https://randomuser.me/api?results=30';
    var response = await http.get(apiUrl);

    return json.decode(response.body);
  }
}
