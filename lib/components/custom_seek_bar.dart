import 'package:flutter/material.dart';

// 进度条
class CustomSeekBar extends StatefulWidget {
  @override
  State<CustomSeekBar> createState() => _CustomSeekBarState();
}

class _CustomSeekBarState extends State<CustomSeekBar> {
  // 当前进度
  double _progres = 0;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          "00:00",
          style: TextStyle(color: Colors.white, fontSize: 12),
        ),
        Expanded(
          child: Slider(
            value: _progres,
            onChanged: (ValueKey) {},
            activeColor: Colors.white,
            inactiveColor: Color.fromRGBO(245, 245, 245, 0.3),
          ),
        ),
        Text(
          "36:00",
          style: TextStyle(color: Colors.white, fontSize: 12),
        ),
      ],
    );
  }
}
