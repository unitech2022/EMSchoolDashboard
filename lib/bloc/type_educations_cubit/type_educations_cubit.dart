import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:emschool_dashboard/core/enums/loading_status.dart';
import 'package:emschool_dashboard/core/helpers/helper_functions.dart';
import 'package:emschool_dashboard/core/utlis/api_constatns.dart';

import 'package:emschool_dashboard/models/type_educations_response.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'type_educations_state.dart';

class TypeEducationsCubit extends Cubit<TypeEducationsState> {
  TypeEducationsCubit() : super(const TypeEducationsState());

  static TypeEducationsCubit get(context) =>
      BlocProvider.of<TypeEducationsCubit>(context);

  Future getTypeEducations({page, context}) async {
    emit(const TypeEducationsState(
        getTypeEducationsStage: RequestState.loading));
    var dio = Dio();
    var response = await dio.request(
      '${ApiConstants.baseUrl}/dashboard/get-typeEducations?page=$page',
      options: Options(
        method: 'GET',
      ),
    );
    debugPrint("${response.statusCode}====> getTypeEducations");
    if (response.statusCode == 200) {
      // await getDataForLogin();
      emit(TypeEducationsState(
        getTypeEducationsStage: RequestState.loaded,
        typeEducations: TypeEducationsResponse.fromJson(response.data),
      ));
    } else {
      emit(const TypeEducationsState(
          getTypeEducationsStage: RequestState.error));
    }
  }

  Future addTypeEducation({context, nameAr, nameEng }) async {
    emit(state.copyWith(addTypeEducationState: RequestState.loading));

    var data = FormData.fromMap({'NameAr': nameAr, 'NameEng': nameEng});

    var dio = Dio();
    var response = await dio.request(
      '${ApiConstants.baseUrl}/TypeEducation/add-TypeEducation',
      options: Options(
        method: 'POST',
      ),
      data: data,
    );
    debugPrint("${response.statusCode}====> addTypeEducation");
    if (response.statusCode == 200) {
      pop(context);
      await getTypeEducations(page: 1);

      emit(state.copyWith(addTypeEducationState: RequestState.loaded));
    } else {
      emit(state.copyWith(addTypeEducationState: RequestState.error));
    }
  }

// ================================================================= update
  Future updateTypeEducation({context, nameAr, nameEng, id}) async {
    emit(state.copyWith(addTypeEducationState: RequestState.loading));

    var data = FormData.fromMap(
        {'NameAr': nameAr, 'NameEng': nameEng, 'id': id.toString()});

    var dio = Dio();
    var response = await dio.request(
      '${ApiConstants.baseUrl}/TypeEducation/update-TypeEducation',
      options: Options(
        method: 'PUT',
      ),
      data: data,
    );
    debugPrint("${response.statusCode}====> update-TypeEducation");
    if (response.statusCode == 200) {
      await getTypeEducations(page: 1, context: context);
      pop(context);
      emit(state.copyWith(addTypeEducationState: RequestState.loaded));
    } else {
      emit(state.copyWith(addTypeEducationState: RequestState.error));
    }
  }

  Future deleteTypeEducation({context, id}) async {
    emit(state.copyWith(addTypeEducationState: RequestState.loading));

    var data = FormData.fromMap({'TypwEducationId': id});

    var dio = Dio();
    var response = await dio.request(
      '${ApiConstants.baseUrl}/TypeEducation/delete-TypwEducation',
      options: Options(
        method: 'POST',
      ),
      data: data,
    );
    debugPrint("${response.statusCode}====> delete-TypwEducation");
    if (response.statusCode == 200) {
      showToast(msg: "تم الحذف بنجاح", color: Colors.green);
      await getTypeEducations(page: 1);

      emit(state.copyWith(addTypeEducationState: RequestState.loaded));
    } else {
      emit(state.copyWith(addTypeEducationState: RequestState.error));
    }
  }

//
}
