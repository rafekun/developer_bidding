import 'package:flutter/material.dart';
import 'package:easy_fund/screens/chat_screen.dart';
import 'login_screen.dart';
import 'package:easy_fund/screens/chat_list_screen.dart';
import 'package:easy_fund/screens/scholarships_screen.dart';
import 'questions_screen.dart';
import 'package:easy_fund/components/colors.dart';

class HomeScreen extends StatefulWidget {
  static String id = 'home_screen';
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _pageOptions = [
    ScholarshipsScreen(),
    ChatListScreen(),
    QuestionsScreen(),
  ];

  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    Text(
      'Index 0: 奨学金リスト',
      style: optionStyle,
    ),
    Text(
      'Index 1: インターン紹介',
      style: optionStyle,
    ),
    Text(
      'Index 2: 設定',
      style: optionStyle,
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: easyFundLightColor,
      appBar: AppBar(
        leading: null,
        title: Text('奨学金リスト'),
        backgroundColor: easyFundMainColor,
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.school),
            title: Text('奨学金リスト'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.business),
            title: Text('インターン紹介'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            title: Text('設定'),
          )
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
      body: _pageOptions[_selectedIndex],
    );
  }
}
