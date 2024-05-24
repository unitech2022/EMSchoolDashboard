
import 'package:emschool_dashboard/bloc/subjects_cubit/subjects_cubit.dart';
import 'package:emschool_dashboard/core/enums/loading_status.dart';
import 'package:emschool_dashboard/core/extensions/extensions_routing.dart';
import 'package:emschool_dashboard/core/routing/routes.dart';
import 'package:emschool_dashboard/ui/subjects_screen/components/sujects_table.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/helpers/spacing.dart';
import '../../core/theming/styles.dart';
import '../../core/utlis/app_model.dart';
import '../../core/widgets/drop_dwon_widget.dart';
import '../../core/widgets/loading_widget.dart';
import '../../core/widgets/title_widget.dart';
import '../../models/class_room_model.dart';
import '../../models/stage_model.dart';
import '../../models/type_education_model.dart';

class SubbjectsScreen extends StatefulWidget {
  const SubbjectsScreen({super.key});

  @override
  State<SubbjectsScreen> createState() => _SubbjectsScreenState();
}

class _SubbjectsScreenState extends State<SubbjectsScreen> {
  TypeEducationModel? typeEducationValue;
  StageModel? stageModel;

  List<StageModel> stages = [];
  ClassRoomModel? classRoomModelValue;
  List<ClassRoomModel> classRooms = [];

  @override
  void initState() {
    super.initState();
    SubjectsCubit.get(context).getSujects(page: 1, typeId: 0, context: context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
          body: SingleChildScrollView(
            child: Column(
              children: [
                verticalSpace(10),
                TitleWidget(
                  title: "المواد الدراسية",
                  titleButton: "اضافة جديد",
                  onPress: () {
                    context.navigateToNamed(Routes.addSubbject);
                  },
                ),
                verticalSpace(10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    children: [
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
                            SubjectsCubit.get(context).getSujects(
                                page: 1, typeId: classRoomModelValue!.id);
                          },
                          hint: 'اختار الصف الدراسي',
                        ),
                      ),
                             
                  ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: BlocBuilder<SubjectsCubit, SubjectsState>(
                    builder: (context, state) {
                      return state.getSubjectsState == RequestState.loaded
                          ? SubjectsTable(users: state.subjects!.items,)
                          : const LoadingWidget();
                    },
                  ),
                )
              ],
            ),
          ),
        );
    
  }
}
