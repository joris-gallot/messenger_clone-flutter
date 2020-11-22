import 'package:flutter/material.dart';
import 'constants.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        brightness: Brightness.dark,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
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
                              child: Text('3', style: TextStyle(fontSize: NOTIFICATION_SIZE),)
                            ),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.red
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(width: 20,),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start, 
                      children: [
                        Text('Discussions',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: TITLE_SIZE,
                          )
                        ),
                        Text('Joris Gallot',
                          style: TextStyle(
                            fontSize: SUB_TITLE_SIZE,
                            color: Color.fromRGBO(172, 172, 172, 100)
                          ),
                        )
                      ],
                    )
                  ],
                )
              ],
            ),
          ),
        )
      ),
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
