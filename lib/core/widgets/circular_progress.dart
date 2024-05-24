
import 'package:emschool_dashboard/core/theming/colors.dart';
import 'package:flutter/material.dart';


import '../layout/app_sizes.dart';





class CustomCircularProgress extends StatelessWidget {
  const CustomCircularProgress({
    super.key,

    this.strokeWidth = AppSize.s3,
    this.color = ColorsApp.mainColor,
    this.fullScreen = false,
  });


  final double strokeWidth;
  final Color color;
  final bool fullScreen;

  @override
  Widget build(BuildContext context) {
    if (fullScreen) {
      return Scaffold(
        body: Center(
          child: SizedBox(
            width: 28,
            height: 28,


            child: Center(
              child: CircularProgressIndicator(
                strokeWidth: strokeWidth,
              color: color,
              ),
            ),
          ),
        ),
      );
    }
    return Center(
      child: SizedBox(
        width: 28,
        height: 28,
        child: Center(
          child: CircularProgressIndicator.adaptive(
            strokeWidth: strokeWidth,
            valueColor: AlwaysStoppedAnimation<Color>(color),
          ),
        ),
      ),
    );
  }
}
