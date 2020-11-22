import 'package:flutter/material.dart';
import '../constants.dart';

class ChatsView extends StatefulWidget {
  ChatsView() : super();

  @override
  _ChatsViewState createState() => _ChatsViewState();
}

class _ChatsViewState extends State<ChatsView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: CustomScrollView(slivers: <Widget>[
      SliverAppBar(
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(35.0),
            child: Text(''),
          ),
          floating: true,
          // expandedHeight: 250.0,s
          flexibleSpace: SafeArea(
            child: Padding(
              padding: EdgeInsets.fromLTRB(30, 10, 30, 10),
              child: Column(
                children: [
                  Stack(
                    children: [
                      Positioned(
                        right: 0,
                        top: 0,
                        child: InkWell(
                          customBorder: CircleBorder(),
                          onTap: () {
                            setState(() {
                              print('open settings');
                            });
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
                        )
                      ),
                      Row(
                        children: [
                          Stack(
                            children: [
                              CircleAvatar(
                                radius: 30,
                                backgroundColor: Colors.black87,
                                child: Text('JG'),
                              ),
                              Positioned(
                                right: 0,
                                top: 0,
                                child: Container(
                                  width: 17,
                                  height: 17,
                                  child: Center(
                                      child: Text(
                                    '3',
                                    style:
                                        TextStyle(fontSize: NOTIFICATION_SIZE),
                                  )),
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
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
                                    fontSize: TITLE_SIZE,
                                  )),
                              Text(
                                'Joris Gallot',
                                style: TextStyle(
                                    fontSize: SUB_TITLE_SIZE,
                                    color: Color.fromRGBO(172, 172, 172, 100)),
                              )
                            ],
                          )
                        ],
                      ),
                    ],
                  )
                ],
              ),
            ),
          )),
      SliverGrid(
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 200.0,
          mainAxisSpacing: 10.0,
          crossAxisSpacing: 10.0,
          childAspectRatio: 4.0,
        ),
        delegate: SliverChildBuilderDelegate(
          (BuildContext context, int index) {
            return Container(
              alignment: Alignment.center,
              color: Colors.teal[100 * (index % 9)],
              child: Text('Grid Item $index'),
            );
          },
          childCount: 20,
        ),
      ),
      SliverFixedExtentList(
        itemExtent: 50.0,
        delegate: SliverChildBuilderDelegate(
          (BuildContext context, int index) {
            return Container(
              alignment: Alignment.center,
              color: Colors.lightBlue[100 * (index % 9)],
              child: Text('List Item $index'),
            );
          },
        ),
      ),
    ]));
  }
}
