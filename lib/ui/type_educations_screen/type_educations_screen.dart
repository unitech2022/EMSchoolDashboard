import 'package:emschool_dashboard/bloc/type_educations_cubit/type_educations_cubit.dart';
import 'package:emschool_dashboard/core/enums/loading_status.dart';
import 'package:emschool_dashboard/core/extensions/extensions_routing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/helpers/helper_functions.dart';
import '../../core/helpers/spacing.dart';
import '../../core/theming/styles.dart';
import '../../core/widgets/circular_progress.dart';
import '../../core/widgets/custom_button.dart';
import '../../core/widgets/loading_widget.dart';
import '../../core/widgets/text_field_widget.dart';
import '../../core/widgets/title_widget.dart';
import 'components/tables_type_educations_widget.dart';

class TypeEducationsScreen extends StatefulWidget {
  const TypeEducationsScreen({super.key});

  @override
  State<TypeEducationsScreen> createState() => _TypeEducationsScreenState();
}

class _TypeEducationsScreenState extends State<TypeEducationsScreen> {
  @override
  void initState() {
    super.initState();
    TypeEducationsCubit.get(context)
        .getTypeEducations(page: 1, context: context);
  }

  final _nameArCourseController = TextEditingController();
  final _nameEngCourseController = TextEditingController();
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _nameArCourseController.dispose();
    _nameEngCourseController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TypeEducationsCubit, TypeEducationsState>(
      builder: (context, state) {
        return state.getTypeEducationsStage == RequestState.loading
            ? const LoadingWidget()
            : Scaffold(
                body: SingleChildScrollView(
                  child: Column(
                    children: [
                      verticalSpace(10),
                      TitleWidget(
                        title: "انواع التعليم",
                        titleButton: "اضافة جديد",
                        onPress: () {
                          bottomSheetAddData(context);
                        },
                      ),
                      verticalSpace(10),
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: state.getTypeEducationsStage == RequestState.loaded
                            ? TableTypeEducations(
                                list: state.typeEducations!.items)
                            : const LoadingWidget(),
                      )
                    ],
                  ),
                ),
              );
      },
    );
  }

  void bottomSheetAddData(BuildContext context, {isUpdate = false, id}) {
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
                        controller: _nameArCourseController,
                      ),
                      verticalSpace(20),
                      TextFormFieldWidget(
                        isObscureText: false,
                        backgroundColor: Colors.white,
                        hintText: " الاسم باللغة الانجليزية",
                        validator: (val) {},
                        controller: _nameEngCourseController,
                      ),
                      verticalSpace(20),
                      state.addTypeEducationState == RequestState.loading
                          ? const CustomCircularProgress()
                          : CustomButton(
                              title: isUpdate ? "تعديل" : "اضافة",
                              onPressed: () {
                                if (isValidateCourse(context)) {
                                  if (isUpdate) {
                                    TypeEducationsCubit.get(context)
                                        .updateTypeEducation(
                                            id: id,
                                            context: context,
                                            nameAr:
                                                _nameArCourseController.text,
                                            nameEng:
                                                _nameEngCourseController.text);
                                  } else {
                                    TypeEducationsCubit.get(context)
                                        .addTypeEducation(
                                            context: context,
                                            nameAr:
                                                _nameArCourseController.text,
                                            nameEng:
                                                _nameEngCourseController.text);
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
