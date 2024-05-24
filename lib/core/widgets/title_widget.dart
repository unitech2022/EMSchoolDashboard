import 'package:emschool_dashboard/core/helpers/spacing.dart';
import 'package:emschool_dashboard/core/theming/styles.dart';
import 'package:emschool_dashboard/core/widgets/custom_button.dart';
import 'package:flutter/material.dart';

class TitleWidget extends StatelessWidget {
  final String title, titleButton;
  final bool isButton;
  final void Function() onPress;

  const TitleWidget(
      {super.key,
      required this.title,this.isButton=true,
      required this.titleButton,
      required this.onPress});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyles.textStyleFontBold22Black,
          ),
          horizontalSpace(40),
         isButton? SizedBox(
              width: 200,
              height: 40,
              child: CustomButtonWithIcon(
                  title: titleButton,
                  onPressed: onPress,
                  icon: const Icon(
                    Icons.add,
                    color: Colors.white,
                    size: 30,
                  ))):const SizedBox()
        ],
      ),
    );
  }
}
