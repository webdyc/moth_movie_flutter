import 'dart:io';

import 'package:flutter/material.dart';
import 'package:moth_movie/config/app_colors.dart';

class RooPageHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Icon(
          Icons.search,
          color: AppColors.un3active,
        ),
        Expanded(child: _searchContent()),
        Icon(
          Icons.track_changes_sharp,
          color: AppColors.un3active,
        ),
      ],
    );
  }

  // 搜索框
  Widget _searchContent() {
    return Container(
      height: 30,
      margin: EdgeInsets.only(left: 15, right: 15),
      decoration: BoxDecoration(
        color: AppColors.page,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        children: [
          Padding(
            padding: EdgeInsets.only(left: 10, right: 4),
            child: Icon(
              Icons.search,
              color: AppColors.un3active,
              size: 16,
            ),
          ),
          Text(
            "搜索关键词",
            style: TextStyle(fontSize: 12, color: AppColors.un3active),
          )
        ],
      ),
    );
  }
}
