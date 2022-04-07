import 'package:flutter/material.dart';
import 'package:moth_movie/api/index.dart';
import 'package:moth_movie/components/banner_swiper.dart';
import 'package:moth_movie/components/custom_movie_list.dart';
import 'package:moth_movie/provider/banner_provider.dart';
import 'package:provider/provider.dart';

// 首页
class RecommendPage extends StatefulWidget {
  final id;
  RecommendPage(this.id);

  @override
  State<RecommendPage> createState() => _RecommendPageState();
}

class _RecommendPageState extends State<RecommendPage>
    with AutomaticKeepAliveClientMixin {
  var _recommendList = [];
  @override
  void initState() {
    super.initState();
    getList();
  }

  void getList() async {
    var result = await recommendListApi(widget.id);
    // 存放轮播图
    context.read<BannerProvider>().bannerListAsync(result['bannerlist']);
    setState(() {
      _recommendList = result['recommendList'];
    });
  }

  List<Widget> _budildList() {
    return _recommendList.map((row) => _item(row)).toList();
  }

  Widget _item(row) {
    return Container(
      height: 1000,
      margin: EdgeInsets.only(bottom: 5),
      child: Column(
        children: [
          Text(
            row.title,
            style: TextStyle(),
            textAlign: TextAlign.left,
          ),
          Expanded(
            child: GridView.count(
              //禁用滑动事件
              physics: NeverScrollableScrollPhysics(),
              //水平子Widget之间间距
              crossAxisSpacing: 10,
              //垂直子Widget之间间距
              mainAxisSpacing: 10,
              //GridView内边距
              padding: EdgeInsets.all(10.0),
              //一行的Widget数量
              crossAxisCount: 3,
              //子Widget宽高比例
              childAspectRatio: 0.58,
              //子Widget列表
              children: row.listData
                  .map<Widget>((row) => CustomMovieList(
                        id: row.id,
                        title: row.title,
                        actors: row.actors,
                        update: row.update,
                        pic: row.pic,
                        score: row.score,
                      ))
                  .toList(),
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        BannerSwiper(),
        ListView(
          shrinkWrap: true, //为true可以解决子控件必须设置高度的问题
          physics: NeverScrollableScrollPhysics(), //禁用滑动事件
          children: _budildList(),
        ),
      ],
    );
  }

  @override
  // 覆写`wantKeepAlive`返回`true`
  bool get wantKeepAlive => true;
}
