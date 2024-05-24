import 'package:emschool_dashboard/core/theming/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(
          color: ColorsApp.mainColor,
        ),
    );
  }
}