import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:emschool_dashboard/models/events_response.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/api_service/api_service.dart';
import '../../core/enums/loading_status.dart';
import '../../core/helpers/helper_functions.dart';
import '../../core/utlis/api_constatns.dart';

part 'events_state.dart';

class EventsCubit extends Cubit<EventsState> {
    ApiServiceRepo apiService;
  EventsCubit({required this.apiService}) : super(const EventsState());
  static EventsCubit get(context) => BlocProvider.of<EventsCubit>(context);
  // **************************************************************** get Events
  Future getEvents({page, typeId, context}) async {
    emit(state.copyWith(getEventsState: RequestState.loading));
    var dio = Dio();
    var response = await dio.request(
      '${ApiConstants.baseUrl}/dashboard/get-events?page=$page',
      options: Options(
        method: 'GET',
      ),
    );
    debugPrint("${response.statusCode}====> getEvents");
    if (response.statusCode == 200) {
      // await getDataForLogin();
      emit(state.copyWith(
        getEventsState: RequestState.loaded,
        eventsResponse: EventsResponse.fromJson(response.data),
      ));
    } else {
      emit(state.copyWith(getEventsState: RequestState.error));
    }
  }

//************************************************************************* addEvent
  Future addEvent({context, image}) async {
    emit(state.copyWith(changeDataState: RequestState.loading));

    var data = FormData.fromMap({
      'Image': image,
    });

    var dio = Dio();
    var response = await dio.request(
      '${ApiConstants.baseUrl}/Bunners/add-Bunner',
      options: Options(
        method: 'POST',
      ),
      data: data,
    );
    debugPrint("${response.statusCode}====> add-Bunner");
    if (response.statusCode == 200) {
      pop(context);
      await getEvents(page: 1, typeId: 0);

      emit(state.copyWith(changeDataState: RequestState.loaded));
    } else {
      emit(state.copyWith(changeDataState: RequestState.error));
    }
  }

//************************************************************************* updateEvent
  Future updateEvent({context, image, id}) async {
    emit(state.copyWith(changeDataState: RequestState.loading));

    var data = 
    FormData.fromMap({'Image': image,
    'id': id.toString()});

    var dio = Dio();
    var response = await dio.request(
      '${ApiConstants.baseUrl}/Bunners/update-Bunner',
      options: Options(
        method: 'PUT',
      ),
      data: data,
    );
    debugPrint("${response.statusCode}====> /Events/update-Event");
    if (response.statusCode == 200) {
      pop(context);
      await getEvents(page: 1, typeId: 0);

      emit(state.copyWith(changeDataState: RequestState.loaded));
    } else {
      emit(state.copyWith(changeDataState: RequestState.error));
    }
  }

// **************************************************************** . delete
  Future deleteEvent({context, id}) async {
    emit(state.copyWith(changeDataState: RequestState.loading));

    var data = FormData.fromMap({'BunnerId': id});

    var dio = Dio();
    var response = await dio.request(
      '${ApiConstants.baseUrl}/Bunners/delete-Bunner',
      options: Options(
        method: 'POST',
      ),
      data: data,
    );
    debugPrint("${response.statusCode}====> delete-Bunner");
    if (response.statusCode == 200) {
      showToast(msg: "تم الحذف بنجاح", color: Colors.green);
      await getEvents(page: 1, typeId: 0);

      emit(state.copyWith(changeDataState: RequestState.loaded));
    } else {
      emit(state.copyWith(changeDataState: RequestState.error));
    }
  }

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
