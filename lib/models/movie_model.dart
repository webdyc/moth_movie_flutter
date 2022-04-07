import 'package:flutter/cupertino.dart';

// 首页列表
class MovieListModel {
  // 此处定义数据表中的字段(或接口返回的)即可
  final String? title;
  final List? listData;

  MovieListModel({
    @required this.title,
    @required this.listData,
  });

  /// 将 Json 数据转换为实体模型
  factory MovieListModel.fromJson(dynamic item) {
    return MovieListModel(
      title: item["title"],
      listData: item["listData"],
    );
  }
}

class MovieHeader {
  /// 此处定义数据表中的字段(或接口返回的)即可
  final String? title;

  MovieHeader({
    @required this.title,
  });

  /// 将 Json 数据转换为实体模型
  factory MovieHeader.fromJson(dynamic item) {
    return MovieHeader(
      title: item['title'],
    );
  }
}

// 首页列表
class MovieItem {
  /// 此处定义数据表中的字段(或接口返回的)即可
  final String? id;
  final String? title;
  final String? actors;
  final String? update;
  final String? pic;
  final String? score;

  MovieItem({
    @required this.id,
    @required this.title,
    @required this.actors,
    @required this.update,
    @required this.pic,
    @required this.score,
  });

  /// 将 Json 数据转换为实体模型
  factory MovieItem.fromJson(dynamic item) {
    return MovieItem(
      id: item['id'],
      title: item['title'],
      actors: item['actors'],
      update: item['update'],
      pic: item['pic'],
      score: item['score'],
    );
  }
}
