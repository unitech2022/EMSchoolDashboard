import 'package:emschool_dashboard/bloc/users_cubit/users_cubit.dart';
import 'package:emschool_dashboard/core/enums/loading_status.dart';
import 'package:emschool_dashboard/core/extensions/extensions_routing.dart';
import 'package:emschool_dashboard/core/helpers/pagination_widget.dart';
import 'package:emschool_dashboard/core/helpers/spacing.dart';
import 'package:emschool_dashboard/core/routing/routes.dart';
import 'package:emschool_dashboard/core/utlis/api_constatns.dart';
import 'package:emschool_dashboard/core/widgets/title_widget.dart';
import 'package:emschool_dashboard/ui/dashboard_screen/recent_users.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/theming/styles.dart';
import '../../core/utlis/app_model.dart';
import '../../core/widgets/drop_dwon_widget.dart';
import '../../core/widgets/loading_widget.dart';
import '../../models/class_room_model.dart';
import '../../models/stage_model.dart';
import '../../models/type_education_model.dart';

class UsersScreen extends StatefulWidget {
  const UsersScreen({super.key});

  @override
  State<UsersScreen> createState() => _UsersScreenState();
}

class _UsersScreenState extends State<UsersScreen> {
  int selectPage = 1;

  TypeEducationModel? typeEducationValue;
  StageModel? stageModel;

  List<StageModel> stages = [];
  ClassRoomModel? classRoomModelValue;
  List<ClassRoomModel> classRooms = [];

  @override
  void initState() {
    super.initState();
    UsersCubit.get(context)
        .getUsers(page: 1, role: ApiConstants.studentRole, classRoomId: 0);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UsersCubit, UsersState>(
      builder: (context, state) {
        return state.getUsersState == RequestState.loading
            ? const LoadingWidget()
            : Scaffold(
                body: SingleChildScrollView(
                  child: Column(
                    children: [
                      verticalSpace(10),
                      TitleWidget(
                        title: "قائمة الطلاب",
                        titleButton: "اضافة جديد",
                        onPress: () {
                          context.navigateToNamed(Routes.addUser);
                        },
                      ),

                      ///
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          children: [
                            Container(
                              width: 230,
                              padding: const EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                  border:
                                      Border.all(color: Colors.black, width: 1),
                                  borderRadius: BorderRadius.circular(10)),
                              child: CustomDropDownWidget(
                                currentValue: typeEducationValue,
                                list: responseDataForLogin!.typeEducations
                                    .map((e) =>
                                        DropdownMenuItem<TypeEducationModel>(
                                            value: e,
                                            child: Text(
                                              e.nameAr,
                                              style: TextStyles
                                                  .textStyleFontBold15black,
                                            )))
                                    .toList(),
                                onSelect: (val) {
                                  typeEducationValue = val;
                                  stageModel = null;
                                  stages = [];
                                  stages = responseDataForLogin!.stages
                                      .where((element) =>
                                          element.typeEducationId ==
                                          typeEducationValue!.id)
                                      .toList();
                                  setState(() {});
                                },
                                hint: 'اختار نوع التعليم',
                              ),
                            ),
                            horizontalSpace(10),
                            Container(
                              width: 230,
                              padding: const EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                  border:
                                      Border.all(color: Colors.black, width: 1),
                                  borderRadius: BorderRadius.circular(10)),
                              child: CustomDropDownWidget(
                                currentValue: stageModel,
                                list: stages
                                    .map((e) => DropdownMenuItem<StageModel>(
                                        value: e,
                                        child: Text(
                                          e.nameAr,
                                          style: TextStyles
                                              .textStyleFontBold15black,
                                        )))
                                    .toList(),
                                onSelect: (val) {
                                  stageModel = val;
                                  classRoomModelValue = null;
                                  classRooms = responseDataForLogin!.classRooms
                                      .where((element) =>
                                          element.stageId == stageModel!.id)
                                      .toList();
                                  setState(() {});
                                },
                                hint: 'اختارالمرحلة التعليمية',
                              ),
                            ),
                            horizontalSpace(10),
                            Container(
                              width: 230,
                              padding: const EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                  border:
                                      Border.all(color: Colors.black, width: 1),
                                  borderRadius: BorderRadius.circular(10)),
                              child: CustomDropDownWidget(
                                currentValue: classRoomModelValue,
                                list: classRooms
                                    .map(
                                        (e) => DropdownMenuItem<ClassRoomModel>(
                                            value: e,
                                            child: Text(
                                              e.nameAr,
                                              style: TextStyles
                                                  .textStyleFontBold15black,
                                            )))
                                    .toList(),
                                onSelect: (val) {
                                  classRoomModelValue = val;
                                  print(classRoomModelValue!.id);
                                  setState(() {});
                                  UsersCubit.get(context).getUsers(
                                      page: 1,
                                      role: ApiConstants.studentRole,
                                      classRoomId: classRoomModelValue!.id);
                                },
                                hint: 'اختار الصف الدراسي',
                              ),
                            ),
                          ],
                        ),
                      ),

                      verticalSpace(10),
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: state.getUsersState == RequestState.loaded
                            ? RecentUsers(
                                users: state.studentsResponse!.items,
                                type: 0,
                              )
                            : const LoadingWidget(),
                      ),
                      verticalSpace(20),
                      PaginationWidget(
                          selectPage: selectPage,
                          totalPages: state.studentsResponse!.totalPages,
                          onChange: (page) {
                            if (selectPage != page) {
                              selectPage = page;
                              UsersCubit.get(context).getUsers(
                                  page: page, role: ApiConstants.studentRole);
                            }
                          })
                    ],
                  ),
                ),
              );
      },
    );
  }
}
