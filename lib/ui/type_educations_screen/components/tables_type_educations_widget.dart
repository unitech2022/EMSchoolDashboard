import 'package:emschool_dashboard/bloc/type_educations_cubit/type_educations_cubit.dart';
import 'package:emschool_dashboard/core/helpers/spacing.dart';
import 'package:emschool_dashboard/core/theming/colors.dart';
import 'package:emschool_dashboard/core/theming/styles.dart';
import 'package:emschool_dashboard/core/widgets/loading_widget.dart';
import 'package:emschool_dashboard/models/type_education_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/utils.dart';

import '../../../core/enums/loading_status.dart';
import '../../../core/helpers/helper_functions.dart';
import '../../../core/widgets/custom_button.dart';
import '../../../core/widgets/text_field_widget.dart';

class TableTypeEducations extends StatefulWidget {
  final List<TypeEducationModel> list;

  const TableTypeEducations({super.key, required this.list});

  @override
  State<TableTypeEducations> createState() => _TableTypeEducationsState();
}

class _TableTypeEducationsState extends State<TableTypeEducations> {
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    // _nameArCourseController.dispose();
    // _nameEngCourseController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: const BoxDecoration(
        color: ColorsApp.mainColor,
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: SizedBox(
        width: double.infinity,
        child: DataTable(
          horizontalMargin: 20,
          columnSpacing: 20,
          columns: [
            DataColumn(
              label: Text(
                "ID",
                style: TextStyles.textStyleFontBold12whit,
              ),
            ),
            DataColumn(
              label: Text("الاسم باللغة العربية",
                  style: TextStyles.textStyleFontBold12whit),
            ),
            DataColumn(
              label: Text("الاسم باللغة الانجليزية",
                  style: TextStyles.textStyleFontBold12whit),
            ),
            DataColumn(
              label: Text("الفعل", style: TextStyles.textStyleFontBold12whit),
            ),
          ],
          rows: List.generate(
            widget.list.length,
            (index) => recentTypeEducationDataRow(widget.list[index], context),
          ),
        ),
      ),
    );
  }

  DataRow recentTypeEducationDataRow(
      TypeEducationModel model, BuildContext context) {
    return DataRow(
      cells: [
        DataCell(
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              model.id.toString(),
              maxLines: 1,
              style: TextStyles.textStyleFontMeduim12White,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
        DataCell(
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              model.nameAr,
              maxLines: 1,
              style: TextStyles.textStyleFontMeduim12White,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
        DataCell(Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              model.nameEng,
              maxLines: 1,
              style: TextStyles.textStyleFontMeduim12White,
              overflow: TextOverflow.ellipsis,
            ))),
        DataCell(
          Row(
            children: [
              TextButton(
                child:
                    const Text('تعديل', style: TextStyle(color: Colors.green)),
                onPressed: () {
                  // _nameArCourseController.text = model.nameAr;
                  // _nameEngCourseController.text = model.nameEng;
                  bottomSheetAddData(context, model: model, isUpdate: true);
                },
              ),
              const SizedBox(
                width: 6,
              ),
              TextButton(
                child: const Text("حذف",
                    style: TextStyle(color: Colors.redAccent)),
                onPressed: () {
                  dailogDeleteData(
                      context: context,
                      onCancel: () {
                        pop(context);
                      },
                      onDelete: () {
                        pop(context);
                        TypeEducationsCubit.get(context).deleteTypeEducation(
                            context: context, id: model.id);
                      },
                      value: model.nameAr);
                },
                // Delete
              ),
            ],
          ),
        ),
      ],
    );
  }

// ================================================================= update
  void bottomSheetAddData(BuildContext context, {isUpdate = false, model}) {
    TextEditingController nameArCourseController = TextEditingController();
    TextEditingController nameEngCourseController = TextEditingController();
    nameArCourseController.text = model.nameAr;
    nameEngCourseController.text = model.nameEng;
    return showBottomSheetWidget(context,
        BlocBuilder<TypeEducationsCubit, TypeEducationsState>(
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
                        isUpdate ? "تعديل" : "اضافة",
                        style: TextStyles.textStyleFontBold22Black,
                      ),
                      const Spacer()
                    ],
                  ),
                  verticalSpace(10),
                  // body ======================================================================

                  Column(
                    children: [
                      TextFormFieldWidget(
                        isObscureText: false,
                        backgroundColor: Colors.white,
                        hintText: "الاسم باللغة العربية",
                        validator: (val) {},
                        controller: nameArCourseController,
                      ),
                      verticalSpace(20),
                      TextFormFieldWidget(
                        isObscureText: false,
                        backgroundColor: Colors.white,
                        hintText: " الاسم باللغة الانجليزية",
                        validator: (val) {},
                        controller: nameEngCourseController,
                      ),
                      verticalSpace(20),
                      state.addTypeEducationState == RequestState.loading
                          ? const LoadingWidget()
                          : CustomButton(
                              title: isUpdate ? "تعديل" : "اضافة",
                              onPressed: () {
                                if (isValidateCourse(
                                    context,
                                    nameArCourseController,
                                    nameEngCourseController)) {
                                  if (isUpdate) {
                                    TypeEducationsCubit.get(context)
                                        .updateTypeEducation(
                                            id: model.id,
                                            context: context,
                                            nameAr: nameArCourseController.text,
                                            nameEng:
                                                nameEngCourseController.text);
                                  } else {
                                    TypeEducationsCubit.get(context)
                                        .addTypeEducation(
                                            context: context,
                                            nameAr: nameArCourseController.text,
                                            nameEng:
                                                nameEngCourseController.text);
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

  bool isValidateCourse(BuildContext context, conNameAr, conNameEng) {
    if (conNameAr.text.isEmpty) {
      showToast(msg: "اكتب الاسم باللغة العربية");
      return false;
    } else if (conNameEng.text.isEmpty) {
      showToast(msg: "اكتب الاسم باللغة الانجليزية");
      return false;
    } else {
      return true;
    }
  }
}
