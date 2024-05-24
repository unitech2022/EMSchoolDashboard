import 'package:emschool_dashboard/bloc/app_cubit/app_cubit.dart';
import 'package:emschool_dashboard/bloc/home_cubit/home_cubit.dart';
import 'package:emschool_dashboard/core/theming/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    AppCubit.get(context).getPage(context);
    HomeCubit.get(context).getDataForLogin();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: ColorsApp.mainColor,
          body: Container(
              alignment: Alignment.center,
              child: const CircularProgressIndicator(
                color: Colors.white,
              )),
        );
      },
    );
  }
}
