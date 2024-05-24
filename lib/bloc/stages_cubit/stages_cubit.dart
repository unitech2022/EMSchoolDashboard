import 'package:dio/dio.dart';
import 'package:emschool_dashboard/core/enums/loading_status.dart';
import 'package:emschool_dashboard/core/utlis/api_constatns.dart';
import 'package:emschool_dashboard/models/stages_response.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/helpers/helper_functions.dart';
part 'stages_state.dart';

class StagesCubit extends Cubit<StagesState> {
  StagesCubit() : super(const StagesState());

    static StagesCubit get(context) =>
      BlocProvider.of<StagesCubit>(context);


// **************************************************************** get Stages
  Future getStages({page,typeId, context}) async {
    emit(state.copyWith(
        getStagessStage: RequestState.loading));
    var dio = Dio();
    var response = await dio.request(
      '${ApiConstants.baseUrl}/dashboard/get-Stages?page=$page&typId=$typeId',
      options: Options(
        method: 'GET',
      ),
    );
    debugPrint("${response.statusCode}====> getStages");
    if (response.statusCode == 200) {
      // await getDataForLogin();
      emit(state.copyWith(
        getStagessStage: RequestState.loaded,
        stages:StagesResponse.fromJson(response.data),
      ));
    } else {
      emit(state.copyWith(
          getStagessStage: RequestState.error));
    }
  }
//************************************************************************* addStage
 Future addStage({context, nameAr, nameEng,typeId}) async {
    emit(state.copyWith(addStageState: RequestState.loading));

    var data = FormData.fromMap({
  'NameAr': nameAr,
  'TypeEducationId': typeId.toString(),
  'NameEng': nameEng,
  'Image': 'RF'
});

    var dio = Dio();
    var response = await dio.request(
      '${ApiConstants.baseUrl}/Stages/add-Stage',
      options: Options(
        method: 'POST',
      ),
      data: data,
    );
    debugPrint("${response.statusCode}====> /Stages/add-Stage");
    if (response.statusCode == 200) {
      pop(context);
      await getStages(page: 1,typeId: 0);

      emit(state.copyWith(addStageState: RequestState.loaded));
    } else {
      emit(state.copyWith(addStageState: RequestState.error));
    }
  }


//************************************************************************* updateStage
 Future updateStage({context, nameAr, nameEng,typeId,stageId}) async {
    emit(state.copyWith(addStageState: RequestState.loading));

    var data = FormData.fromMap({
  'NameAr': nameAr,
  'TypeEducationId': typeId.toString(),
  'NameEng': nameEng,
  'Image': 'RF',
  'id':stageId.toString()
});

    var dio = Dio();
    var response = await dio.request(
      '${ApiConstants.baseUrl}/Stages/update-Stage',
      options: Options(
        method: 'PUT',
      ),
      data: data,
    );
    debugPrint("${response.statusCode}====> /Stages/update-Stage");
    if (response.statusCode == 200) {
      pop(context);
      await getStages(page: 1,typeId: 0);

      emit(state.copyWith(addStageState: RequestState.loaded));
    } else {
      emit(state.copyWith(addStageState: RequestState.error));
    }
  }

// **************************************************************** . delete 
  Future deleteStage({context, id}) async {
    emit(state.copyWith(addStageState: RequestState.loading));

    var data = FormData.fromMap({'StageId': id});

    var dio = Dio();
    var response = await dio.request(
      '${ApiConstants.baseUrl}/Stages/delete-Stage',
      options: Options(
        method: 'POST',
      ),
      data: data,
    );
    debugPrint("${response.statusCode}====> delete-TypwEducation");
    if (response.statusCode == 200) {
      showToast(msg: "تم الحذف بنجاح", color: Colors.green);
      await getStages(page: 1,typeId: 0);

      emit(state.copyWith(addStageState: RequestState.loaded));
    } else {
      emit(state.copyWith(addStageState: RequestState.error));
    }
  }


}
