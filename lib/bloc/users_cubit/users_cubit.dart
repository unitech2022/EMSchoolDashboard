import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:emschool_dashboard/core/enums/loading_status.dart';
import 'package:emschool_dashboard/core/extensions/extensions_routing.dart';
import 'package:emschool_dashboard/core/helpers/helper_functions.dart';
import 'package:emschool_dashboard/core/routing/routes.dart';
import 'package:emschool_dashboard/core/utlis/utils.dart';
import 'package:emschool_dashboard/models/register_body_reqquest.dart';
import 'package:emschool_dashboard/models/users_rsponse.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/utlis/api_constatns.dart';
part 'users_state.dart';

class UsersCubit extends Cubit<UsersState> {
  UsersCubit() : super(const UsersState());

  static UsersCubit get(context) => BlocProvider.of<UsersCubit>(context);

  Future getUsers({page = 1, role,classRoomId}) async {
    emit(const UsersState(getUsersState: RequestState.loading));
    var dio = Dio();
    var response = await dio.request(
      '${ApiConstants.baseUrl}/dashboard/get-users?page=$page&&userRole=$role&&clasRoomId=$classRoomId',
      options: Options(
        method: 'GET',
      ),
    );
    debugPrint("${response.statusCode}====> getUsers");
    if (response.statusCode == 200) {
      if (role == ApiConstants.studentRole) {
        emit(state.copyWith(
            getUsersState: RequestState.loaded,
            studentsResponse: UsersResponse.fromJson(response.data)));
      } else if (role == ApiConstants.teacherRole) {
        emit(state.copyWith(
            getUsersState: RequestState.loaded,
            teachersResponse: UsersResponse.fromJson(response.data)));
      } else if (role == ApiConstants.parentRole)  {
           emit(state.copyWith(
            getUsersState: RequestState.loaded,
           parentsResponse : UsersResponse.fromJson(response.data)));
      }
    } else {
      emit(const UsersState(getUsersState: RequestState.error));
    }
  }

  /// data for login

  Future registerUser(RequestBodyRegister registerBody, BuildContext context,
      {type}) async {
    showUpdatesLoading(context);
    emit(const UsersState(registerState: RequestState.loading));
    var data = FormData.fromMap({
      'userName': registerBody.userName,
      'FullName': registerBody.fullName,
      'StageId': registerBody.stageId.toString(),
      'subjectId': registerBody.subjectId.toString(),
      'Password': registerBody.password,
      'Role': registerBody.role,
      'TypeEducationId': registerBody.typeEducationId.toString(),
      'ClassRoomId': registerBody.classRoomId.toString()
    });

    var dio = Dio();
    var response = await dio.request(
      '${ApiConstants.baseUrl}/user-signup',
      options: Options(
        method: 'POST',
      ),
      data: data,
    );
    debugPrint("${response.statusCode} + ===== > registerUser");
    if (response.statusCode == 200) {
      context.navigateToNamed(Routes.home);
      emit(const UsersState(registerState: RequestState.loaded));
    } else {
      showErrorLoading(context, "Something went wrong");
      emit(const UsersState(registerState: RequestState.error));
    }
  }

// update user
  Future editeProfile(
      RequestBodyRegister userResponse, String id, BuildContext context) async {
    showUpdatesLoading(context);
    emit(const UsersState(updateUsereState: RequestState.loading));
    var data = FormData.fromMap({
      'id': id,
      'FullName': userResponse.fullName,
      'StageId': userResponse.stageId.toString(),
      'subjectId': userResponse.subjectId.toString(),
      'Password': userResponse.password,
      'Role': userResponse.role,
      'TypeEducationId': userResponse.typeEducationId.toString(),
      'ClassRoomId': userResponse.classRoomId.toString()
    });

    var dio = Dio();
    var response = await dio.request(
      '${ApiConstants.baseUrl}/dashboard/update-user-admin',
      options: Options(
        method: 'PUT',
      ),
      data: data,
    );
    debugPrint("${response.statusCode}/update-profile");
    if (response.statusCode == 200) {
      pop(context);
      context.navigateToNamed(Routes.home);

      emit(const UsersState(
        updateUsereState: RequestState.loaded,
      ));
    } else {
      pop(context);
      emit(const UsersState(updateUsereState: RequestState.error));
    }
  }
}
