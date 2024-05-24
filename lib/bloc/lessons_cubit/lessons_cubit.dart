import 'package:dio/dio.dart';
import 'package:emschool_dashboard/models/course_model.dart';
import 'package:emschool_dashboard/models/unit_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/api_service/api_service.dart';
import '../../core/enums/loading_status.dart';
import '../../core/helpers/helper_functions.dart';
import '../../core/utlis/api_constatns.dart';
import '../../models/lessons_response.dart';
part 'lessons_state.dart';

class LessonsCubit extends Cubit<LessonsState> {
  ApiServiceRepo apiService;
  LessonsCubit({required this.apiService}) : super(const LessonsState());

  static LessonsCubit get(context) => BlocProvider.of<LessonsCubit>(context);
  List<LessonsAdminResponse>? lessons;
  List<CourseModel> couses = [];
  List<UnitResponse> units = [];

  Future getLessons({page, typeId, context}) async {
    couses = [];
    units = [];
    emit(const LessonsState(getLessonsState: RequestState.loading));
    var dio = Dio();
    var response = await dio.request(
      '${ApiConstants.baseUrl}/dashboard/get-lessons?page=$page&subjectId=$typeId',
      options: Options(
        method: 'GET',
      ),
    );
    debugPrint("${response.statusCode}====> getLessons");
    if (response.statusCode == 200) {
      lessons = List.from(
          (response.data as List).map((e) => LessonsAdminResponse.fromJson(e)));

      for (var element in lessons!) {
        couses.add(element.course);
        units.addAll(element.units);
      }
      debugPrint(couses.length.toString());

      emit(LessonsState(
        getLessonsState: RequestState.loaded,
        lessons: lessons!,
      ));
    } else {
      emit(const LessonsState(getLessonsState: RequestState.error));
    }
  }

  sortList(int id) {
    emit(state.copyWith(changeDataState: RequestState.loading));
    units = [];
    for (var element in lessons!) {
      units.addAll(element.units);
    }
    units = units.where((element) => element.unitModel.courseId == id).toList();

    emit(state.copyWith(changeDataState: RequestState.loaded));
  }

//************************************************************************* addClassRoom
// add course
  Future addCourse({context, nameAr, nameEng, subjectId}) async {
    emit(state.copyWith(changeDataState: RequestState.loading));
    var data = FormData.fromMap({
      'SubjectId': subjectId.toString(),
      'TeacherId': "admin",
      'NameAr': nameAr,
      'NameEng': nameEng,
      'Image': 'not'
    });

    var dio = Dio();
    var response = await dio.request(
      '${ApiConstants.baseUrl}/Courses/add-Course',
      options: Options(
        method: 'POST',
      ),
      data: data,
    );
    debugPrint("${response.statusCode}addCourse");
    if (response.statusCode == 200) {
      pop(context);
      emit(state.copyWith(changeDataState: RequestState.loaded));
      await getLessons(context: context, page: 1, typeId: 0);
    } else {
      emit(state.copyWith(changeDataState: RequestState.error));
    }
  }

// delete the course
  Future deleteCourse({context, nameAr, nameEng, courseId}) async {
    emit(state.copyWith(changeDataState: RequestState.loading));
    var data = FormData.fromMap({'CourseId': courseId.toString()});

    var dio = Dio();
    var response = await dio.request(
      '${ApiConstants.baseUrl}/Courses/delete-Course',
      options: Options(
        method: 'POST',
      ),
      data: data,
    );
    debugPrint("${response.statusCode}delete-Course");
    if (response.statusCode == 200) {
      showToast(msg: "تم الحذف بنجاح", color: Colors.red);
      await getLessons(context: context, page: 1, typeId: 0);
    } else {
      emit(state.copyWith(changeDataState: RequestState.error));
    }
  }

