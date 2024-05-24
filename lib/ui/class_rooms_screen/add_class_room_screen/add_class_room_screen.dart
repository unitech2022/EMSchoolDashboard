import 'package:emschool_dashboard/core/extensions/extensions_routing.dart';
import 'package:emschool_dashboard/core/helpers/helper_functions.dart';
import 'package:emschool_dashboard/core/helpers/reponsiveness.dart';
import 'package:emschool_dashboard/core/helpers/spacing.dart';
import 'package:emschool_dashboard/core/theming/colors.dart';
import 'package:emschool_dashboard/core/theming/styles.dart';
import 'package:emschool_dashboard/core/utlis/app_model.dart';
import 'package:emschool_dashboard/core/widgets/custom_button.dart';
import 'package:emschool_dashboard/core/widgets/text_field_widget.dart';
import 'package:emschool_dashboard/models/class_room_model.dart';
import 'package:emschool_dashboard/models/type_education_model.dart';
import 'package:flutter/material.dart';
import '../../../bloc/class_rooms_cubit/class_rooms_cubit.dart';
import '../../../core/widgets/drop_dwon_widget.dart';
import '../../../models/stage_model.dart';

class AddClassRoomScreen extends StatefulWidget {
  final bool isUpdate;
  final ClassRoomModel? model;

  const AddClassRoomScreen({super.key, this.isUpdate = false, this.model});

  @override
  State<AddClassRoomScreen> createState() => _AddClassRoomScreenState();
}

class _AddClassRoomScreenState extends State<AddClassRoomScreen> {
  TypeEducationModel? typeEducationValue;
  StageModel? stageModel;

  List<StageModel> stages = [];

  final _nameArController = TextEditingController();
  final _nameEngController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.isUpdate) {
      stageModel = responseDataForLogin!.stages
          .firstWhere((element) => element.id == widget.model!.stageId);

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
              child: Column(mainAxisSize: MainAxisSize.min, children: [
                // type Education

                Container(
                  padding: const EdgeInsets.all(5),
                  margin: const EdgeInsets.only(bottom: 20),
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
                              element.typeEducationId == typeEducationValue!.id)
                          .toList();
                      setState(() {});
                    },
                    hint: 'اختار نوع التعليم',
                  ),
                ),

                Container(
                  padding: const EdgeInsets.all(5),
                  margin: const EdgeInsets.only(bottom: 20),
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
                      setState(() {});
                    },
                    hint: 'اختارالمرحلة التعليمية',
                  ),
                ),

                TextFormFieldWidget(
                  hintText: "اسم الصف باللغة العربية",
                  validator: (val) {},
                  controller: _nameArController,
                  isObscureText: false,
                  backgroundColor: Colors.white,
                ),
                verticalSpace(20),
                TextFormFieldWidget(
                  controller: _nameEngController,
                  hintText: "اسم الصف باللغة الانجليزية",
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
                          ClassRoomsCubit.get(context).updateClassRoom(
                              context: context,
                              classId: widget.model!.id,
                              stageId: stageModel!.id,
                              typeId: typeEducationValue!.id,
                              nameAr: _nameArController.text,
                              nameEng: _nameEngController.text);
                        } else {
                          ClassRoomsCubit.get(context).addClassRoom(
                              context: context,
                              stageId: stageModel!.id,
                              typeId: typeEducationValue!.id,
                              nameAr: _nameArController.text,
                              nameEng: _nameEngController.text);
                        }
                      }
                    }),
              ]),
            ),
          ),
        )));
  }

  bool isValidate({context}) {
    if (stageModel == null) {
      showToast(msg: "اختار المرحلة التعليمية", color: Colors.red);
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
