import 'package:emschool_dashboard/core/routing/routes.dart';
import 'package:emschool_dashboard/ui/class_rooms_screen/add_class_room_screen/add_class_room_screen.dart';
import 'package:emschool_dashboard/ui/home_screen/home_screen.dart';
import 'package:emschool_dashboard/ui/login_screen/login_screen.dart';
import 'package:emschool_dashboard/ui/schedules_screen/add_schedules_screen/add_schedules_screen.dart';
import 'package:emschool_dashboard/ui/splash_screen/splash_screen.dart';
import 'package:emschool_dashboard/ui/stages_screen/add_stage_screen/add_stage_screen.dart';
import 'package:emschool_dashboard/ui/subjects_screen/add_subject_screen/add_subject_screen.dart';
import 'package:emschool_dashboard/ui/users_screen/add_user_screen/add_user_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppRouter {
  Route generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.loginScreen:
        return MaterialPageRoute(builder: (_) => const LoginScreen());

      case Routes.home:
        return MaterialPageRoute(builder: (_) => const HomeScreen());

      case Routes.splashScreen:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case Routes.addUser:
        return MaterialPageRoute(builder: (_) => const AddUserScreen());

      case Routes.addStage:
        return MaterialPageRoute(builder: (_) =>  AddStageScreen());
              case Routes.addSubbject:
        return MaterialPageRoute(builder: (_) => const AddSubjectScreen());


      case Routes.addClassRoom:
        return MaterialPageRoute(builder: (_) => const AddClassRoomScreen());

            case Routes.addScheduls:
        return MaterialPageRoute(builder: (_) => const AddSchedulesScreen());
      default:
        return CupertinoPageRoute(
            builder: (context) => const Scaffold(
                  body: Center(
                    child: Text('404'),
                  ),
                ));
    }
  }
}
