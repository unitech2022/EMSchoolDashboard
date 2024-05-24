import 'package:emschool_dashboard/bloc/lessons_cubit/lessons_cubit.dart';
import 'package:emschool_dashboard/core/enums/loading_status.dart';
import 'package:emschool_dashboard/core/extensions/extensions_routing.dart';
import 'package:emschool_dashboard/core/helpers/helper_functions.dart';
import 'package:emschool_dashboard/core/helpers/reponsiveness.dart';
import 'package:emschool_dashboard/core/helpers/spacing.dart';
import 'package:emschool_dashboard/core/theming/colors.dart';
import 'package:emschool_dashboard/core/widgets/custom_button.dart';
import 'package:emschool_dashboard/core/widgets/loading_widget.dart';
import 'package:emschool_dashboard/core/widgets/text_field_widget.dart';
import 'package:emschool_dashboard/models/unit_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddUnitScreen extends StatefulWidget {
  final bool isUpdate;
  final int courseId;
  final UnitModel? unitModel;
  const AddUnitScreen(
      {super.key, required this.courseId, this.isUpdate = false,this.unitModel});

  @override
  State<AddUnitScreen> createState() => _AddUnitScreenState();
}

class _AddUnitScreenState extends State<AddUnitScreen> {
  final _nameArController = TextEditingController();
  final _nameEngController = TextEditingController();



  @override
  void initState() {
    super.initState();
    if (widget.isUpdate) {
     
      _nameArController.text = widget.unitModel!.nameAr;
      _nameEngController.text = widget.unitModel!.nameEng;
   
    }
  }

  @override
  void dispose() {
    super.dispose();
    _nameArController.dispose();
    _nameEngController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsApp.mainColor,
      body: BlocBuilder<LessonsCubit, LessonsState>(
        builder: (context, state) {
          return Center(
              child: SingleChildScrollView(
                child: Card(
                  elevation: 10,
                  shape:
                      RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  child: Container(
                    width:
                        ResponsiveWidget.isSmallScreen(context) ? context.width : 500,
                    margin: const EdgeInsets.all(20),
                    padding: const EdgeInsets.all(30),
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(10)),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // type Education
      
                        verticalSpace(30),
                        TextFormFieldWidget(
                          isObscureText: false,
                          controller: _nameArController,
                          hintText: " اسم الوحدة باللغة العربية",
                          validator: (val) {},
                             backgroundColor: Colors.white
                        ),
                        verticalSpace(30),
                        TextFormFieldWidget(
                          isObscureText: false,
                          hintText: " اسم الوحدة باللغة الانجليزية",
                          validator: (val) {},
                          backgroundColor: Colors.white,
                          controller: _nameEngController,
                        ),
      
                        verticalSpace(20),
      
                      state.changeDataState==RequestState.loading?const LoadingWidget():  CustomButton(
                            title: widget.isUpdate ?"تعديل" :  "انشاء" ,
                            onPressed: () {
                              if (isValidate(context: context)) {
                                LessonsCubit.get(context).addUnit(
                                    context: context,
                                    courseId: widget.courseId,
                                    nameAr: _nameArController.text,
                                    nameEng: _nameEngController.text);
                              }else {
                                   LessonsCubit.get(context).updateUnit(
                                    context: context,
                                    id: widget.unitModel!.id,
                                    courseId: widget.courseId,
                                    nameAr: _nameArController.text,
                                    nameEng: _nameEngController.text);
                              }
                            })
                      ],
                    ),
                  ),
                ),
              ),
            );
        },
      ),
    );
  }

  bool isValidate({context}) {
    if (_nameArController.text.isEmpty || _nameArController.text == "") {
      showToast(msg: "اكتب الاسم باللغة العربية", color: Colors.red);
      return false;
    } else if (_nameEngController.text.isEmpty ||
        _nameEngController.text == "") {
      showToast(msg: "اكتب الاسم باللغة الانجليزية", color: Colors.red);
      return false;
    } else {
      return true;
    }
  }
}
