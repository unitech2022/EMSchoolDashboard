import 'package:emschool_dashboard/bloc/lessons_cubit/lessons_cubit.dart';
import 'package:emschool_dashboard/core/extensions/extensions_routing.dart';
import 'package:emschool_dashboard/core/helpers/spacing.dart';
import 'package:emschool_dashboard/core/widgets/loading_widget.dart';
import 'package:emschool_dashboard/ui/lessons_screen/add_lesson_screen/add_lesson_screen.dart';
import 'package:emschool_dashboard/ui/lessons_screen/add_unit_screenn/add_unit_screenn.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/enums/loading_status.dart';
import '../../../core/helpers/helper_functions.dart';
import '../../../core/theming/colors.dart';
import '../../../core/theming/styles.dart';
import '../../../core/widgets/custom_button.dart';
import '../../../core/widgets/text_field_widget.dart';
import '../../../models/course_model.dart';
import '../../../models/lesson_model.dart';
import '../../../models/unit_model.dart';

class LessonsWidget extends StatefulWidget {
  final int subjectId;

  const LessonsWidget({super.key, required this.subjectId});

  @override
  State<LessonsWidget> createState() => _LessonsWidgetState();
}

class _LessonsWidgetState extends State<LessonsWidget> {
  bool expanded = false;
  int? currentIndexCourse = 0;
  final _nameArCourseController = TextEditingController();
  final _nameEngCourseController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LessonsCubit, LessonsState>(
      builder: (contextbloc, state) {
        return Card(
          elevation: 10,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  verticalSpace(25),
                  //  ================================================================= courses
                  LessonsCubit.get(context).couses.isEmpty
                      ? AddNewDataWidget(
                          title: "اضافة كورس",
                          padding: 5,
                          onTap: () {
                            bottomSheetUpdateCourse(context,
                                subjectId: widget.subjectId);
                          },
                        )
                      : ExpansionTile(
                          key: GlobalKey(),
                          childrenPadding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 5),
                          tilePadding: EdgeInsets.zero,
                          initiallyExpanded: expanded,
                          onExpansionChanged: (value) {
                            expanded = value;
                          },
                          collapsedBackgroundColor: Colors.transparent,
                          collapsedIconColor: Colors.black,
                          title: Text(
                            LessonsCubit.get(contextbloc)
                                .couses[currentIndexCourse!]
                                .nameAr,
                            style: TextStyles.textStyleFontBold20mainColor,
                          ),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15)),
                          children: List.generate(
                              LessonsCubit.get(context).couses.length + 1,
                              (index) {
                            // CourseModel e =
                            //     LessonsCubit.get(contextbloc).couses[index];

                            if (index ==
                                LessonsCubit.get(context).couses.length) {
                              return AddNewDataWidget(
                                title: "اضافة كورس",
                                onTap: () {
                                  bottomSheetUpdateCourse(context,
                                      subjectId: widget.subjectId);
                                },
                              );
                            }
                            CourseModel courseModel =
                                LessonsCubit.get(contextbloc).couses[index];
                            return Container(
                              padding: const EdgeInsets.symmetric(vertical: 5),
                              decoration: const BoxDecoration(
                                  border: Border(
                                      bottom: BorderSide(
                                          color: Colors.black, width: .5))),
                              child: ListTile(
                                contentPadding:
                                    const EdgeInsets.symmetric(vertical: 5),
                                visualDensity: const VisualDensity(
                                    horizontal: 0, vertical: -4),
                                minVerticalPadding: 0.0,
                                onTap: () {
                                  setState(() {
                                    expanded = !expanded;
                                    currentIndexCourse = index;
                                  });
                                  LessonsCubit.get(contextbloc)
                                      .sortList(courseModel.id);
                                },
                                title: Text(
                                  courseModel.nameAr,
                                  style: TextStyles.textStyleFontMeduim20Black,
                                ),

                                trailing: RowEditorWidget(
                                  onUpdate: () {
                                    _nameArCourseController.text =
                                        courseModel.nameAr;
                                    _nameEngCourseController.text =
                                        courseModel.nameEng;
                                    bottomSheetUpdateCourse(context,
                                        isUpdate: true,
                                        courseId: courseModel.id);
                                  },
                                  onDelete: () {
                                    dailogDeleteData(
                                        context: contextbloc,
                                        value: courseModel.nameAr,
                                        onCancel: () => pop(context),
                                        onDelete: () {
                                          pop(context);
                                          LessonsCubit.get(contextbloc)
                                              .deleteCourse(
                                                  context: context,
                                                  courseId: courseModel.id);
                                        });
                                  },
                                ),
                                // trailing: Icon(
                                //   Icons.check,
                                //   color: currentCourse == null ||
                                //           currentCourse!.id != e.id
                                //       ? Colors.transparent
                                //       : Colors.green,
                                // ),
                              ),
                            );
                          }).toList(),
                        ),
                  verticalSpace(20),
                  // =================================================================
                  LessonsCubit.get(context).couses.isEmpty
                      ? const SizedBox()
                      : LessonsListWidget(
                          courseId: LessonsCubit.get(context)
                              .couses[currentIndexCourse!]
                              .id,
                          subjectId: widget.subjectId,
                          list: LessonsCubit.get(contextbloc).units),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void bottomSheetUpdateCourse(BuildContext context,
      {courseId, subjectId, isUpdate = false}) {
    return showBottomSheetWidget(context,
        BlocBuilder<LessonsCubit, LessonsState>(
      builder: (contextBloc, state) {
        return StatefulBuilder(
          builder: (BuildContext context,
              void Function(void Function()) setStateSheet) {
            return Container(
              padding: const EdgeInsets.only(
                  top: 40, left: 30, right: 30, bottom: 20),
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15))),
              height: context.height / 2,
              width: double.infinity,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // icon back
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(
                          Icons.close,
                          color: Colors.black,
                        ),
                        onPressed: () {
                          pop(context);
                        },
                      ),
                      const Spacer(),
                      Text(
                        "اضافة",
                        style: TextStyles.textStyleFontMeduim20Black,
                      ),
                      const Spacer()
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  // body ======================================================================

                  Column(
                    children: [
                      TextFormFieldWidget(
                        isObscureText: false,
                        backgroundColor: Colors.white,
                        hintText: " اسم الكورس باللغة العربية",
                        validator: (val) {},
                        controller: _nameArCourseController,
                      ),
                      verticalSpace(20),
                      TextFormFieldWidget(
                        isObscureText: false,
                        backgroundColor: Colors.white,
                        hintText: " اسم الكورس باللغة الانجليزية",
                        validator: (val) {},
                        controller: _nameEngCourseController,
                      ),
                      verticalSpace(20),
                      state.changeDataState == RequestState.loading
                          ? const LoadingWidget()
                          : CustomButton(
                              title: isUpdate ? "تعديل" : "اضافة",
                              onPressed: () {
                                if (isValidateCourse(context)) {
                                  if (isUpdate) {
                                    LessonsCubit.get(context).updateCourse(
                                        context: context,
                                        courseId: courseId,
                                        nameAr: _nameArCourseController.text,
                                        nameEng: _nameEngCourseController.text);
                                  } else {
                                    LessonsCubit.get(context).addCourse(
                                        context: context,
                                        subjectId: subjectId,
                                        nameAr: _nameArCourseController.text,
                                        nameEng: _nameEngCourseController.text);
                                  }
                                }
                              })
                    ],
                  )
                ],
              ),
            );
          },
        );
      },
    ));
  }

  bool isValidateCourse(BuildContext context) {
    if (_nameArCourseController.text.isEmpty) {
      showToast(msg: "اكتب الاسم باللغة العربية");
      return false;
    } else if (_nameEngCourseController.text.isEmpty) {
      showToast(msg: "اكتب الاسم باللغة الانجليزية");
      return false;
    } else {
      return true;
    }
  }
}

