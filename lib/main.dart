import 'package:flutter/material.dart';
import 'package:moth_movie/transit_page.dart';
import 'config/app_thumb.dart';
import 'package:provider/provider.dart';
import 'provider/index_provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      // 注册Provider
      providers: Providers,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: '飞蛾影视',
        theme: theme,
        home: TransitPage(),
      ),
    );
  }
}
