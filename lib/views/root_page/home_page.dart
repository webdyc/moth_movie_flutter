// 首页
import 'package:flutter/material.dart';
import 'package:moth_movie/api/index.dart';
import 'package:moth_movie/components/root_page_header.dart';
import 'package:moth_movie/views/sub_page/movie_list_page.dart';
import 'package:moth_movie/views/sub_page/recommend_page.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  List _tabsList = [];
  // tab控制器
  TabController? _tabController;

  @override
  void initState() {
    super.initState();
    // 获取tab频道
    getClassType();
    _tabController = new TabController(
        initialIndex: 0, length: _tabsList.length, vsync: this); // 直接传this
  }

  @override
  void dispose() {
    // 销毁对tab控制器
    _tabController!.dispose();
    super.dispose();
  }

  // 获取tab频道
  Future getClassType() async {
    var result = await tabList();
    setState(() {
      _tabsList = result;
      _tabController = new TabController(
          initialIndex: 0, length: _tabsList.length, vsync: this);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: RooPageHeader(),
        bottom: PreferredSize(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: TabBar(
                  isScrollable: true,
                  tabs: _tabsList
                      .map((item) => Tab(
                            text: item.title,
                          ))
                      .toList(),
                  controller: _tabController,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: 10,
                  right: 10,
                ),
                child: Icon(
                  Icons.category,
                  color: Colors.black,
                ),
              )
            ],
          ),
          preferredSize: Size.fromHeight(40),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: _tabsList
            .asMap()
            .entries
            .map((entries) => entries.key == 0
                ? RecommendPage(entries.value.id)
                : MovieListPage(entries.value.id))
            .toList(),
      ),
    );
  }
}
