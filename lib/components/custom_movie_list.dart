// 视频列表组件
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../views/sub_page/movie_detail_page.dart';

class CustomMovieList extends StatelessWidget {
  final String? id;
  final String? title;
  final String? actors;
  final String? update;
  final String? pic;
  final String? score;

  CustomMovieList({
    required this.id,
    required this.title,
    required this.actors,
    required this.update,
    required this.pic,
    required this.score,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => {
        Navigator.of(context)
            .push(CupertinoPageRoute(builder: (BuildContext context) {
          return movieDetailPage(id: id!);
        }))
      },
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  // 占位符图片
                  child: FadeInImage.assetNetwork(
                    placeholder: "assets/images/timg.jpg",
                    image: pic!,
                    fit: BoxFit.fill,
                    height: 180,
                    imageErrorBuilder: (context, error, stackTrace) {
                      // TODO 图片加载错误后展示的 widget
                      // print("---图片加载错误---");
                      // 此处不能 setState
                      return Image.asset(
                        'assets/images/timg.jpg',
                        fit: BoxFit.fill,
                        height: 180,
                      );
                    },
                  ),
                ),
                // 评分
                Positioned(
                  top: 4,
                  right: 0,
                  child: Row(
                    children: [
                      Container(
                        padding: EdgeInsets.fromLTRB(5, 2, 5, 2),
                        color: Colors.green,
                        child: Text(
                          score!,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                // 底部阴影
                Positioned(
                  bottom: 0,
                  left: 0,
                  child: Container(
                    color: Colors.black87.withOpacity(0.3),
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                      children: [
                        Text(
                          "",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            height: 2,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                // 底部阴影文字
                Positioned(
                  bottom: 2,
                  right: 5,
                  child: Text(
                    update!,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      height: 2,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                )
              ],
            ),
            // 视频名称及演员
            Expanded(
              child: Column(
                children: [
                  Text(
                    title!,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.black87,
                    ),
                    textAlign: TextAlign.right,
                  ),
                  Text(
                    actors!,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 12,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
