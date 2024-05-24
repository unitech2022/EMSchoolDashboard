import 'package:emschool_dashboard/core/widgets/texts.dart';
import 'package:flutter/material.dart';

import 'package:percent_indicator/percent_indicator.dart';

import '../layout/app_fonts.dart';
class PercentWidget extends StatelessWidget {
  final Color textColor,precentColor;
  final double value;
  final double? size ,strok;
  const PercentWidget({
    super.key,
    required this.textColor, required this.precentColor,
    required this.value,   this.size,this.strok
  });

  @override
  Widget build(BuildContext context) {
    return CircularPercentIndicator(
      radius:size??18.0,
      lineWidth:strok?? 5.0,
      linearGradient:  const LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: <Color>[
        Colors.red,
        Colors.orange,

        Colors.green,

      ], // Gradient from https://learnui.design/tools/gradient-generator.html
      tileMode: TileMode.mirror,
    ),
      percent: value ,
      center: Center(
          child: Texts(
            title: "${(value*100).toStringAsFixed(0)} %",
            family: AppFonts.innerExtraBold,
            textColor: textColor,
            size: 8,
            height: .2,
          )),
      backgroundColor: Colors.black,

    );
  }
}
