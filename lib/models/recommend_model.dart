import 'package:flutter/cupertino.dart';

// 首页列表
class RecommendListModel {
  // 此处定义数据表中的字段(或接口返回的)即可
  final String? title;
  final List? listData;

  RecommendListModel({
    @required this.title,
    @required this.listData,
  });

  /// 将 Json 数据转换为实体模型
  factory RecommendListModel.fromJson(dynamic item) {
    return RecommendListModel(
      title: item["title"],
      listData: item["listData"],
    );
  }
}

// 轮播图
class BannerItem {
  /// 此处定义数据表中的字段(或接口返回的)即可
  final String? id;
  final String? pic;
  final String? title;
  final String? subtitle;

  BannerItem({
    @required this.id,
    @required this.pic,
    @required this.title,
    @required this.subtitle,
  });

  /// 将 Json 数据转换为实体模型
  factory BannerItem.fromJson(dynamic item) {
    return BannerItem(
      id: item['id'],
      pic: item['pic'],
      title: item['title'],
      subtitle: item['subtitle'],
    );
  }
}

class RecommendHeader {
  /// 此处定义数据表中的字段(或接口返回的)即可
  final String? title;

  RecommendHeader({
    @required this.title,
  });

  /// 将 Json 数据转换为实体模型
  factory RecommendHeader.fromJson(dynamic item) {
    return RecommendHeader(
      title: item['title'],
    );
  }
}

// 首页列表
class RecommendItem {
  /// 此处定义数据表中的字段(或接口返回的)即可
  final String? id;
  final String? title;
  final String? actors;
  final String? update;
  final String? pic;
  final String? score;

  RecommendItem({
    @required this.id,
    @required this.title,
    @required this.actors,
    @required this.update,
    @required this.pic,
    @required this.score,
  });

  /// 将 Json 数据转换为实体模型
  factory RecommendItem.fromJson(dynamic item) {
    return RecommendItem(
      id: item['id'],
      title: item['title'],
      actors: item['actors'],
      update: item['update'],
      pic: item['pic'],
      score: item['score'],
    );
  }
}
