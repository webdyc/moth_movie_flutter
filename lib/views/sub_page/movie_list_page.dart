// 视频列表页面
import 'package:flutter/material.dart';
import 'package:moth_movie/api/index.dart';
import 'package:moth_movie/components/custom_movie_list.dart';
import 'package:moth_movie/components/custom_silver_grid.dart';

class MovieListPage extends StatefulWidget {
  final String? id;

  MovieListPage(this.id);

  @override
  State<MovieListPage> createState() => _MovieListPageState();
}

// AutomaticKeepAliveClientMixin 页面缓存
class _MovieListPageState extends State<MovieListPage>
    with AutomaticKeepAliveClientMixin {
  var _movieList = [];
  void initState() {
    super.initState();
    // 获取视频列表
    getMovieList();
  }

  // 获取视频列表
  Future getMovieList() async {
    var result = await movieListApi(widget.id, "");
    setState(() {
      _movieList = result[0].listData;
    });
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      physics: BouncingScrollPhysics(),
      slivers: [
        SliverPadding(
          padding: EdgeInsets.all(10),
          sliver: CustomSliverGrid(
            gridList: _movieList
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
        ),
      ],
    );
  }

  @override
  // 覆写`wantKeepAlive`返回`true`
  bool get wantKeepAlive => true;
}
