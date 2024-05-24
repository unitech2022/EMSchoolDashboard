import 'package:emschool_dashboard/bloc/schedules_cubit/schedules_cubit.dart';
import 'package:emschool_dashboard/core/extensions/extensions_routing.dart';
import 'package:emschool_dashboard/ui/schedules_screen/table_schedules.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/enums/loading_status.dart';
import '../../core/helpers/spacing.dart';
import '../../core/routing/routes.dart';
import '../../core/theming/styles.dart';
import '../../core/utlis/app_model.dart';
import '../../core/widgets/drop_dwon_widget.dart';
import '../../core/widgets/loading_widget.dart';
import '../../core/widgets/title_widget.dart';
import '../../models/class_room_model.dart';
import '../../models/stage_model.dart';
import '../../models/subject_model.dart';
import '../../models/type_education_model.dart';

class SchedulesScreen extends StatefulWidget {
  const SchedulesScreen({super.key});

  @override
  State<SchedulesScreen> createState() => _SchedulesScreenState();
}

class _SchedulesScreenState extends State<SchedulesScreen> {
  TypeEducationModel? typeEducationValue;
  StageModel? stageModel;
  SubjectModel? subjectModel;
  List<StageModel> stages = [];
  ClassRoomModel? classRoomModelValue;
  List<ClassRoomModel> classRooms = [];
  List<SubjectModel> subjects = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    SchedulesCubit.get(context)
        .getSchedulesByClassId(classId: 0, context: context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              verticalSpace(10),
              TitleWidget(
                title: "الجداول",
                titleButton: "اضافة جديد",
                isButton: true,
                onPress: () {
                 context.navigateToNamed(Routes.addScheduls);
                },
              ),
              verticalSpace(10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    //================================================================ type education
                    Container(
                      width: 230,
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black, width: 1),
                          borderRadius: BorderRadius.circular(10)),
                      child: CustomDropDownWidget(
                        currentValue: typeEducationValue,
                        list: responseDataForLogin!.typeEducations
                            .map((e) => DropdownMenuItem<TypeEducationModel>(
                                value: e,
                                child: Text(
                                  e.nameAr,
                                  style: TextStyles.textStyleFontBold15black,
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
                    //================================================================ stage
                    Container(
                      width: 230,
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black, width: 1),
                          borderRadius: BorderRadius.circular(10)),
                      child: CustomDropDownWidget(
                        currentValue: stageModel,
                        list: stages
                            .map((e) => DropdownMenuItem<StageModel>(
                                value: e,
                                child: Text(
                                  e.nameAr,
                                  style: TextStyles.textStyleFontBold15black,
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
                    //================================================================ classRoom
                    Container(
                      width: 230,
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black, width: 1),
                          borderRadius: BorderRadius.circular(10)),
                      child: CustomDropDownWidget(
                        currentValue: classRoomModelValue,
                        list: classRooms
                            .map((e) => DropdownMenuItem<ClassRoomModel>(
                                value: e,
                                child: Text(
                                  e.nameAr,
                                  style: TextStyles.textStyleFontBold15black,
                                )))
                            .toList(),
                        onSelect: (val) {
                          classRoomModelValue = val;

                          setState(() {});
                          SchedulesCubit.get(context).getSchedulesByClassId(
                              classId: classRoomModelValue!.id,
                              context: context);
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
                child: BlocBuilder<SchedulesCubit, SchedulesState>(
                  builder: (context, state) {
                    return state.getSchedulesState == RequestState.loaded
                        ? TableSchedules(list: state.schedulesResponse!)
                        : const LoadingWidget();
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
