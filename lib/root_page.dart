import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:moth_movie/config/app_colors.dart';

import 'views/root_page/home_page.dart';
import 'views/root_page/mine_page.dart';

// 底部导航栏目
class RootPage extends StatefulWidget {
  @override
  State<RootPage> createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  final List _tabbarList = [
    {"icon": Icons.home, "text": "首页"},
    {"icon": Icons.search, "text": "我的"},
  ];
  final List<Widget> _tabbarPages = [
    HomePage(),
    MinePage(),
  ];

  // 当前tabbar下标
  int _currentIndex = 0;
  // tabbar跳转
  void _onTabClick(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        activeColor: Theme.of(context).primaryColor,
        backgroundColor: AppColors.nav,
        currentIndex: _currentIndex,
        onTap: _onTabClick,
        items: _tabbarList
            .map((item) => BottomNavigationBarItem(
                icon: Icon(item['icon']), label: item['text']))
            .toList(),
      ),
      tabBuilder: (BuildContext context, int index) {
        return _tabbarPages[index];
      },
    );
  }
}
