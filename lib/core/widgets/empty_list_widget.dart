import 'package:emschool_dashboard/core/theming/colors.dart';
import 'package:emschool_dashboard/core/widgets/texts.dart';
import 'package:flutter/cupertino.dart';

import '../layout/app_fonts.dart';

class EmptyListWidget extends StatelessWidget {
  final String message;
  const EmptyListWidget({
    super.key, required this.message,
    
  });

  @override
  Widget build(BuildContext context) {
    return  Center(
      child: Texts(title:message, family: AppFonts.innerBold, size: 16,textColor: ColorsApp.mainColor,),
    );
  }
}
