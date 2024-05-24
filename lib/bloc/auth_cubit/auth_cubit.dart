
import 'package:dio/dio.dart';
import 'package:emschool_dashboard/core/enums/loading_status.dart';
import 'package:emschool_dashboard/core/extensions/extensions_routing.dart';
import 'package:emschool_dashboard/core/helpers/helper_functions.dart';
import 'package:emschool_dashboard/core/routing/routes.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/utlis/api_constatns.dart';
import '../../core/utlis/app_model.dart';
import '../../core/utlis/session_manager.dart';

import '../../models/user_response.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(const AuthState());
  static AuthCubit get(context) => BlocProvider.of<AuthCubit>(context);

  /// login
  Future loginAdmin(BuildContext context, {userName, password}) async {
    emit(state.copyWith(loginSignUpState: RequestState.loading));
    var data = FormData.fromMap({'UserName': userName, 'Password': password});

    var dio = Dio();
    var response = await dio.request(
      '${ApiConstants.baseUrl}/admin-login',
      options: Options(
        method: 'POST',
      ),
      data: data,
    );

    debugPrint("${response.statusCode} + ===== > loginUser");

    if (response.statusCode == 200) {
      if (response.data["token"] == null) {
        showToast(msg: "بيانات التسجيل غير صحيحة", color: Colors.red);
      } else {
        UserResponse userResponse =
            currentUser = UserResponse.fromJson(response.data);
        await SessionManager().setUserData(userResponse.toJson());

        context.navigateToNamed(Routes.home);
        emit(state.copyWith(
            loginSignUpState: RequestState.loaded, userResponse: userResponse));
      }
    } else {
     
      emit(state.copyWith(loginSignUpState: RequestState.error));
    }
  }
}
