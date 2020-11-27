import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:math';

class ContactsView extends StatefulWidget {
  ContactsView() : super();

  @override
  _ContactsViewState createState() => _ContactsViewState();
}

class _ContactsViewState extends State<ContactsView> {
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

        if (projectSnap.connectionState == ConnectionState.done && projectSnap.hasData) {
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
                      child: Text(
                        user["name"]["first"] + " " + user["name"]["last"],
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: index == 0
                              ? Colors.white
                              : Color.fromRGBO(222, 222, 222, 10),
                          fontSize: 17,
                        ),
                      ),
                    )
                  ],
                ));
          }, childCount: childCount),
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
