import 'package:dio/dio.dart';
import 'package:emschool_dashboard/core/enums/loading_status.dart';
import 'package:emschool_dashboard/core/utlis/api_constatns.dart';

import 'package:emschool_dashboard/models/home_response.dart';
import 'package:emschool_dashboard/models/response_data_for_login.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/utlis/app_model.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(const HomeState());
  static HomeCubit get(context) => BlocProvider.of<HomeCubit>(context);

  Future getHomeData() async {
    emit(state.copyWith(getHomeDataState: RequestState.loading));
    var dio = Dio();
    var response = await dio.request(
      '${ApiConstants.baseUrl}/dashboard/get-home-dash',
      options: Options(
        method: 'GET',
      ),
    );
    debugPrint("${response.statusCode}====> getHomeData");
    if (response.statusCode == 200) {
      // await getDataForLogin();
      emit(state.copyWith(
          getHomeDataState: RequestState.loaded,
          homeResponse: HomeResponse.fromJson(response.data)));
    } else {
      emit(state.copyWith(getHomeDataState: RequestState.error));
    }
  }

  Future getDataForLogin() async {
    // emit(const UsersState(getResponseForLoginState: RequestState.loading));
    var dio = Dio();
    var response = await dio.request(
      '${ApiConstants.baseUrl}/home/get-data-for-login',
      options: Options(
        method: 'GET',
      ),
    );
    debugPrint("${response.statusCode} + ===== > getDataForLogin");

    if (response.statusCode == 200) {
      responseDataForLogin = ResponseDataForLogin.fromJson(response.data);

      // emit(const UsersState(getResponseForLoginState: RequestState.loaded));
    } else {
      // emit(const UsersState(getResponseForLoginState: RequestState.error));
    }
  }
}
