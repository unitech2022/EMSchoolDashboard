import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:emschool_dashboard/core/enums/loading_status.dart';
import 'package:emschool_dashboard/models/alert_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/helpers/helper_functions.dart';
import '../../core/utlis/api_constatns.dart';

part 'alert_state.dart';

class AlertCubit extends Cubit<AlertState> {
  AlertCubit() : super(const AlertState());
  static AlertCubit get(context) => BlocProvider.of<AlertCubit>(context);
  // **************************************************************** get Alerts
  Future getAlerts({page, typeId, context}) async {
    emit(state.copyWith(getAlertState: RequestState.loading));
    var dio = Dio();
    var response = await dio.request(
      '${ApiConstants.baseUrl}/dashboard/get-Alerts?page=$page',
      options: Options(
        method: 'GET',
      ),
    );
    debugPrint("${response.statusCode}====> getAlerts");
    if (response.statusCode == 200) {
      // await getDataForLogin();
      emit(state.copyWith(
        getAlertState: RequestState.loaded,
        alertsResponse: AlertResponse.fromJson(response.data),
      ));
    } else {
      emit(state.copyWith(getAlertState: RequestState.error));
    }
  }

//************************************************************************* addAlert
  Future addAlertAll(AlertModel alertModel, {context, topic}) async {
    emit(state.copyWith(changeDataState: RequestState.loading));

    var data = FormData.fromMap({
      "topic": "All",
      'UserId': alertModel.userId,
      'TitleAr': alertModel.titleAr,
      'TitleEng': alertModel.titleEng,
      'DescriptionAr': alertModel.descriptionAr,
      'DescriptionEng': alertModel.descriptionEng,
      'PageId': alertModel.pageId
    });

    var dio = Dio();
    var response = await dio.request(
      '${ApiConstants.baseUrl}/dashboard/send-Alert',
      options: Options(
        method: 'POST',
      ),
      data: data,
    );
    debugPrint("${response.statusCode}====> send-Alert");
    if (response.statusCode == 200) {
      pop(context);
      await getAlerts(page: 1, typeId: 0);

      emit(state.copyWith(changeDataState: RequestState.loaded));
    } else {
      emit(state.copyWith(changeDataState: RequestState.error));
    }
  }

  Future addAlertToUser(AlertModel alertModel, {context}) async {
    emit(state.copyWith(changeDataState: RequestState.loading));

    var data = FormData.fromMap({
      'UserId': alertModel.userId,
      'TitleAr': alertModel.titleAr,
      'TitleEng': alertModel.titleEng,
      'DescriptionAr': alertModel.descriptionAr,
      'DescriptionEng': alertModel.descriptionEng,
      'PageId': alertModel.pageId
    });

    var dio = Dio();
    var response = await dio.request(
      '${ApiConstants.baseUrl}/dashboard/send-Alert-to-user',
      options: Options(
        method: 'POST',
      ),
      data: data,
    );
    debugPrint("${response.statusCode}====> add-Bunner");
    if (response.statusCode == 200) {
      pop(context);
      await getAlerts(page: 1, typeId: 0);

      emit(state.copyWith(changeDataState: RequestState.loaded));
    } else {
      emit(state.copyWith(changeDataState: RequestState.error));
    }
  }

// //************************************************************************* updateAlert
//   Future updateAlert({context, image, id}) async {
//     emit(state.copyWith(changeDataState: RequestState.loading));

//     var data =
//     FormData.fromMap({'Image': image,
//     'id': id.toString()});

//     var dio = Dio();
//     var response = await dio.request(
//       '${ApiConstants.baseUrl}/Bunners/update-Bunner',
//       options: Options(
//         method: 'PUT',
//       ),
//       data: data,
//     );
//     debugPrint("${response.statusCode}====> /Alerts/update-Alert");
//     if (response.statusCode == 200) {
//       pop(context);
//       await getAlerts(page: 1, typeId: 0);

//       emit(state.copyWith(changeDataState: RequestState.loaded));
//     } else {
//       emit(state.copyWith(changeDataState: RequestState.error));
//     }
//   }

// **************************************************************** . delete
  Future deleteAlert({context, id}) async {
    emit(state.copyWith(changeDataState: RequestState.loading));

    var data = FormData.fromMap({'AlertId': id});

    var dio = Dio();
    var response = await dio.request(
      '${ApiConstants.baseUrl}/alerts/delete-Alert',
      options: Options(
        method: 'POST',
      ),
      data: data,
    );
    debugPrint("${response.statusCode}====> delete-Bunner");
    if (response.statusCode == 200) {
      showToast(msg: "تم الحذف بنجاح", color: Colors.green);
      await getAlerts(page: 1, typeId: 0);

      emit(state.copyWith(changeDataState: RequestState.loaded));
    } else {
      emit(state.copyWith(changeDataState: RequestState.error));
    }
  }
}
