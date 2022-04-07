import 'package:flutter/cupertino.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:moth_movie/provider/banner_provider.dart';
import 'package:provider/provider.dart';

class BannerSwiper extends StatefulWidget {
  @override
  State<BannerSwiper> createState() => BannerSwiper_State();
}

class BannerSwiper_State extends State<BannerSwiper> {
  @override
  Widget build(BuildContext context) {
    // 里面可以设置不是sliver类型的widget。如 container
    return Container(
      margin: EdgeInsets.only(top: 20, bottom: 20),
      width: double.infinity,
      child: AspectRatio(
        // 配置宽高比
        aspectRatio: 2.5,
        child: Swiper(
          key: UniqueKey(),
          itemBuilder: (BuildContext context, int index) {
            // 配置图片地址
            return Padding(
              padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: FadeInImage.assetNetwork(
                  placeholder: "assets/images/timg.jpg",
                  image: context.watch<BannerProvider>().bannerList[index].pic,
                  fit: BoxFit.fill,
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
            );
          },
          // 配置图片数量
          itemCount: context.watch<BannerProvider>().bannerList.length,
          // 无限循环
          loop: true,
          // 自动轮播
          autoplay: true,
          autoplayDelay: 8000,
          pagination: SwiperPagination(builder: SwiperPagination.dots),
        ),
      ),
    );
  }
}
