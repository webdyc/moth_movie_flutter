import 'package:flutter/material.dart';
import 'package:moth_movie/api/index.dart';

class PlayerProvider with ChangeNotifier {
  // 当前播放的id
  var PlayerId = "123";
  var PlayerUrl;

  // 设置播放信息
  void PlayerDataAsync(id) async {
    PlayerUrl = await getMovieUrlAPI(id);
    PlayerId = id;
    notifyListeners();
  }
}
