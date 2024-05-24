import 'package:emschool_dashboard/bloc/lessons_cubit/lessons_cubit.dart';
import 'package:emschool_dashboard/bloc/subjects_cubit/subjects_cubit.dart';
import 'package:emschool_dashboard/core/enums/loading_status.dart';
import 'package:emschool_dashboard/core/widgets/loading_widget.dart';
import 'package:emschool_dashboard/models/subject_model.dart';
import 'package:emschool_dashboard/ui/lessons_screen/components/lessonse_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/helpers/spacing.dart';
import '../../core/theming/styles.dart';
import '../../core/utlis/app_model.dart';
import '../../core/widgets/drop_dwon_widget.dart';
import '../../core/widgets/title_widget.dart';
import '../../models/class_room_model.dart';
import '../../models/stage_model.dart';
import '../../models/type_education_model.dart';

class LessonsScreen extends StatefulWidget {
  const LessonsScreen({super.key});

  @override
  State<LessonsScreen> createState() => _LessonsScreenState();
}

class _LessonsScreenState extends State<LessonsScreen> {
  TypeEducationModel? typeEducationValue;
  StageModel? stageModel;
  SubjectModel? subjectModel;
  List<StageModel> stages = [];
  ClassRoomModel? classRoomModelValue;
  List<ClassRoomModel> classRooms = [];
  List<SubjectModel> subjects = [];

  // data of lessons

  @override
  void initState() {
    super.initState();
    LessonsCubit.get(context).getLessons(page: 1, typeId: 0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            verticalSpace(10),
            TitleWidget(
              title: "الدروس",
              titleButton: "اضافة جديد",
              isButton: false,
              onPress: () {

                // context.navigateToNamed(Routes.addSubbject);
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
                            .where(
                                (element) => element.stageId == stageModel!.id)
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
                        subjectModel = null;
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
            verticalSpace(10),

            //================================================================ subjects
            Row(
              children: [
                Container(
                  width: 230,
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black, width: 1),
                      borderRadius: BorderRadius.circular(10)),
                  child: BlocBuilder<SubjectsCubit, SubjectsState>(
                    builder: (context, state) {
                      return state.getSubjectsState == RequestState.loading
                          ? const LoadingWidget()
                          : CustomDropDownWidget(
                              currentValue: subjectModel,
                              list: state.subjects!.items
                                  .map((e) => DropdownMenuItem<SubjectModel>(
                                      value: e,
                                      child: Text(
                                        e.nameAr,
                                        style:
                                            TextStyles.textStyleFontBold15black,
                                      )))
                                  .toList(),
                              onSelect: (val) {
                                subjectModel = val;
                                setState(() {});
                                LessonsCubit.get(context).getLessons(
                                    page: 1, typeId: subjectModel!.id);
                              },
                              hint: "اختار المادة",
                            );
                    },
                  ),
                ),
              ],
            ),

            BlocBuilder<LessonsCubit, LessonsState>(
              builder: (context, state) {
                return state.getLessonsState==RequestState.loaded? Padding(
                    padding: const EdgeInsets.all(10.0),
                    child:subjectModel==null?const SizedBox(): LessonsWidget(
                      subjectId: subjectModel!.id ,
                    )):const LoadingWidget();
              },
            )
          ],
        ),
      ),
    );
  }
}
