import 'package:flutter/cupertino.dart';

// 详情信息
class MovieDetail {
  /// 此处定义数据表中的字段(或接口返回的)即可
  final String? id;
  final String? title;
  final List? actors;
  final String? update;
  final String? pic;
  final String? score;
  final List? director;
  final String? classify;
  final String? district;
  final String? year;
  final String? updateTime;
  final String? introduction;

  MovieDetail({
    @required this.id,
    @required this.title,
    @required this.actors,
    @required this.update,
    @required this.pic,
    @required this.score,
    @required this.director,
    @required this.classify,
    @required this.district,
    @required this.year,
    @required this.updateTime,
    @required this.introduction,
  });

  /// 将 Json 数据转换为实体模型
  factory MovieDetail.fromJson(dynamic item) {
    return MovieDetail(
      id: item['id'],
      title: item['title'],
      actors: item['actors'],
      update: item['update'],
      pic: item['pic'],
      score: item['score'],
      director: item['director'],
      classify: item['classify'],
      district: item['district'],
      year: item['year'],
      updateTime: item['updateTime'],
      introduction: item['introduction'],
    );
  }
}

// 剧集列表
class EpisodeListModel {
  final String? title;
  final List? list;
  EpisodeListModel({
    @required this.title,
    @required this.list,
  });
}

// 剧集详情
class EpisodeItemModel {
  final String? id;
  final String? url;
  final String? title;
  EpisodeItemModel({
    @required this.title,
    @required this.url,
    @required this.id,
  });
}
