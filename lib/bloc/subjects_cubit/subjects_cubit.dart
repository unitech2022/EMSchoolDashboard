import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:emschool_dashboard/core/api_service/api_service.dart';
import 'package:emschool_dashboard/core/utlis/api_constatns.dart';
import 'package:emschool_dashboard/models/subjects_response.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/enums/loading_status.dart';
import '../../core/helpers/helper_functions.dart';

part 'subjects_state.dart';

class SubjectsCubit extends Cubit<SubjectsState> {
  ApiServiceRepo apiService;
  SubjectsCubit({required this.apiService}) : super(const SubjectsState());

  static SubjectsCubit get(context) => BlocProvider.of<SubjectsCubit>(context);

  Future getSujects({page, typeId, context}) async {
    emit(const SubjectsState(getSubjectsState: RequestState.loading));
    var dio = Dio();
    var response = await dio.request(
      '${ApiConstants.baseUrl}/dashboard/get-subjects?page=$page&classRoomId=$typeId',
      options: Options(
        method: 'GET',
      ),
    );
    debugPrint("${response.statusCode}====> getSujects");
    if (response.statusCode == 200) {
      emit(SubjectsState(
        getSubjectsState: RequestState.loaded,
        subjects: SubjectsResponse.fromJson(response.data),
      ));
    } else {
      emit(const SubjectsState(getSubjectsState: RequestState.error));
    }
  }

//************************************************************************* addClassRoom
  Future addSubject(
      {context, nameAr, nameEng, typeId, stageId, classId, image}) async {
    emit(state.copyWith(addSubjectState: RequestState.loading));

    var data = FormData.fromMap({
      'NameAr': nameAr,
      'TypeEducationId': typeId.toString(),
      'NameEng': nameEng,
      'Image': image,
      'ClassRoomId': classId.toString(),
      'StageId': stageId.toString(),
    });

    var dio = Dio();
    var response = await dio.request(
      '${ApiConstants.baseUrl}/Subjects/add-Subject',
      options: Options(
        method: 'POST',
      ),
      data: data,
    );
    debugPrint("${response.statusCode}====> /ClassRooms/add-ClassRoom");
    if (response.statusCode == 200) {
      pop(context);
      await getSujects(page: 1, typeId: 0);

      emit(state.copyWith(addSubjectState: RequestState.loaded));
    } else {
      emit(state.copyWith(addSubjectState: RequestState.error));
    }
  }

//************************************************************************* update
  Future updateSubject(
      {context,
      nameAr,
      nameEng,
      typeId,
      stageId,
      classId,
      image,
      subjectId}) async {
    emit(state.copyWith(addSubjectState: RequestState.loading));

    var data = FormData.fromMap({
      'NameAr': nameAr,
      'TypeEducationId': typeId.toString(),
      'NameEng': nameEng,
      'Image': image,
      'ClassRoomId': classId.toString(),
      'StageId': stageId.toString(),
      'id': subjectId.toString(),
    });

    var dio = Dio();
    var response = await dio.request(
      '${ApiConstants.baseUrl}/Subjects/update-Subject',
      options: Options(
        method: 'PUT',
      ),
      data: data,
    );
    debugPrint("${response.statusCode}====> /ClassRooms/update-Subject");
    if (response.statusCode == 200) {
      pop(context);
      await getSujects(page: 1, typeId: 0);

      emit(state.copyWith(addSubjectState: RequestState.loaded));
    } else {
      emit(state.copyWith(addSubjectState: RequestState.error));
    }
  }

// **************************************************************** . delete
  Future deleteSubject({context, id}) async {
    emit(state.copyWith(addSubjectState: RequestState.loading));

    var data = FormData.fromMap({'SubjectId': id});

    var dio = Dio();
    var response = await dio.request(
      '${ApiConstants.baseUrl}/Subjects/delete-Subject',
      options: Options(
        method: 'POST',
      ),
      data: data,
    );
    debugPrint("${response.statusCode}====> delete-TypwEducation");
    if (response.statusCode == 200) {
      showToast(msg: "تم الحذف بنجاح", color: Colors.green);
      await getSujects(page: 1, typeId: 0);

      emit(state.copyWith(addSubjectState: RequestState.loaded));
    } else {
      emit(state.copyWith(addSubjectState: RequestState.error));
    }
  }

  Future uploadImage() async {
    emit(state.copyWith(uploadImageState: RequestState.loading));
    var response = await apiService.uploadImage();
    if (response.statusCode == 200) {
      String data = await response.stream.bytesToString();
      emit(state.copyWith(uploadImageState: RequestState.loaded, image: data));
    } else {
      emit(state.copyWith(uploadImageState: RequestState.error));
    }
  }

  changImage(String image) {
    emit(state.copyWith(image: image));
  }
}
