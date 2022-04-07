// 启动页
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:moth_movie/root_page.dart';

class TransitPage extends StatefulWidget {
  @override
  State<TransitPage> createState() => _TransitPageState();
}

class _TransitPageState extends State<TransitPage> {
  // 倒计时定时器
  Timer? _timer;
  // 倒计时时间
  int _currentTime = 6;

  @override
  void initState() {
    super.initState();

    // 倒计时
    _timer = Timer.periodic(Duration(milliseconds: 1000), (timer) {
      setState(() {
        _currentTime--;
      });
      if (_currentTime <= 0) {
        _goHomePage();
      }
    });
  }

  // 路由跳转
  void _goHomePage() {
    // 销毁定时器
    _timer!.cancel();
    // 销毁启动页并跳转
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => RootPage(),
        ),
        (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Logo 和 文字
          Padding(
            padding: EdgeInsets.only(
                top: MediaQuery.of(context).padding.top + 50, bottom: 100),
            child: _contentText(),
          ),
          // 跳过按钮
          Positioned(
            top: MediaQuery.of(context).padding.top + 10,
            right: 20,
            child:
                InkWell(onTap: _goHomePage, child: _clipButton(_currentTime)),
          )
        ],
      ),
    );
  }
}

// Logo 和 文字
Widget _contentText() {
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset(
          'assets/images/logo.png',
          width: 100,
          height: 100,
        ),
        Text(
          "飞蛾影视",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ],
    ),
  );
}

// 跳转按钮
Widget _clipButton(_currentTime) {
  return ClipRRect(
    borderRadius: BorderRadius.circular(50),
    child: Container(
      width: 50,
      height: 50,
      color: Colors.black87.withOpacity(0.3),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "跳过",
            style: TextStyle(
              fontSize: 12,
              color: Colors.white,
            ),
          ),
          Text(
            "${_currentTime}s",
            style: TextStyle(
              fontSize: 12,
              color: Colors.white,
            ),
          ),
        ],
      ),
    ),
  );
}