  Future updateCourse({context, nameAr, nameEng, courseId}) async {
    emit(state.copyWith(changeDataState: RequestState.loading));
    var data = FormData.fromMap(
        {'Id': courseId.toString(), 'NameAr': nameAr, 'NameEng': nameEng});

    var dio = Dio();
    var response = await dio.request(
      '${ApiConstants.baseUrl}/Courses/update-Course',
      options: Options(
        method: 'PUT',
      ),
      data: data,
    );
    debugPrint("${response.statusCode}UpdateCourse");
    if (response.statusCode == 200) {
      pop(context);
      emit(state.copyWith(changeDataState: RequestState.loaded));
      await getLessons(context: context, page: 1, typeId: 0);
    } else {
      emit(state.copyWith(changeDataState: RequestState.error));
    }
  }

// add unnit
  Future addUnit({context, courseId, nameAr, nameEng}) async {
    emit(state.copyWith(changeDataState: RequestState.loading));
    var data = FormData.fromMap({
      'NameAr': nameAr,
      'CourseId': courseId.toString(),
      'NameEng': nameEng,
      'ImageUrl': 'RF'
    });

    var dio = Dio();
    var response = await dio.request(
      '${ApiConstants.baseUrl}/Units/add-Unit',
      options: Options(
        method: 'POST',
      ),
      data: data,
    );
    debugPrint("${response.statusCode}addUnit");

    if (response.statusCode == 200) {
      emit(state.copyWith(changeDataState: RequestState.loaded));
      pop(context);
      await getLessons(context: context, page: 1, typeId: 0);
    } else {
      emit(state.copyWith(changeDataState: RequestState.error));
    }
  }

// update
  Future updateUnit({context, courseId, nameAr, nameEng, id}) async {
    emit(state.copyWith(changeDataState: RequestState.loading));
    var data = FormData.fromMap({
      'NameAr': nameAr,
      'CourseId': courseId.toString(),
      'NameEng': nameEng,
      "id": id.toString(),
    });

    var dio = Dio();
    var response = await dio.request(
      '${ApiConstants.baseUrl}/Units/update-Unit',
      options: Options(
        method: 'PUT',
      ),
      data: data,
    );
    debugPrint("${response.statusCode}update-Unit");

    if (response.statusCode == 200) {
      emit(state.copyWith(changeDataState: RequestState.loaded));
      await getLessons(context: context, page: 1, typeId: 0);
      pop(context);
    } else {
      emit(state.copyWith(changeDataState: RequestState.error));
    }
  }

// delete the unit
  Future deleteUnite({context, unitId}) async {
    emit(state.copyWith(changeDataState: RequestState.loading));
    var data = FormData.fromMap({'UnitId': unitId.toString()});

    var dio = Dio();
    var response = await dio.request(
      '${ApiConstants.baseUrl}/Units/delete-Unit',
      options: Options(
        method: 'POST',
      ),
      data: data,
    );
    debugPrint("${response.statusCode}delete-Unit");
    if (response.statusCode == 200) {
      showToast(msg: "تم الحذف بنجاح", color: Colors.red);
      emit(state.copyWith(changeDataState: RequestState.loaded));
      await getLessons(context: context, page: 1, typeId: 0);
    } else {
      emit(state.copyWith(changeDataState: RequestState.error));
    }
  }

// add Lesson
  Future addLesson(
      {context,
      nameAr,
      nameEng,
      descAr,
      descEng,
      link,
      image,
      subjectId,
      unitId}) async {
    emit(state.copyWith(changeDataState: RequestState.loading));
    var data = FormData.fromMap({
      'NameAr': nameAr,
      'UnitId': unitId.toString(),
      'NameEng': nameEng,
      'DescAr': descAr,
      'DescEng': descEng,
      'LinkVidio': link,
      'Image': image,
      'teacherId': "admin",
      'subjectId': subjectId.toString()
    });

    var dio = Dio();
    var response = await dio.request(
      '${ApiConstants.baseUrl}/Lessons/add-Lesson',
      options: Options(
        method: 'POST',
      ),
      data: data,
    );

    if (response.statusCode == 200) {
      emit(state.copyWith(changeDataState: RequestState.loaded));
      await getLessons(context: context, page: 1, typeId: 0);
      pop(context);
    } else {
      emit(state.copyWith(changeDataState: RequestState.error));
    }
  }

// update Lesson
  Future updateLesson(
      {context,
      nameAr,
      nameEng,
      descAr,
      descEng,
      link,
      image,
      unitId,
      id}) async {
    emit(state.copyWith(changeDataState: RequestState.loading));
    var data = FormData.fromMap({
      'NameAr': nameAr,
      'UnitId': unitId.toString(),
      'NameEng': nameEng,
      'DescAr': descAr,
      'DescEng': descEng,
      'LinkVidio': link,
      'Image': image,
      "id": id.toString()
    });

    var dio = Dio();
    var response = await dio.request(
      '${ApiConstants.baseUrl}/Lessons/update-Lesson',
      options: Options(
        method: 'PUT',
      ),
      data: data,
    );
    debugPrint("${response.statusCode}update-Lesson");
    if (response.statusCode == 200) {
      emit(state.copyWith(changeDataState: RequestState.loaded));
      await getLessons(context: context, page: 1, typeId: 0);
      pop(context);
    } else {
      emit(state.copyWith(changeDataState: RequestState.error));
    }
  }

// delete lesson
  Future deleteLesson({context, lessonId}) async {
    emit(state.copyWith(changeDataState: RequestState.loading));
    var data = FormData.fromMap({'LessonId': lessonId.toString()});

    var dio = Dio();
    var response = await dio.request(
      '${ApiConstants.baseUrl}/Lessons/delete-Lesson',
      options: Options(
        method: 'POST',
      ),
      data: data,
    );
    debugPrint("${response.statusCode}delete-Lesson");
    if (response.statusCode == 200) {
      showToast(msg: "تم الحذف بنجاح", color: Colors.red);
      emit(state.copyWith(changeDataState: RequestState.loaded));
      await getLessons(context: context, page: 1, typeId: 0);
    } else {
      emit(state.copyWith(changeDataState: RequestState.error));
    }
  }

  Future uploadImage() async {
    emit(state.copyWith(uploadImageState: RequestState.loading));
    var response = await apiService.uploadImage();
     print(response.toString()+"erkfkrke");
    if (response.statusCode == 200) {
      String data = await response.stream.bytesToString();
      print(data);
      emit(state.copyWith(uploadImageState: RequestState.loaded, image: data));
    } else {
      emit(state.copyWith(uploadImageState: RequestState.error));
    }
  }
}
