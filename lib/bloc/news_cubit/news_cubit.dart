import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/api_service/api_service.dart';
import '../../core/enums/loading_status.dart';
import '../../core/helpers/helper_functions.dart';
import '../../core/utlis/api_constatns.dart';
import '../../models/news_model.dart';

part 'news_state.dart';

class NewsCubit extends Cubit<NewsState> {
   ApiServiceRepo apiService;

  NewsCubit({required this.apiService})
      : super(const NewsState());

  static NewsCubit get(context) =>
      BlocProvider.of<NewsCubit>(context);
  // **************************************************************** get Events
  Future getNews({page, typeId, context}) async {
    emit(state.copyWith(getNewsState: RequestState.loading));
    var dio = Dio();
    var response = await dio.request(
      '${ApiConstants.baseUrl}/dashboard/get-news?page=$page&typId=$typeId',
      options: Options(
        method: 'GET',
      ),
    );
    debugPrint("${response.statusCode}====> getNews");
    if (response.statusCode == 200) {
      // await getDataForLogin();
      emit(state.copyWith(
        getNewsState: RequestState.loaded,
        news: NewsResponse.fromJson(response.data),
      ));
    } else {
      emit(state.copyWith(getNewsState: RequestState.error));
    }
  }

//************************************************************************* addEvent
  Future addNews({context, nameAr, nameEng, descAr,descEng, image}) async {
    emit(state.copyWith(changeDataState: RequestState.loading));

    var data = FormData.fromMap(
        {'nameAr': nameAr, 'nameEng': nameEng, 'descAr': descAr,'descEng': descEng, 'Image': image});

    var dio = Dio();
    var response = await dio.request(
      '${ApiConstants.baseUrl}/newes/add-News',
      options: Options(
        method: 'POST',
      ),
      data: data,
    );
    debugPrint("${response.statusCode}====> /newes/add-News");
    if (response.statusCode == 200) {
      pop(context);
      await getNews(page: 1, typeId: 0);

      emit(state.copyWith(changeDataState: RequestState.loaded));
    } else {
      emit(state.copyWith(changeDataState: RequestState.error));
    }
  }

//************************************************************************* updateEvent

  Future updateNews({context, nameAr, nameEng,  descAr,descEng, image, id}) async {
    emit(state.copyWith(changeDataState: RequestState.loading));

    var data = FormData.fromMap({
     'nameAr': nameAr, 'nameEng': nameEng, 'descAr': descAr,'descEng': descEng, 'Image': image,
      'id': id.toString()
    });

    var dio = Dio();
    var response = await dio.request(
      '${ApiConstants.baseUrl}/newes/update-News',
      options: Options(
        method: 'PUT',
      ),
      data: data,
    );
    debugPrint("${response.statusCode}====> /newes/update-News");
    if (response.statusCode == 200) {
      pop(context);
      await getNews(page: 1, typeId: 0);

      emit(state.copyWith(changeDataState: RequestState.loaded));
    } else {
      emit(state.copyWith(changeDataState: RequestState.error));
    }
  }

// **************************************************************** . delete
  Future deleteNews({context, id}) async {
    emit(state.copyWith(changeDataState: RequestState.loading));

    var data = FormData.fromMap({'NewsId': id});

    var dio = Dio();
    var response = await dio.request(
      '${ApiConstants.baseUrl}/newes/delete-News',
      options: Options(
        method: 'POST',
      ),
      data: data,
    );
    debugPrint("${response.statusCode}====> delete-news");
    if (response.statusCode == 200) {
      showToast(msg: "تم الحذف بنجاح", color: Colors.green);
      await getNews(page: 1, typeId: 0);

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
