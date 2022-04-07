import 'package:flutter/material.dart';
import 'package:moth_movie/http/http.dart';
import 'package:html/parser.dart' show parse;
import 'package:moth_movie/models/Tab_model.dart';
import 'package:moth_movie/models/movie_detail_model.dart';
import 'package:moth_movie/models/movie_model.dart';
import 'package:moth_movie/models/recommend_model.dart';

// 获取频道分类
tabList() async {
  var htmltext = await Http.get('/index.php', params: {"type": 2});
  var foldertree = parse(htmltext.toString());
  var row = foldertree.getElementsByClassName("fed-show-md-block");
  // element.innerHtml element.attributes["href"]
  var tabList = row
      .map(
        (element) =>
            TabItem(id: element.attributes["href"], title: element.innerHtml),
      )
      .toList();
  return tabList;
}

// 获取首页信息
recommendListApi(id) async {
  var htmltext = await Http.get('${id}');
  var foldertree = parse(htmltext.toString());
  // 轮播图节点
  var bannerDom = foldertree.getElementsByClassName("fed-swip-lazy");
  // 获取的轮播图信息列表
  var bannerlist = bannerDom.map(
    (element) {
      // 判断图片是否有前缀
      var isHttp =
          element.attributes["data-background"].toString().contains('http');
      return BannerItem(
        id: element.attributes["href"],
        pic: isHttp
            ? element.attributes["data-background"]
            : "https://www.nangua55.net" +
                "${element.attributes["data-background"]}",
        title: element.getElementsByTagName("span")[0].innerHtml,
        subtitle: element.getElementsByTagName("span")[1].text,
      );
    },
  ).toList();

  // 列表节点
  var listDom = foldertree.getElementsByClassName("fed-part-layout");
  var recommendList = listDom.map((element) {
    if (element.getElementsByClassName("fed-font-xvi").length > 0 &&
        element.getElementsByClassName("fed-font-xvi")[0].innerHtml != "友情链接") {
      // 头部信息
      var listItem = element.getElementsByClassName("fed-list-item").map(
        (item) {
          // 判断图片是否有前缀
          var isHttp = item
              .getElementsByClassName("fed-list-pics")[0]
              .attributes["data-original"]
              .toString()
              .contains('http');
          return MovieItem(
              id: item
                  .getElementsByClassName("fed-list-pics")[0]
                  .attributes["href"],
              title: item.getElementsByClassName("fed-list-title")[0].innerHtml,
              actors: item.getElementsByClassName("fed-list-desc")[0].innerHtml,
              update:
                  item.getElementsByClassName("fed-list-remarks")[0].innerHtml,
              pic: isHttp
                  ? item
                      .getElementsByClassName("fed-list-pics")[0]
                      .attributes["data-original"]
                  : "https://www.nangua55.net" +
                      "${item.getElementsByClassName("fed-list-pics")[0].attributes["data-original"]}",
              score:
                  item.getElementsByClassName("fed-list-score")[0].innerHtml);
        },
      ).toList();
      return RecommendListModel(
        title: element.getElementsByClassName("fed-font-xvi")[0].innerHtml,
        listData: listItem,
      );
    }
  }).toList();
  recommendList.removeWhere((e) => e == null);
  return {"bannerlist": bannerlist, "recommendList": recommendList};
}

// 获取视频页面
movieListApi(id, params) async {
  var htmltext = await Http.get('${id}');
  var foldertree = parse(htmltext.toString());
  // 列表节点
  var listDom = foldertree.getElementsByClassName("fed-main-info");
  var moveList = listDom.map((element) {
    // 头部信息
    var listItem = element
        .getElementsByClassName("fed-list-item")
        .map(
          (item) => MovieItem(
              id: item
                  .getElementsByClassName("fed-list-pics")[0]
                  .attributes["href"],
              title: item.getElementsByClassName("fed-list-title")[0].innerHtml,
              actors: item.getElementsByClassName("fed-list-desc")[0].innerHtml,
              update:
                  item.getElementsByClassName("fed-list-remarks")[0].innerHtml,
              pic: "https://www.nangua55.net" +
                  "${item.getElementsByClassName("fed-list-pics")[0].attributes["data-original"]}",
              score:
                  item.getElementsByClassName("fed-list-score")[0].innerHtml),
        )
        .toList();
    return MovieListModel(
      title: element.getElementsByClassName("fed-font-xvi")[0].innerHtml,
      listData: listItem,
    );
  }).toList();
  moveList.removeWhere((e) => e == null);
  return moveList;
}

