import 'package:flutter/material.dart';
import 'package:moth_movie/api/index.dart';

class BannerProvider with ChangeNotifier {
  // banner轮播图
  var bannerList = [];

  // 设置轮播图
  void bannerListAsync(data) {
    bannerList = data;
    notifyListeners();
  }
}
