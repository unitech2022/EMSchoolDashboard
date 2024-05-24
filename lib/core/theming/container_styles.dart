import 'package:flutter/cupertino.dart';


class ContainerStyles{
  
  static BoxDecoration durationGGradientBlue=BoxDecoration(
    borderRadius: BorderRadius.circular(15),
      gradient: LinearGradient(
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
        colors: [
          const Color(0xff2072E0),
          const Color(0xff2072E0).withOpacity(.8),
          const Color(0xff2072E0).withOpacity(.6)
          , const Color(0xff2072E0).withOpacity(.4),


        ],
      )
  );
}