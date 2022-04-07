import 'package:flutter/material.dart';
import 'package:moth_movie/components/custom_loading.dart';
import 'package:moth_movie/config/app_colors.dart';
import 'package:chewie/chewie.dart';
import 'package:video_player/video_player.dart';

import '../../api/index.dart';
import '../../components/custom_movie_list.dart';
import '../../components/custom_silver_grid.dart';

// 视频详情页
class movieDetailPage extends StatefulWidget {
  final String id;

  movieDetailPage({required this.id});
  @override
  State<movieDetailPage> createState() => _movieDetailPageState();
}

class _movieDetailPageState extends State<movieDetailPage> {
  // 播放器插件
  VideoPlayerController? _videoPlayerController;
  ChewieController? _chewieController;
  // 上拉控制器
  ScrollController _scrollController = ScrollController();
  var _titleOpacity = 0;
  // 视频信息
  var _loading = false;
  // 影视信息
  var _movieInfo;
  var _playerUrl;
  var _playerId;
  // 播放列表
  var _episodeList;

  // 热播列表
  var _hotRecommendList;

  @override
  void initState() {
    // 获取视频列表
    _getMovieDetail();
    // 滑动监听器
    _scrollController.addListener(() {
      // print(_scrollController.offset);
      // print(_scrollController.position.maxScrollExtent);

      if (_scrollController.offset >= 100) {
        setState(() {
          _titleOpacity = 1;
        });
      } else {
        setState(() {
          _titleOpacity = 0;
        });
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    // 销毁对下拉列表的监听事件
    _scrollController.dispose();
    // 销毁播放器的控制器
    _videoPlayerController!.dispose();
    _chewieController!.dispose();
  }

  // 获取视频详情
  Future _getMovieDetail() async {
    var result = await getMovieDetailAPI(widget.id);
    print("SSADASDASDASDASDASDSDA================");
    print(result["hotRecommendList"]);
    _getMovieUrl(result['episodeList'][0].list[0].url);
    if (!mounted) return;
    setState(() {
      _movieInfo = result['movieInfo'];
      _episodeList = result['episodeList'];
      _hotRecommendList = result['hotRecommendList'];
    });
  }

  // 获取视频url
  void _getMovieUrl(id) async {
    var playerUrl = await getMovieUrlAPI(id);
    _videoPlayerController = VideoPlayerController.network(playerUrl);
    _chewieController = ChewieController(
      //要播放的视频的控制器
      videoPlayerController: _videoPlayerController!,
      // 缩放比
      aspectRatio: 16 / 9,
      // 是否自动播放
      autoPlay: false,
      // // 封面
      // looping: widget.looping!,
      // // 进度条颜色
      // placeholder: _placeHolder,
      // // 进度条颜色
      // materialProgressColors: _progressColors,
      // // 是否静音
      // allowMuting: false,
      // // 是否显示播放速度
      // allowPlaybackSpeedChanging: false,
      // customControls: MaterialControls(
      //   showLoadingOnInitialize: false,
      //   showBigPlayIcon: false,
      //   bottomGradient: blackLinearGradient(),
      // ),
    );
    setState(() {
      _playerUrl = playerUrl;
      _playerId = id;
      _loading = true;
    });
    _videoPlayerController!
      ..initialize().then((_) {
        _chewieController!.play();
        setState(() {});
      });
  }

  // 自定义方法
  List<Widget> _getListData() {
    List<Widget> list = [];
    for (var i = 0; i < 15; i++) {
      list.add(Text("这是第${i}个"));
    }

    return list;
  }

  @override
  Widget build(BuildContext context) {
    if (!_loading) {
      return CustomLoading();
    } else {
      return Material(
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
          ),
          child: CustomScrollView(
            controller: _scrollController,
            scrollDirection: Axis.vertical,
            slivers: [
              SliverAppBar(
                leading: IconButton(
                  icon: Icon(Icons.chevron_left),
                  onPressed: () {
                    Navigator.pop(context);
                    // 销毁启动页并跳转
                    // Navigator.pushAndRemoveUntil(
                    //     context,
                    //     MaterialPageRoute(
                    //       builder: (context) => HomePage(),
                    //     ),
                    //     (route) => false);
                  },
                ),
                pinned: true,
                stretch: true,
                backgroundColor: AppColors.active,
                expandedHeight: 200,
                flexibleSpace: FlexibleSpaceBar(
                  title: Text(
                    _movieInfo.title,
                    style: TextStyle(
                      color: Colors.white.withOpacity(_titleOpacity.toDouble()),
                    ),
                  ),
                  background: _CustomVideo(),
                ),
              ),
              // 影视介绍
              _MovieMsg(),
              // 剧集信息
              SliverToBoxAdapter(
                // 清除默认边距
                child: MediaQuery.removeViewPadding(
                  removeTop: true,
                  removeBottom: true,
                  context: context,
                  child: ListView(
                    shrinkWrap: true, //为true可以解决子控件必须设置高度的问题
                    physics: NeverScrollableScrollPhysics(), //禁用滑动事件
                    children: getEpisodeListData(),
                  ),
                ),
              ),
              // 相关热播
              SliverToBoxAdapter(
                // 清除默认边距
                child: MediaQuery.removeViewPadding(
                  removeTop: true,
                  removeBottom: true,
                  context: context,
                  child: Padding(
                    padding: EdgeInsets.only(top: 20, left: 10, bottom: 10),
                    child: Text(
                      '当前热播',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                  ),
                ),
              ),
              SliverPadding(
                padding: EdgeInsets.all(0),
                sliver: CustomSliverGrid(
                  gridList: _hotRecommendList
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
          ),
        ),
      );
    }
  }

  // 视频组件
  _CustomVideo() {
    double screenWidth = MediaQuery.of(context).size.width; // 播放器宽度
    return Container(
      height: 200,
      child: Chewie(
        controller: _chewieController!,
      ),
    );
  }

  // 影视介绍
  _MovieMsg() {
    return SliverToBoxAdapter(
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  _movieInfo.title,
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                )
              ],
            ),
            Row(
              children: [
                Text(
                  _movieInfo.score,
                  style: TextStyle(fontSize: 14),
                ),
                Text(
                  " · ",
                  style: TextStyle(fontSize: 14),
                ),
                Text(_movieInfo.update, style: TextStyle(fontSize: 14)),
                Text(
                  " · ",
                  style: TextStyle(fontSize: 14),
                ),
                Text("简介", style: TextStyle(fontSize: 14)),
                Text(
                  "",
                  style: TextStyle(fontSize: 14),
                ),
                Icon(
                  Icons.chevron_right,
                  size: 18,
                  color: AppColors.active,
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  // 剧集信息遍历方法
  List<Widget> getEpisodeListData() {
    List<Widget> list = [];
    for (var i = 0; i < _episodeList.length; i++) {
      list.add(
          _MovieSource(_episodeList[i].title, _episodeList[i].list, _playerId));
    }

    return list;
  }

  // 剧集信息
  _MovieSource(_title, _list, _playerId) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    _title,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        "更新至${_list.length.toString()}集",
                        style: TextStyle(
                          fontSize: 14,
                        ),
                      ),
                      Icon(
                        Icons.chevron_right,
                        size: 18,
                        color: AppColors.active,
                      )
                    ],
                  )
                ],
              ),
              // Row(
              //   children: [

              //   ],
              // )
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.only(right: 10),
          height: 40.0,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: _list
                .map<Widget>(
                  (row) => GestureDetector(
                    onTap: (() => {_getMovieUrl(row.url)}),
                    child: Container(
                      alignment: Alignment.center,
                      width: 40.0,
                      margin: EdgeInsets.only(left: 10),
                      color:
                          _playerId == row.url ? Colors.blue : Colors.grey[200],
                      child: Text(
                        "${row.title}",
                        style: TextStyle(
                          color: _playerId == row.url
                              ? Colors.white
                              : Colors.black,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
        )
      ],
    );
  }
}
