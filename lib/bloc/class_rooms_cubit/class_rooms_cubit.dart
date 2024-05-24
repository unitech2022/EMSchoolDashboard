import 'package:dio/dio.dart';
import 'package:emschool_dashboard/core/utlis/api_constatns.dart';
import 'package:emschool_dashboard/models/class_rooms_response.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/enums/loading_status.dart';
import '../../core/helpers/helper_functions.dart';

part 'class_rooms_state.dart';

class ClassRoomsCubit extends Cubit<ClassRoomsState> {
  ClassRoomsCubit() : super(const ClassRoomsState());

  static ClassRoomsCubit get(context) =>
      BlocProvider.of<ClassRoomsCubit>(context);

  Future getClassRooms({page, typeId, context}) async {
    emit(state.copyWith(getClassRoomsState: RequestState.loading));
    var dio = Dio();
    var response = await dio.request(
      '${ApiConstants.baseUrl}/dashboard/get-ClassRooms?page=$page&stageId=$typeId',
      options: Options(
        method: 'GET',
      ),
    );
    debugPrint("${response.statusCode}====> getClassRooms");
    if (response.statusCode == 200) {
      // await getDataForLogin();
      emit(state.copyWith(
        getClassRoomsState: RequestState.loaded,
        classRooms: ClassRoomsResponse.fromJson(response.data),
      ));
    } else {
      emit(state.copyWith(getClassRoomsState: RequestState.error));
    }
  }

//************************************************************************* addClassRoom
  Future addClassRoom({context, nameAr, nameEng, typeId, stageId}) async {
    emit(state.copyWith(addClassRoomsState: RequestState.loading));

    var data = FormData.fromMap({
      'NameAr': nameAr,
      // 'TypeEducationId': typeId.toString(),
      'NameEng': nameEng,
      'Image': 'RF',
      'StageId': stageId.toString(),
    });

    var dio = Dio();
    var response = await dio.request(
      '${ApiConstants.baseUrl}/ClassRooms/add-ClassRoom',
      options: Options(
        method: 'POST',
      ),
      data: data,
    );
    debugPrint("${response.statusCode}====> /ClassRooms/add-ClassRoom");
    if (response.statusCode == 200) {
      pop(context);
      await getClassRooms(page: 1, typeId: 0);

      emit(state.copyWith(addClassRoomsState: RequestState.loaded));
    } else {
      emit(state.copyWith(addClassRoomsState: RequestState.error));
    }
  }


//************************************************************************* updateClassRoom
  Future updateClassRoom({context, nameAr, nameEng, typeId, stageId,classId}) async {
    emit(state.copyWith(addClassRoomsState: RequestState.loading));

    var data = FormData.fromMap({
      'NameAr': nameAr,
      // 'TypeEducationId': typeId.toString(),
      'NameEng': nameEng,
      'Image': 'RF',
      'StageId': stageId.toString(),
      'id':classId.toString(),
    });

    var dio = Dio();
    var response = await dio.request(
      '${ApiConstants.baseUrl}/ClassRooms/update-ClassRoom',
      options: Options(
        method: 'PUT',
      ),
      data: data,
    );
    debugPrint("${response.statusCode}====> /ClassRooms/update-ClassRoom");
    if (response.statusCode == 200) {
      pop(context);
      await getClassRooms(page: 1, typeId: 0);

      emit(state.copyWith(addClassRoomsState: RequestState.loaded));
    } else {
      emit(state.copyWith(addClassRoomsState: RequestState.error));
    }
  }

// **************************************************************** . delete
  Future deleteClassRoom({context, id}) async {
    emit(state.copyWith(addClassRoomsState: RequestState.loading));

    var data = FormData.fromMap({'ClassRoomId': id});

    var dio = Dio();
    var response = await dio.request(
      '${ApiConstants.baseUrl}/ClassRooms/delete-ClassRoom',
      options: Options(
        method: 'POST',
      ),
      data: data,
    );
    debugPrint("${response.statusCode}====> delete-TypwEducation");
    if (response.statusCode == 200) {
      showToast(msg: "تم الحذف بنجاح", color: Colors.green);
      await getClassRooms(page: 1, typeId: 0);

      emit(state.copyWith(addClassRoomsState: RequestState.loaded));
    } else {
      emit(state.copyWith(addClassRoomsState: RequestState.error));
    }
  }


}
//