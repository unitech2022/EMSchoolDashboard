import 'package:emschool_dashboard/bloc/lessons_cubit/lessons_cubit.dart';
import 'package:emschool_dashboard/core/widgets/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:get/utils.dart';
import '../../../core/enums/loading_status.dart';
import '../../../core/helpers/helper_functions.dart';
import '../../../core/helpers/reponsiveness.dart';
import '../../../core/helpers/spacing.dart';
import '../../../core/theming/colors.dart';
import '../../../core/theming/styles.dart';

import '../../../core/widgets/custom_button.dart';
import '../../../core/widgets/image_network_widget.dart';
import '../../../core/widgets/text_field_widget.dart';

import '../../../models/lesson_model.dart';


class AddLessonScreen extends StatefulWidget {
  final int unitId, subjectId;
  final bool isUpdate;

  final LessonModel? lessonModel;
  const AddLessonScreen(
      {super.key,
      required this.unitId,
      required this.subjectId,
      this.isUpdate = false,
      this.lessonModel});

  @override
  State<AddLessonScreen> createState() => _AddLessonScreenState();
}

class _AddLessonScreenState extends State<AddLessonScreen> {
 
  final _nameArLessonController = TextEditingController();
  final _nameEngLessonController = TextEditingController();
  final _descArLessonController = TextEditingController();
  final _descEngLessonController = TextEditingController();
  final _linkLessonController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _nameArLessonController.dispose();
    _nameEngLessonController.dispose();
    _descArLessonController.dispose();
    _descEngLessonController.dispose();
    _linkLessonController.dispose();
  }

  @override
  void initState() {
    super.initState();

    if (widget.isUpdate) {
      _descArLessonController.text = widget.lessonModel!.descAr;
      _descEngLessonController.text = widget.lessonModel!.descEng;
      _nameArLessonController.text = widget.lessonModel!.nameAr;
      _nameEngLessonController.text = widget.lessonModel!.nameEng;
      _linkLessonController.text = widget.lessonModel!.linkVidio;
      // LessonsCubit.get(context).unitModel = unitsResponse
      //     .firstWhere((element) => element.id == widget.lessonModel!.unitId);
      // LessonsCubit.get(context).courseModel = widget.courses.firstWhere(
      //     (element) =>
      //         element.id == TeacherCubit.get(context).unitModel!.courseId);

      // LessonsCubit.get(context).getImageLesson(widget.lessonModel!.image);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsApp.mainColor,
      body: Center(
        child: BlocBuilder<LessonsCubit, LessonsState>(
          builder: (context, state) {
            return Card(
              elevation: 10,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              child: Container(
                width: ResponsiveWidget.isSmallScreen(context)
                    ? context.width
                    : 500,
                margin: const EdgeInsets.all(20),
                padding: const EdgeInsets.all(30),
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(10)),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(children: [
                      verticalSpace(10),

                      //================================================================= type and stage

                      // Row(
                      //   children: [
                      //     Container(
                      //       padding: const EdgeInsets.all(5),
                      //       decoration: BoxDecoration(
                      //           border:
                      //               Border.all(color: Colors.black, width: 1),
                      //           borderRadius: BorderRadius.circular(10)),
                      //       child: CustomDropDownWidget(
                      //         currentValue: typeEducationValue,
                      //         list: responseDataForLogin!.typeEducations
                      //             .map((e) =>
                      //                 DropdownMenuItem<TypeEducationModel>(
                      //                     value: e,
                      //                     child: Text(
                      //                       e.nameAr,
                      //                       style: TextStyles
                      //                           .textStyleFontBold15black,
                      //                     )))
                      //             .toList(),
                      //         onSelect: (val) {
                      //           typeEducationValue = val;
                      //           stageModel = null;
                      //           stages = [];
                      //           stages = responseDataForLogin!.stages
                      //               .where((element) =>
                      //                   element.typeEducationId ==
                      //                   typeEducationValue!.id)
                      //               .toList();
                      //           setState(() {});
                      //         },
                      //         hint: 'اختار نوع التعليم',
                      //       ),
                      //     ),
                      //     horizontalSpace(10),
                      //     //================================================================ stage
                      //     Container(
                      //       padding: const EdgeInsets.all(5),
                      //       decoration: BoxDecoration(
                      //           border:
                      //               Border.all(color: Colors.black, width: 1),
                      //           borderRadius: BorderRadius.circular(10)),
                      //       child: CustomDropDownWidget(
                      //         currentValue: stageModel,
                      //         list: stages
                      //             .map((e) => DropdownMenuItem<StageModel>(
                      //                 value: e,
                      //                 child: Text(
                      //                   e.nameAr,
                      //                   style:
                      //                       TextStyles.textStyleFontBold15black,
                      //                 )))
                      //             .toList(),
                      //         onSelect: (val) {
                      //           stageModel = val;
                      //           classRoomModelValue = null;
                      //           classRooms = responseDataForLogin!.classRooms
                      //               .where((element) =>
                      //                   element.stageId == stageModel!.id)
                      //               .toList();
                      //           setState(() {});
                      //         },
                      //         hint: 'اختارالمرحلة التعليمية',
                      //       ),
                      //     ),
                      //   ],
                      // ),

                      // verticalSpace(10),

                      // // =================================================================class and subject
                      // Row(
                      //   children: [
                      //     //================================================================ classRoom
                      //     Container(
                      //       width: 230,
                      //       padding: const EdgeInsets.all(5),
                      //       decoration: BoxDecoration(
                      //           border:
                      //               Border.all(color: Colors.black, width: 1),
                      //           borderRadius: BorderRadius.circular(10)),
                      //       child: CustomDropDownWidget(
                      //         currentValue: classRoomModelValue,
                      //         list: classRooms
                      //             .map((e) => DropdownMenuItem<ClassRoomModel>(
                      //                 value: e,
                      //                 child: Text(
                      //                   e.nameAr,
                      //                   style:
                      //                       TextStyles.textStyleFontBold15black,
                      //                 )))
                      //             .toList(),
                      //         onSelect: (val) {
                      //           classRoomModelValue = val;
                      //           subjectModel = null;
                      //           setState(() {});
                      //           SubjectsCubit.get(context).getSujects(
                      //               page: 1, typeId: classRoomModelValue!.id);
                      //         },
                      //         hint: 'اختار الصف الدراسي',
                      //       ),
                      //     ),

                      //     //================================================================ subjects
                      //     Container(
                      //       width: 230,
                      //       margin: const EdgeInsets.symmetric(horizontal: 20),
                      //       padding: const EdgeInsets.all(5),
                      //       decoration: BoxDecoration(
                      //           border:
                      //               Border.all(color: Colors.black, width: 1),
                      //           borderRadius: BorderRadius.circular(10)),
                      //       child: BlocBuilder<SubjectsCubit, SubjectsState>(
                      //         builder: (context, state) {
                      //           return state.getSubjectsState ==
                      //                   RequestState.loading
                      //               ? const LoadingWidget()
                      //               : CustomDropDownWidget(
                      //                   currentValue: subjectModel,
                      //                   list: state.subjects!.items
                      //                       .map((e) =>
                      //                           DropdownMenuItem<SubjectModel>(
                      //                               value: e,
                      //                               child: Text(
                      //                                 e.nameAr,
                      //                                 style: TextStyles
                      //                                     .textStyleFontBold15black,
                      //                               )))
                      //                       .toList(),
                      //                   onSelect: (val) {
                      //                     subjectModel = val;
                      //                     setState(() {});
                      //                     LessonsCubit.get(context).getLessons(
                      //                         page: 1,
                      //                         typeId: subjectModel!.id);
                      //                   },
                      //                   hint: "اختار المادة",
                      //                 );
                      //         },
                      //       ),
                      //     ),
                      //   ],
                      // ),
                      // //=================================================================  course and unit

                      // Row(
                      //   children: [
                      //     //================================================================ classRoom
                      //     Container(
                      //       width: 230,
                      //       padding: const EdgeInsets.all(5),
                      //       decoration: BoxDecoration(
                      //           border:
                      //               Border.all(color: Colors.black, width: 1),
                      //           borderRadius: BorderRadius.circular(10)),
                      //       child: CustomDropDownWidget(
                      //         currentValue: classRoomModelValue,
                      //         list: classRooms
                      //             .map((e) => DropdownMenuItem<ClassRoomModel>(
                      //                 value: e,
                      //                 child: Text(
                      //                   e.nameAr,
                      //                   style:
                      //                       TextStyles.textStyleFontBold15black,
                      //                 )))
                      //             .toList(),
                      //         onSelect: (val) {
                      //           classRoomModelValue = val;
                      //           subjectModel = null;
                      //           setState(() {});
                      //           SubjectsCubit.get(context).getSujects(
                      //               page: 1, typeId: classRoomModelValue!.id);
                      //         },
                      //         hint: 'اختار الكورس الدراسي',
                      //       ),
                      //     ),

                      //     //================================================================ subjects
                      //     Container(
                      //       width: 230,
                      //       margin: const EdgeInsets.symmetric(horizontal: 20),
                      //       padding: const EdgeInsets.all(5),
                      //       decoration: BoxDecoration(
                      //           border:
                      //               Border.all(color: Colors.black, width: 1),
                      //           borderRadius: BorderRadius.circular(10)),
                      //       child: BlocBuilder<SubjectsCubit, SubjectsState>(
                      //         builder: (context, state) {
                      //           return state.getSubjectsState ==
                      //                   RequestState.loading
                      //               ? const LoadingWidget()
                      //               : CustomDropDownWidget(
                      //                   currentValue: subjectModel,
                      //                   list: state.subjects!.items
                      //                       .map((e) =>
                      //                           DropdownMenuItem<SubjectModel>(
                      //                               value: e,
                      //                               child: Text(
                      //                                 e.nameAr,
                      //                                 style: TextStyles
                      //                                     .textStyleFontBold15black,
                      //                               )))
                      //                       .toList(),
                      //                   onSelect: (val) {
                      //                     subjectModel = val;
                      //                     setState(() {});
                      //                     LessonsCubit.get(context).getLessons(
                      //                         page: 1,
                      //                         typeId: subjectModel!.id);
                      //                   },
                      //                   hint: "اختار المادة",
                      //                 );
                      //         },
                      //       ),
                      //     ),
                      //   ],
                      // ),

                      // name lesson
                      TextFormFieldWidget(
                        isObscureText: false,
                        controller: _nameArLessonController,
                        backgroundColor: Colors.white,
                        hintText: " اسم الدرس باللغة العربية",
                        validator: (val) {},
                      ),

                      // desc lesson
                      verticalSpace(30),
                      TextFormFieldWidget(
                        isObscureText: false,
                          backgroundColor: Colors.white,
                        hintText: " اسم الدرس باللغة الانجليزية",
                        validator: (val) {},
                        controller: _nameEngLessonController,
                      ),

                      verticalSpace(30),
                      TextFormFieldAreaWidget(
                        isObscureText: false,
                          backgroundColor: Colors.white,
                        textInputType: TextInputType.multiline,
                        hintText: "شرح الدرس باللغة العربية",
                        validator: (val) {},
                        controller: _descArLessonController,
                      ),
                      verticalSpace(30),
                      TextFormFieldAreaWidget(
                        textInputType: TextInputType.multiline,
                          backgroundColor: Colors.white,
                        isObscureText: false,
                        hintText: "شرح الدرس باللغة بالانجليزية",
                        validator: (val) {},
                        controller: _descEngLessonController,
                      ),

                      // link
                      verticalSpace(30),
                      TextFormFieldAreaWidget(
                        textInputType: TextInputType.multiline,
                        isObscureText: false,
                          backgroundColor: Colors.white,
                        hintText: "لينك الفيديو",
                        validator: (val) {},
                        controller: _linkLessonController,
                      ),
                      verticalSpace(30),
                      // image lesson

                      GestureDetector(
                        onTap: () async {
                          await LessonsCubit.get(context).uploadImage();
                        },
                        child: Column(
                          children: [
                            Text(
                              state.image == null
                                  ? "اضافة صورة الدرس"
                                  : "تم اضافة الصورة",
                              style: TextStyles.textStyleFontBold20mainColor
                                  .copyWith(
                                      color: state.image == null
                                          ? ColorsApp.mainColor
                                          : Colors.green),
                            ),
                            verticalSpace(10),
                            state.image == null
                                ? const Icon(
                                    Icons.photo,
                                    color: ColorsApp.mainColor,
                                    size: 100,
                                  )
                                : state.uploadImageState == RequestState.loading
                                    ? const LoadingWidget()
                                    : SizedBox(
                                        width: 250,
                                        height: 150,
                                        child: ImageNetworkWidget(
                                          image: state.image!,
                                          width: 250,
                                          height: 150,
                                        ))
                          ],
                        ),
                      ),

                      verticalSpace(40),
                      state.changeDataState == RequestState.loading
                          ? const LoadingWidget()
                          : CustomButton(
                              title: !widget.isUpdate ? "اضافة" : "تعديل",
                              onPressed: () async {
                                if (isValidateCourse(context,
                                    imaLesson: state.image)) {
                                  if (!widget.isUpdate) {
                                    await LessonsCubit.get(context).addLesson(
                                        context: context,
                                        nameAr: _nameArLessonController.text,
                                        nameEng: _nameEngLessonController.text,
                                        descAr: _descArLessonController.text,
                                        descEng: _descEngLessonController.text,
                                        link: _linkLessonController.text,
                                        image: state.image,
                                        subjectId: widget.subjectId,
                                        unitId: widget.unitId);
                                  } else {
                                    await LessonsCubit.get(context)
                                        .updateLesson(
                                            context: context,
                                            nameAr:
                                                _nameArLessonController.text,
                                            nameEng:
                                                _nameEngLessonController.text,
                                            descAr:
                                                _descArLessonController.text,
                                            descEng:
                                                _descEngLessonController.text,
                                            link: _linkLessonController.text,
                                            image: state.image,
                                            id: widget.lessonModel!.id,
                                            unitId: widget.lessonModel!.unitId);
                                  }
                                }
                              })
                    ]),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  bool isValidateCourse(BuildContext context, {imaLesson}) {
    if (_nameArLessonController.text.isEmpty) {
      showToast(msg: "اكتب الاسم باللغة العربية");
      return false;
    } else if (_nameEngLessonController.text.isEmpty) {
      showToast(msg: "اكتب الاسم باللغة الانجليزية");
      return false;
    } else if (_descArLessonController.text.isEmpty) {
      showToast(msg: "اكتب شرح الدرس باللغة العربية");
      return false;
    } else if (_descEngLessonController.text.isEmpty) {
      showToast(msg: "اكتب شرح الدرس باللغة الانجليزية");
      return false;
    } else if (_linkLessonController.text.isEmpty) {
      showToast(msg: "اكتب لينك الفيديو");
      return false;
    } else if (imaLesson == null) {
      showToast(msg: "اختار صورة الدرس");
      return false;
    } else {
      return true;
    }
  }
}
