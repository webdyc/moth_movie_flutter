import 'package:flutter/cupertino.dart';

// 宫格列表组件
class CustomSliverGrid extends StatelessWidget {
  final List<Widget> gridList;
  CustomSliverGrid({required this.gridList});

  @override
  Widget build(BuildContext context) {
    return SliverGrid.count(
      crossAxisCount: 3,
      childAspectRatio: 0.58,
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      children: gridList,
    );
  }
}