// 获取电影详情
getMovieDetailAPI(id) async {
  var htmltext = await Http.get('${id}');
  var foldertree = parse(htmltext.toString());
  // 电影详情节点
  var movieInfoDom = foldertree
      .getElementsByClassName("fed-main-info")[0]
      .getElementsByClassName("fed-deta-info")[0];
  // 剧集节点
  var episodeDom = foldertree.getElementsByClassName("fed-tabs-info");
  // 电影详情
  var fedListPics = movieInfoDom.getElementsByClassName("fed-list-pics")[0];
  var fedPartRows = movieInfoDom
      .getElementsByClassName("fed-deta-content")[0]
      .getElementsByTagName("li");
  // 相关热播
  var hotRecommendDom = foldertree.getElementsByClassName("fed-list-item");
  // 判断图片是否有前缀
  var isHttp =
      fedListPics.attributes["data-original"].toString().contains('http');
  // 电影详情
  var movieInfo = MovieDetail(
    id: fedListPics.attributes["href"],
    pic: isHttp
        ? fedListPics.attributes["data-original"]
        : "https://www.nangua55.net" +
            "${fedListPics.attributes["data-original"]}",
    title: movieInfoDom
        .getElementsByTagName("h1")[0]
        .getElementsByTagName("a")[0]
        .innerHtml,
    update: fedListPics.getElementsByClassName("fed-list-remarks")[0].innerHtml,
    score: fedListPics.getElementsByClassName("fed-list-score")[0].innerHtml,
    actors: fedPartRows[0]
        .getElementsByTagName("a")
        .map((item) => item.innerHtml)
        .toList(),
    director: fedPartRows[1]
        .getElementsByTagName("a")
        .map((item) => item.innerHtml)
        .toList(),
    classify: fedPartRows[2].getElementsByTagName("a")[0].innerHtml,
    district: fedPartRows[3].getElementsByTagName("a")[0].innerHtml,
    year: fedPartRows[4].getElementsByTagName("a")[0].innerHtml,
    updateTime: fedPartRows[5].text,
    introduction:
        fedPartRows[6].getElementsByClassName("fed-part-esan")[0].text,
  );

  // 剧集列表
  var episodeList = episodeDom.map((elemtet) {
    if (elemtet.getElementsByClassName("stui-content__playlist").length > 0) {
      var title = elemtet.getElementsByClassName("fed-tabs-btns")[0].text;
      var list = elemtet
          .getElementsByClassName("stui-content__playlist")[0]
          .getElementsByTagName("li")
          .asMap()
          .entries
          .map(
        (entries) {
          return EpisodeItemModel(
            id: entries.value.id,
            url: entries.value.getElementsByTagName("a")[0].attributes["href"],
            title: "${entries.key + 1}".toString(),
          );
        },
      ).toList();
      return EpisodeListModel(list: list, title: title);
    }
  }).toList();

  // 相关热播
  var hotRecommendList = hotRecommendDom.map((row) {
    // 判断图片是否有前缀
    var isHttp = row
        .getElementsByClassName("fed-list-pics")[0]
        .attributes["data-original"]
        .toString()
        .contains('http');
    return MovieItem(
        id: row.getElementsByClassName("fed-list-pics")[0].attributes["href"],
        title: row.getElementsByClassName("fed-list-title")[0].innerHtml,
        actors: row.getElementsByClassName("fed-list-desc")[0].innerHtml,
        update: row.getElementsByClassName("fed-list-remarks")[0].innerHtml,
        pic: isHttp
            ? row
                .getElementsByClassName("fed-list-pics")[0]
                .attributes["data-original"]
            : "https://www.nangua55.net" +
                "${row.getElementsByClassName("fed-list-pics")[0].attributes["data-original"]}",
        score: row.getElementsByClassName("fed-list-score")[0].innerHtml);
  });
  episodeList.removeWhere((e) => e == null);
  return {
    "movieInfo": movieInfo,
    "episodeList": episodeList,
    "hotRecommendList": hotRecommendList
  };
}

// 获取电影url
getMovieUrlAPI(id) async {
  var htmltext = await Http.get('${id}');
  var foldertree = parse(htmltext.toString());
  // 电影详情节点
  var urlDom = foldertree.getElementsByClassName("wrap")[0].text;
  RegExp mobile = RegExp(
      r'(https)://[-A-Za-z0-9+&@#/%?=~_|!:,.;]+[-A-Za-z0-9+&@#/%=~_|]*?');
  var match = mobile.allMatches(urlDom);
  return match.toList()[0][0];
}
