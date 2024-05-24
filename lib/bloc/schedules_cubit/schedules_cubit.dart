import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:emschool_dashboard/core/helpers/helper_functions.dart';
import 'package:emschool_dashboard/models/schedule_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../../core/enums/loading_status.dart';
import '../../core/utlis/api_constatns.dart';
import '../../models/session_model.dart';

part 'schedules_state.dart';

class SchedulesCubit extends Cubit<SchedulesState> {
  SchedulesCubit() : super(const SchedulesState());
  static SchedulesCubit get(context) =>
      BlocProvider.of<SchedulesCubit>(context);

// get the schedules
  Future getSchedulesByClassId({context, classId, page}) async {
    emit(const SchedulesState(getSchedulesState: RequestState.loading));
    var dio = Dio();
    var response = await dio.request(
      '${ApiConstants.baseUrl}/dashboard/get-schedules?classId=$classId',
      options: Options(
        method: 'GET',
      ),
    );
    debugPrint("${response.statusCode}====> schedules");
    if (response.statusCode == 200) {
      emit(SchedulesState(
        getSchedulesState: RequestState.loaded,
        schedulesResponse: List.from(
            (response.data as List).map((e) => ScheduleResponse.fromJson(e))),
      ));
    } else {
      emit(const SchedulesState(getSchedulesState: RequestState.error));
    }
  }

// ADD schedul
  Future addSchedul(
      List<SessionAddSchedul> sessions, ScheduleModel scheduleModel,
      {context}) async {
    print(jsonEncode(sessions.map((e) => e.toJson()).toList()));

    List<Map<String, dynamic>> listItem = <Map<String, dynamic>>[];
    for (var element in sessions) {
      listItem.add(element.toJson());
    }
    var data = FormData.fromMap({
      'sessions': listItem,
      'typeEducationId': scheduleModel.typeEducationId.toString(),
      'stageId': scheduleModel.stageId.toString(),
      'classRoomId': scheduleModel.classRoomId.toString(),
      'nameAr': scheduleModel.nameAr,
      'nameEng': scheduleModel.nameEng
    });

    emit(const SchedulesState(addSchedulesState: RequestState.loading));

    var dio = Dio();
    dio.interceptors.add(
      PrettyDioLogger(
        requestBody: true,
        requestHeader: true,
        responseHeader: true,
      ),
    );
    var response =
        await dio.request('${ApiConstants.baseUrl}/dashboard/add-schedule',
            options: Options(
              method: 'POST',
              headers: {
                'Content-type': 'application/json',
                'Accept': 'application/json'
              },
            ),
            data: data);

    debugPrint("${response.statusCode}====>add schedules");
    if (response.statusCode == 200) {
      pop(context);
      emit(const SchedulesState(
        addSchedulesState: RequestState.loaded,
      ));
      await getSchedulesByClassId(classId: scheduleModel.classRoomId);
    } else {
      emit(const SchedulesState(addSchedulesState: RequestState.error));
    }
  }

// update schedul
  Future updateSchedul(
      List<SessionAddSchedul> sessions, ScheduleModel scheduleModel,
      {context}) async {
    if (kDebugMode) {
      print(jsonEncode(sessions.map((e) => e.toJson()).toList()));
    }

    List<Map<String, dynamic>> listItem = <Map<String, dynamic>>[];
    for (var element in sessions) {
      listItem.add(element.toJson());
    }
    var data = FormData.fromMap({
      'sessions': listItem,
      "scheduleId": scheduleModel.id.toString(),
      'typeEducationId': scheduleModel.typeEducationId.toString(),
      'stageId': scheduleModel.stageId.toString(),
      'classRoomId': scheduleModel.classRoomId.toString(),
      'nameAr': scheduleModel.nameAr,
      'nameEng': scheduleModel.nameEng
    });

    emit(const SchedulesState(addSchedulesState: RequestState.loading));

    var dio = Dio();
    dio.interceptors.add(
      PrettyDioLogger(
        requestBody: true,
        requestHeader: true,
        responseHeader: true,
      ),
    );
    var response =
        await dio.request('${ApiConstants.baseUrl}/dashboard/update-schedule',
            options: Options(
              method: 'PUT',
              headers: {
                'Content-type': 'application/json',
                'Accept': 'application/json'
              },
            ),
            data: data);

    debugPrint("${response.statusCode}====>Update schedules");
    if (response.statusCode == 200) {
      pop(context);
      emit(const SchedulesState(
        addSchedulesState: RequestState.loaded,
      ));
      await getSchedulesByClassId(classId: scheduleModel.classRoomId);
    } else {
      emit(const SchedulesState(addSchedulesState: RequestState.error));
    }
  }


// **************************************************************** . delete
  Future deleteSchedul({context, scheduleId,classId}) async {
    emit(state.copyWith(addSchedulesState: RequestState.loading));

    var data = FormData.fromMap({'scheduleId': scheduleId.toString()});

    var dio = Dio();
    var response = await dio.request(
      '${ApiConstants.baseUrl}/dashboard/delete-schedule',
      options: Options(
        method: 'POST',
      ),
      data: data,
    );
    debugPrint("${response.statusCode}====> deleteSchedul");
    if (response.statusCode == 200) {
      showToast(msg: "تم الحذف بنجاح", color: Colors.green);
      await getSchedulesByClassId(page: 1, classId:classId);

      emit(state.copyWith(addSchedulesState: RequestState.loaded));
    } else {
      emit(state.copyWith(addSchedulesState: RequestState.error));
    }
  }

// get the schedulesDetails
  ScheduleResponse? scheduleResponse;
  Future getScheduleDetails({context, schedulId}) async {
    emit(const SchedulesState(getSchedulesState: RequestState.loading));
    var dio = Dio();
    var response = await dio.request(
      '${ApiConstants.baseUrl}/dashboard/get-schedule-details?scheduleId=$schedulId',
      options: Options(
        method: 'GET',
      ),
    );
    debugPrint("${response.statusCode}====>getScheduleDetails");
    if (response.statusCode == 200) {

      
      emit(SchedulesState(
        getSchedulesState: RequestState.loaded,
      ));
    } else {
      emit(const SchedulesState(getSchedulesState: RequestState.error));
    }
  }

  dynamic data;
  changeDataSelctor(dynamic newData) {
    emit(state.copyWith(chnageDataSelectState: RequestState.loading));
    data = newData;
    emit(state.copyWith(chnageDataSelectState: RequestState.loaded));
  }
}
