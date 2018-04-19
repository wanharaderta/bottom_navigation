import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import './tabs/dashboard.dart' as _dashboard;
import './tabs/home.dart' as _home;

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Jadwal Sholat',
      theme: new ThemeData(
          primarySwatch: Colors.green,
          scaffoldBackgroundColor: Colors.white,
          primaryColor: Colors.green,
          backgroundColor: Colors.white),
      //  home: new Tabs(title: 'Flutter Demo Home Page'),
      home: new Tabs(),
    );
  }
}

class Tabs extends StatefulWidget {
  // Tabs({Key key, this.title}) : super(key: key);

//  final String title;

  @override
  _TabsState createState() => new _TabsState();
}

class _TabsState extends State<Tabs> {
  PageController _pageController;

  var _title_app = null;
  int _tab = 0;

  @override
  void initState() {
    super.initState();
    _pageController = new PageController();
    this._title_app = list[0].title;
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  @override
  Widget build(BuildContext context) => new Scaffold(
      appBar: new AppBar(
        title: new Text(
          _title_app,
          style: new TextStyle(
            fontSize:
                Theme.of(context).platform == TargetPlatform.iOS ? 17.0 : 20.0,
          ),
        ),
        elevation: Theme.of(context).platform == TargetPlatform.iOS ? 0.0 : 4.0,
      ),
      body: new PageView(
        controller: _pageController,
        onPageChanged: onTabChanged,
        children: <Widget>[new _home.Home(), new _dashboard.Dashboard()],
      ),
      bottomNavigationBar: Theme.of(context).platform == TargetPlatform.iOS
          ? new CupertinoTabBar(
              activeColor: Colors.lightBlueAccent,
              currentIndex: _tab,
              onTap: onTap,
              items: list.map((TabItem) {
                return new BottomNavigationBarItem(
                  title: new Text(TabItem.title),
                  icon: new Icon(TabItem.icon),
                );
              }).toList(),
            )
          : new BottomNavigationBar(
              currentIndex: _tab,
              onTap: onTap,
              items: list.map((TabItem) {
                return new BottomNavigationBarItem(
                  title: new Text(TabItem.title),
                  icon: new Icon(TabItem.icon),
                );
              }).toList(),
            ));

  void onTap(int page) {
    _pageController.jumpToPage(page);
  }

  void onTabChanged(int tab) {
    setState(() {
      this._tab = tab;
    });

    switch (tab) {
      case 0:
        this._title_app = list[0].title;
        break;
      case 1:
        this._title_app = list[1].title;
        break;
    }
  }
}

class TabItem {
  const TabItem({this.title, this.icon});

  final String title;
  final IconData icon;
}

const List<TabItem> list = const <TabItem>[
  const TabItem(title: 'Hari ini', icon: Icons.home),
  const TabItem(title: 'Bulan ini', icon: Icons.dashboard)
];
