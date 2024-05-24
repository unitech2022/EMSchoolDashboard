
import 'package:emschool_dashboard/core/helpers/helper_functions.dart';
import 'package:emschool_dashboard/ui/login_screen/login_screen.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/routing/routes.dart';
part 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit() : super(const AppState());
  static AppCubit get(context) => BlocProvider.of<AppCubit>(context);


  getPage(context) {

    Future.delayed(const Duration(seconds: 2), () {

        if (isLogin()) {
          pushPageRoutName(context, Routes.home);
      }else {
          pushPage(context, const LoginScreen());
        }
      // FlutterNativeSplash.remove();
      emit(const AppState(page: "done"));
    });
  }


  changeIndexSidMenu(int newIndex) {

    emit(state.copyWith(indexSideMenu: newIndex));
  }
}
