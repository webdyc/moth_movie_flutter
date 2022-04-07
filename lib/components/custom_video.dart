import 'package:flutter/material.dart';
import 'package:chewie/chewie.dart';
import 'package:video_player/video_player.dart';

class CustomVideo extends StatefulWidget {
  final String? url; // 播放地址
  final String? cover; // 封面
  final bool? autoPlay; // 是否自动播放
  final bool? looping; // 是否循环
  final double? aspectRatio; // 宽高比
  const CustomVideo(this.url,
      {Key? key, this.cover, this.autoPlay, this.looping, this.aspectRatio})
      : super(key: key);

  @override
  State<CustomVideo> createState() => _CustomVideoState();
}

class _CustomVideoState extends State<CustomVideo> {
  VideoPlayerController? _videoPlayerController;
  ChewieController? _chewieController;

  // 封面 (FractionallySizedBox:可控制组件在水平/垂直方向上填充满父容器)
  get _placeHolder => FractionallySizedBox(
        widthFactor: 1,
        // child: cacheImage(widget.cover),
      );

  // 进度条颜色设置
  get _progressColors => ChewieProgressColors(
        playedColor: Colors.blue,
        bufferedColor: Colors.grey,
        handleColor: Colors.grey,
        backgroundColor: Colors.black,
      );

  @override
  void initState() {
    print("这是剧集url2222${widget.url}");
    super.initState();
    _videoPlayerController = VideoPlayerController.network(widget.url!);
    _chewieController = ChewieController(
      //要播放的视频的控制器
      videoPlayerController: _videoPlayerController!,
      // 缩放比
      aspectRatio: widget.aspectRatio,
      // 是否自动播放
      autoPlay: widget.autoPlay!,
      // 封面
      looping: widget.looping!,
      // 进度条颜色
      placeholder: _placeHolder,
      // 进度条颜色
      materialProgressColors: _progressColors,
      // 是否静音
      allowMuting: false,
      // 是否显示播放速度
      allowPlaybackSpeedChanging: false,
      // customControls: MaterialControls(
      //   showLoadingOnInitialize: false,
      //   showBigPlayIcon: false,
      //   bottomGradient: blackLinearGradient(),
      // ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width; // 播放器宽度
    double screenHeight = screenWidth / widget.aspectRatio!; // 播放器高度
    return Container(
      width: screenWidth,
      height: screenHeight,
      color: Colors.grey,
      child: Chewie(
        controller: _chewieController!,
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    // 销毁播放器的控制器
    _videoPlayerController!.dispose();
    _chewieController!.dispose();
  }
}
