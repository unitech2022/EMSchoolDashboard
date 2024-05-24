import 'package:emschool_dashboard/bloc/stages_cubit/stages_cubit.dart';
import 'package:emschool_dashboard/core/extensions/extensions_routing.dart';
import 'package:emschool_dashboard/core/helpers/helper_functions.dart';
import 'package:emschool_dashboard/core/helpers/reponsiveness.dart';
import 'package:emschool_dashboard/core/helpers/spacing.dart';
import 'package:emschool_dashboard/core/theming/colors.dart';
import 'package:emschool_dashboard/core/theming/styles.dart';
import 'package:emschool_dashboard/core/utlis/app_model.dart';
import 'package:emschool_dashboard/core/widgets/custom_button.dart';
import 'package:emschool_dashboard/core/widgets/text_field_widget.dart';
import 'package:emschool_dashboard/models/stage_model.dart';
import 'package:emschool_dashboard/models/type_education_model.dart';
import 'package:flutter/material.dart';
import '../../../core/widgets/drop_dwon_widget.dart';

class AddStageScreen extends StatefulWidget {
  final bool isUpdate;
  final StageModel? model;
  const AddStageScreen({super.key, this.isUpdate = false, this.model});

  @override
  State<AddStageScreen> createState() => _AddStageScreenState();
}

class _AddStageScreenState extends State<AddStageScreen> {
  final _nameArController = TextEditingController();
  final _nameEngController = TextEditingController();

  TypeEducationModel? typeEducationValue;

  @override
  void initState() {
    super.initState();
    if (widget.isUpdate) {
      typeEducationValue = responseDataForLogin!.typeEducations
          .firstWhere((element) => element.id == widget.model!.typeEducationId);

      _nameArController.text = widget.model!.nameAr;
      _nameEngController.text = widget.model!.nameEng;
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
      body: Center(
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

                  Container(
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

                        setState(() {});
                      },
                      hint: 'اختار نوع التعليم',
                    ),
                  ),

                  verticalSpace(20),

                  TextFormFieldWidget(
                    hintText: "اسم المرحلة باللغة العربية",
                    validator: (val) {},
                    controller: _nameArController,
                    isObscureText: false,
                    backgroundColor: Colors.white,
                  ),

                  verticalSpace(20),

                  TextFormFieldWidget(
                    controller: _nameEngController,
                    hintText: "اسم المرحلة باللغة الانجليزية",
                    isObscureText: false,
                    textInputType: TextInputType.number,
                    validator: (val) {},
                    backgroundColor: Colors.white,
                  ),

                  verticalSpace(20),

                  CustomButton(
                      title: !widget.isUpdate ? "انشاء" : "تعديل",
                      onPressed: () {
                        if (isValidate(context: context)) {
                          if (widget.isUpdate) {
                            StagesCubit.get(context).updateStage(
                                context: context,
                                stageId: widget.model!.id,
                                typeId: typeEducationValue!.id,
                                nameAr: _nameArController.text,
                                nameEng: _nameEngController.text);
                          } else {
                            StagesCubit.get(context).addStage(
                                context: context,
                                typeId: typeEducationValue!.id,
                                nameAr: _nameArController.text,
                                nameEng: _nameEngController.text);
                          }
                        }
                      })
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  bool isValidate({context}) {
    if (typeEducationValue == null) {
      showToast(msg: "اختار نوع التعليم", color: Colors.red);
      return false;
    } else if (_nameArController.text.isEmpty || _nameArController.text == "") {
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
