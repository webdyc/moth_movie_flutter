import 'package:flutter/cupertino.dart';

// 分类模型模型
class TabListModel {
  /// 包含 TabItem 模型的集合
  List<TabItem> list;

  TabListModel(this.list);

  // 循环后台返回的数组 将每一项组装成 TabItem
  factory TabListModel.fromJson(List<dynamic> list) {
    return TabListModel(
      list.map((item) => TabItem.fromJson(item)).toList(),
    );
  }
}

// 分类列表项
class TabItem {
  /// 此处定义数据表中的字段(或接口返回的)即可
  final String? id;
  final String? title;

  TabItem({
    @required this.id,
    @required this.title,
  });

  /// 将 Json 数据转换为实体模型
  factory TabItem.fromJson(dynamic item) {
    return TabItem(
      id: item['id'],
      title: item['title'],
    );
  }
}
