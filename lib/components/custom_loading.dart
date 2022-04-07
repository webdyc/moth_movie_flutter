import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:moth_movie/config/app_colors.dart';

class CustomLoading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: Center(
        child: SpinKitFadingFour(
          color: Theme.of(context).primaryColor,
          size: 50.0,
        ),
      ),
    );
  }
}