class AddNewDataWidget extends StatelessWidget {
  final String title;
  final void Function() onTap;
  final Color? textColor;
  final double padding;

  const AddNewDataWidget(
      {super.key,
      required this.title,
      required this.onTap,
      this.padding = 12,
      this.textColor});

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: onTap,
        child: Padding(
          padding: EdgeInsets.all(padding),
          child: Row(
            children: [
              Icon(
                Icons.add,
                color: textColor ?? Colors.green,
              ),
              Text(
                title,
                style: TextStyles.textStyleFontBold15Green.copyWith(
                  color: textColor ?? Colors.green,
                ),
              )
            ],
          ),
        ));
  }
}

class LessonsListWidget extends StatelessWidget {
  final int courseId, subjectId;
  final List<UnitResponse> list;
  const LessonsListWidget(
      {super.key,
      required this.list,
      required this.courseId,
      required this.subjectId});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LessonsCubit, LessonsState>(
      builder: (context, state) {
        // ================================================================= units
        return list.isEmpty
            ? AddNewDataWidget(
                title: "اضافة وحدة",
                padding: 0,
                textColor: Colors.blueAccent,
                onTap: () {
                  context.navigatePush(AddUnitScreen(
                    courseId: courseId,
                  ));
                },
              )
            : ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: list.length + 1,
                itemBuilder: (ctx, index) {
                  if (index == list.length) {
                    return AddNewDataWidget(
                      title: "اضافة وحدة",
                      padding: 5,
                      textColor: Colors.blueAccent,
                      onTap: () {
                        context.navigatePush(AddUnitScreen(
                          courseId: courseId,
                        ));
                      },
                    );
                  }
                  UnitResponse model = list[index];
                  return Container(
                      margin: const EdgeInsets.only(bottom: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      //================================================================ LESSONS
                      child: ExpansionTile(
                          key: GlobalKey(),
                          trailing: Container(
                              height: 40,
                              width: 40,
                              decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Color(0xff36545b)),
                              child: const Icon(Icons.add)),
                          childrenPadding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 5),
                          tilePadding: EdgeInsets.zero,
                          onExpansionChanged: (value) {},
                          collapsedIconColor: Colors.white,
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                model.unitModel.nameAr,
                                style: TextStyles.textStyleFontBold20green,
                              ),
                              horizontalSpace(20),
                              RowEditorWidget(
                                onUpdate: () {
                                  context.navigatePush(AddUnitScreen(
                                    courseId: courseId,
                                    unitModel: model.unitModel,
                                    isUpdate: true,
                                  ));
                                },
                                onDelete: () {
                                  dailogDeleteData(
                                      context: context,
                                      value: model.unitModel.nameAr,
                                      onCancel: () => pop(context),
                                      onDelete: () {
                                        pop(context);
                                        LessonsCubit.get(context).deleteUnite(
                                            context: context,
                                            unitId: model.unitModel.id);
                                      });
                                },
                              )
                            ],
                          ),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15)),
                          children:
                              List.generate(model.lessons.length + 1, (index) {
                            if (index == model.lessons.length) {
                              return AddNewDataWidget(
                                title: "اضافة درس",
                                padding: 5,
                                textColor: Colors.blueAccent,
                                onTap: () {
                                  context.navigatePush(AddLessonScreen(
                                    unitId: model.unitModel.id,
                                    subjectId: subjectId,
                                  ));
                                },
                              );
                            }
                            return SizedBox(
                              height: 70,
                              width: context.width,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Container(
                                              height: 20,
                                              width: 20,
                                              alignment: Alignment.center,
                                              decoration: const BoxDecoration(
                                                color: ColorsApp.blueColor,
                                                shape: BoxShape.circle,
                                              ),
                                              child: Container(
                                                height: 5,
                                                width: 5,
                                                decoration: const BoxDecoration(
                                                  color: Colors.white,
                                                  shape: BoxShape.circle,
                                                ),
                                              )),
                                          index == model.lessons.length - 1
                                              ? const SizedBox()
                                              : Container(
                                                  height: 45,
                                                  width: 3,
                                                  color: ColorsApp.blueColor,
                                                ),
                                        ],
                                      ),
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Expanded(
                                                child: Text(
                                                    model.lessons[index].nameAr,
                                                    style: TextStyles
                                                        .textStyleFontMeduim20Black),
                                              ),
                                              RowEditorWidget(
                                                onUpdate: () {
                                                  context.navigatePush(
                                                      AddLessonScreen(
                                                    unitId: model.unitModel.id,
                                                    subjectId: subjectId,
                                                    isUpdate: true,
                                                    lessonModel:
                                                        model.lessons[index],
                                                  ));
                                                },
                                                onDelete: () {
                                                  dailogDeleteData(
                                                      context: context,
                                                      value: model
                                                          .lessons[index]
                                                          .nameAr,
                                                      onCancel: () =>
                                                          pop(context),
                                                      onDelete: () {
                                                        pop(context);
                                                        LessonsCubit.get(
                                                                context)
                                                            .deleteLesson(
                                                                context:
                                                                    context,
                                                                lessonId: model
                                                                    .lessons[
                                                                        index]
                                                                    .id);
                                                      });
                                                },
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            );
                          }).toList()));
                });
      },
    );
  }
}

