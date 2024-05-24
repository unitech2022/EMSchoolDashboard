import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/api_service/api_service.dart';
import '../../core/enums/loading_status.dart';
import '../../core/helpers/helper_functions.dart';
import '../../core/utlis/api_constatns.dart';
import '../../models/entertainment_model.dart';

part 'entertainments_state.dart';

class EntertainmentsCubit extends Cubit<EntertainmentsState> {
  ApiServiceRepo apiService;

  EntertainmentsCubit({required this.apiService})
      : super(const EntertainmentsState());

  static EntertainmentsCubit get(context) =>
      BlocProvider.of<EntertainmentsCubit>(context);
  // **************************************************************** get Events
  Future getEntrtainments({page, typeId, context}) async {
    emit(state.copyWith(getEntertainmentsState: RequestState.loading));
    var dio = Dio();
    var response = await dio.request(
      '${ApiConstants.baseUrl}/dashboard/get-entertainments?page=$page&typId=$typeId',
      options: Options(
        method: 'GET',
      ),
    );
    debugPrint("${response.statusCode}====> getEvents");
    if (response.statusCode == 200) {
      // await getDataForLogin();
      emit(state.copyWith(
        getEntertainmentsState: RequestState.loaded,
        entertainments: EnntertainmentssResponse.fromJson(response.data),
      ));
    } else {
      emit(state.copyWith(getEntertainmentsState: RequestState.error));
    }
  }

//************************************************************************* addEvent
  Future addEntrtainment({context, nameAr, nameEng, link, image}) async {
    emit(state.copyWith(changeDataState: RequestState.loading));

    var data = FormData.fromMap(
        {'nameAr': nameAr, 'nameEng': nameEng, 'link': link, 'Image': image});

    var dio = Dio();
    var response = await dio.request(
      '${ApiConstants.baseUrl}/Entertaiment/add-Entertainment',
      options: Options(
        method: 'POST',
      ),
      data: data,
    );
    debugPrint("${response.statusCode}====> add-Entertainment");
    if (response.statusCode == 200) {
      pop(context);
      await getEntrtainments(page: 1, typeId: 0);

      emit(state.copyWith(changeDataState: RequestState.loaded));
    } else {
      emit(state.copyWith(changeDataState: RequestState.error));
    }
  }

//************************************************************************* updateEvent

  Future updateEntrtainment({context, nameAr, nameEng, link, image, id}) async {
    emit(state.copyWith(changeDataState: RequestState.loading));

    var data = FormData.fromMap({
      'nameAr': nameAr,
      'nameEng': nameEng,
      'link': link,
      'Image': image,
      'id': id.toString()
    });

    var dio = Dio();
    var response = await dio.request(
      '${ApiConstants.baseUrl}/Entertaiment/update-Entertainment',
      options: Options(
        method: 'PUT',
      ),
      data: data,
    );
    debugPrint("${response.statusCode}====> /Events/update-Event");
    if (response.statusCode == 200) {
      pop(context);
      await getEntrtainments(page: 1, typeId: 0);

      emit(state.copyWith(changeDataState: RequestState.loaded));
    } else {
      emit(state.copyWith(changeDataState: RequestState.error));
    }
  }

// **************************************************************** . delete
  Future deleteEntrtainment({context, id}) async {
    emit(state.copyWith(changeDataState: RequestState.loading));

    var data = FormData.fromMap({'BunnerId': id});

    var dio = Dio();
    var response = await dio.request(
      '${ApiConstants.baseUrl}/Entertaiment/delete-Entertainment',
      options: Options(
        method: 'POST',
      ),
      data: data,
    );
    debugPrint("${response.statusCode}====> delete-Bunner");
    if (response.statusCode == 200) {
      showToast(msg: "تم الحذف بنجاح", color: Colors.green);
      await getEntrtainments(page: 1, typeId: 0);

      emit(state.copyWith(changeDataState: RequestState.loaded));
    } else {
      emit(state.copyWith(changeDataState: RequestState.error));
    }
  }

// =================================================================
// =================================================================
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
