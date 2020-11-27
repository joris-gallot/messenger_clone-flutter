import 'package:flutter/material.dart';
import 'views/chats.dart';
import 'views/contacts.dart';
import './constants.dart';
import 'dart:math';

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
      home: HomeView(),
    );
  }
}

class HomeView extends StatefulWidget {
  HomeView() : super();

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> with SingleTickerProviderStateMixin {
  final random = Random();
  TabController _controller;
  // int _selectedIndex = 0;

  List<Widget> list = [
    Tab(
      icon: new Icon(Icons.chat_bubble),
    ),
    Tab(
      icon: new Icon(Icons.group),
    )
  ];

  @override
  void initState() {
    super.initState();

    _controller = TabController(length: list.length, vsync: this);
  }

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
              padding: EdgeInsets.fromLTRB(30, 10, 30, 2),
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
                                    backgroundImage: NetworkImage(
                                        "https://i.pravatar.cc/300"),
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
                                            color: Theme.of(context)
                                                .primaryColor,
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
                                        color: Color.fromRGBO(
                                            172, 172, 172, 10)),
                                  )
                                ],
                              )
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 21,
                      ),
                      TextField(
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 20),
                            suffixIcon: Icon(Icons.search),
                            enabledBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(99)),
                                borderSide: BorderSide.none),
                            focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(99)),
                              borderSide: BorderSide.none,
                            ),
                            filled: true,
                            hintText: 'Rechercher...'),
                      )
                    ],
                  ),
                ],
              ),
            ),
          )),
      SliverFillRemaining(
        child: TabBarView(
          controller: _controller,
          children: [
            ChatsView(),
            ContactsView()
          ]
        ),
      )
    ]),
    bottomNavigationBar: SizedBox(
      height: 60,
      child: TabBar(
        tabs: list,
        controller: _controller,
        unselectedLabelColor: Color.fromRGBO(172, 172, 172, 10),
        indicatorSize: TabBarIndicatorSize.label,
        indicatorPadding: EdgeInsets.symmetric(horizontal: 0, vertical: 5),
        indicatorColor: Colors.white,
      ),
    ),
      floatingActionButton:
        FloatingActionButton(child: Icon(Icons.add), onPressed: () {}),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