class RowEditorWidget extends StatelessWidget {
  final void Function() onUpdate;
  final void Function() onDelete;
  const RowEditorWidget({
    super.key,
    required this.onUpdate,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        TextButton(
            onPressed: onUpdate,
            child: Text(
              "تعديل",
              style: TextStyles.textStyleFontBold14Blue,
            )),
        TextButton(
            onPressed: onDelete,
            child: Text(
              "حذف",
              style: TextStyles.textStyleFontBold14Blue
                  .copyWith(color: Colors.red),
            )),
      ],
    );
  }
}

class ItemLessonWidget extends StatelessWidget {
  final List<LessonModel> lessons;

  const ItemLessonWidget({super.key, required this.lessons});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LessonsCubit, LessonsState>(
      builder: (context, state) {
        return ListView(
          shrinkWrap: true,
          children: lessons
              .map((e) => SizedBox(
                    height: 70,
                    width: context.width,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                    height: 20,
                                    width: 20,
                                    alignment: Alignment.center,
                                    decoration: const BoxDecoration(
                                      color: ColorsApp.blueColor,
                                      shape: BoxShape.circle,
                                    ),
                                    child: Container(
                                      height: 5,
                                      width: 5,
                                      decoration: const BoxDecoration(
                                        color: Colors.white,
                                        shape: BoxShape.circle,
                                      ),
                                    )),
                                e == lessons.elementAt(lessons.length - 1)
                                    ? const SizedBox()
                                    : Container(
                                        height: 45,
                                        width: 3,
                                        color: ColorsApp.blueColor,
                                      ),
                              ],
                            ),
                            Expanded(
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: Text(e.nameAr,
                                          style: TextStyles
                                              .textStyleFontMeduim20Black),
                                    ),
                                    RowEditorWidget(
                                      onUpdate: () {
                                        // context.navigatePush(AddLessonScreen(
                                        //     courses: state
                                        //         .homeTeacherResponse!.courses,
                                        //     units: state.homeTeacherResponse!
                                        //         .unitResponses,
                                        //         lessonModel:e));
                                      },
                                      onDelete: () {
                                        dailogDeleteData(
                                            context: context,
                                            value: e.nameAr,
                                            onCancel: () => pop(context),
                                            onDelete: () {
                                              pop(context);
                                              LessonsCubit.get(context)
                                                  .deleteLesson(
                                                      context: context,
                                                      lessonId: e.id);
                                            });
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ))
              .toList(),
        );
      },
    );
  }
}
