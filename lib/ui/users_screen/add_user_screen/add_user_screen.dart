import 'package:emschool_dashboard/bloc/users_cubit/users_cubit.dart';
import 'package:emschool_dashboard/core/extensions/extensions_routing.dart';
import 'package:emschool_dashboard/core/helpers/helper_functions.dart';
import 'package:emschool_dashboard/core/helpers/reponsiveness.dart';
import 'package:emschool_dashboard/core/helpers/spacing.dart';
import 'package:emschool_dashboard/core/theming/colors.dart';
import 'package:emschool_dashboard/core/theming/styles.dart';
import 'package:emschool_dashboard/core/utlis/api_constatns.dart';
import 'package:emschool_dashboard/core/utlis/app_model.dart';
import 'package:emschool_dashboard/core/widgets/custom_button.dart';
import 'package:emschool_dashboard/core/widgets/text_field_widget.dart';
import 'package:emschool_dashboard/models/class_room_model.dart';
import 'package:emschool_dashboard/models/stage_model.dart';
import 'package:emschool_dashboard/models/subject_model.dart';
import 'package:emschool_dashboard/models/type_education_model.dart';
import 'package:emschool_dashboard/models/user_model.dart';

import 'package:flutter/material.dart';

import '../../../core/helpers/app_regex.dart';
import '../../../core/widgets/drop_dwon_widget.dart';
import '../../../models/register_body_reqquest.dart';
import '../../../models/role_model.dart';

List<RoleModel> rols = [RoleModel(1, 'طالب'), RoleModel(2, 'مدرس')];

class AddUserScreen extends StatefulWidget {
  final UserResponse? userResponse;
  const AddUserScreen({super.key, this.userResponse});

  @override
  State<AddUserScreen> createState() => _AddUserScreenState();
}

class _AddUserScreenState extends State<AddUserScreen> {
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();

  RoleModel? roleValue;
  TypeEducationModel? typeEducationValue;
  StageModel? stageModel;
  ClassRoomModel? classModel;
  SubjectModel? subjectModel;
  List<StageModel> stages = [];

  List<SubjectModel> subjects = [];
  List<ClassRoomModel> classRooms = [];
  bool isObscureText = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.userResponse != null) {
      // if (widget.userResponse!.role == ApiConstants.studentRole) {
      //   roleValue = rols[0];
      //   classModel = responseDataForLogin!.classRooms.firstWhere(
      //       (element) => element.id == widget.userResponse!.classRoomId);
      // } else {
      //   roleValue = rols[1];
      //   subjectModel = responseDataForLogin!.subjects.firstWhere(
      //       (element) => element.id == widget.userResponse!.subjectId);
      // }
      // typeEducationValue = responseDataForLogin!.typeEducations.firstWhere(
      //     (element) => element.id == widget.userResponse!.typeEducationId);
      // stageModel = responseDataForLogin!.stages
      //     .firstWhere((element) => element.id == widget.userResponse!.stageId);

      _nameController.text = widget.userResponse!.fullName!;
      _phoneController.text =
          widget.userResponse!.userName!.replaceAll("+20", "");
      _passwordController.text = widget.userResponse!.password!;
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _nameController.dispose();
    _passwordController.dispose();
    _phoneController.dispose();
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
                  // role user
                  Container(
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black, width: 1),
                        borderRadius: BorderRadius.circular(10)),
                    child: CustomDropDownWidget(
                      currentValue: roleValue,
                      list: rols
                          .map((e) => DropdownMenuItem<RoleModel>(
                              value: e,
                              child: Text(
                                e.name,
                                style: TextStyles.textStyleFontBold15black,
                              )))
                          .toList(),
                      onSelect: (val) {
                        roleValue = val;
                        setState(() {});
                      },
                      hint: 'اختار نوع العميل',
                    ),
                  ),
                  verticalSpace(20),

                  // type Education and stage model

                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.black, width: 1),
                              borderRadius: BorderRadius.circular(10)),
                          child: CustomDropDownWidget(
                            currentValue: typeEducationValue,
                            list: responseDataForLogin!.typeEducations
                                .map(
                                    (e) => DropdownMenuItem<TypeEducationModel>(
                                        value: e,
                                        child: Text(
                                          e.nameAr,
                                          style: TextStyles
                                              .textStyleFontBold15black,
                                        )))
                                .toList(),
                            onSelect: (val) {
                              typeEducationValue = val;
                              stageModel = null;
                              classRooms = [];
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
                      ),
                      horizontalSpace(10),
                      Expanded(
                        child: Container(
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
                                      style:
                                          TextStyles.textStyleFontBold15black,
                                    )))
                                .toList(),
                            onSelect: (val) {
                              stageModel = val;
                              classModel = null;
                              classRooms = [];
                              classRooms = responseDataForLogin!.classRooms
                                  .where((element) =>
                                      element.stageId == stageModel!.id)
                                  .toList();

                              setState(() {});
                            },
                            hint: 'اختارالمرحلة التعليمية',
                          ),
                        ),
                      ),
                    ],
                  ),
                  verticalSpace(20),
                  // class room
                  Container(
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black, width: 1),
                        borderRadius: BorderRadius.circular(10)),
                    child: CustomDropDownWidget(
                      currentValue: classModel,
                      list: classRooms
                          .map((e) => DropdownMenuItem<ClassRoomModel>(
                              value: e,
                              child: Text(
                                e.nameAr,
                                style: TextStyles.textStyleFontBold15black,
                              )))
                          .toList(),
                      onSelect: (val) {
                        classModel = val;
                        subjects = [];
                        subjects = responseDataForLogin!.subjects
                            .where((element) =>
                                element.classRoomId == classModel!.id)
                            .toList();
                        setState(() {});
                      },
                      hint: 'اختار الصف الدراسي',
                    ),
                  ),

                  verticalSpace(
                      roleValue != null && roleValue!.id == 2 ? 20 : 0),
                  // subject
                  roleValue != null && roleValue!.id == 2
                      ? Container(
                          padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.black, width: 1),
                              borderRadius: BorderRadius.circular(10)),
                          child: CustomDropDownWidget(
                            currentValue: subjectModel,
                            list: subjects
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
                            },
                            hint: 'اختار التخصص ',
                          ),
                        )
                      : const SizedBox(),

                  verticalSpace(20),

                  TextFormFieldWidget(
                    hintText: "الاسم ",
                    validator: (val) {},
                    controller: _nameController,
                    isObscureText: false,
                    backgroundColor: Colors.white,
                  ),

                  verticalSpace(20),

                  TextFormFieldWidget(
                    controller: _phoneController,
                    isEnabled: widget.userResponse == null ? true : false,
                    hintText: " رقم الهاتف بدون كود الدولة ",
                    isObscureText: false,
                    textInputType: TextInputType.number,
                    validator: (val) {},
                    backgroundColor: Colors.white,
                  ),

                  verticalSpace(20),

                  TextFormFieldWidget(
                    hintText: "الرقم السري",
                    controller: _passwordController,
                    isObscureText: isObscureText,
                    suffixIcon: IconButton(
                      icon: Icon(isObscureText
                          ? Icons.visibility_off
                          : Icons.visibility),
                      onPressed: () {
                        isObscureText = !isObscureText;
                        setState(() {});
                      },
                    ),
                    validator: (val) {},
                    backgroundColor: Colors.white,
                  ),
                  const Row(
                    children: [
                      Text(
                        "لا بد آن يشتمل الرقم السري علي آحرف كبيرة و رموز مثال (A,@)",
                        style: TextStyle(fontSize: 12, color: Colors.red),
                      ),
                    ],
                  ),
                  verticalSpace(30),

                  CustomButton(
                      title: widget.userResponse == null ? "انشاء" : "تعديل",
                      onPressed: () {
                        if (isValidate(context: context)) {
                          RequestBodyRegister requestBodyRegister =
                              RequestBodyRegister(
                            subjectId:
                                roleValue!.id == 1 ? 0 : subjectModel!.id,
                            fullName: _nameController.text,
                            typeEducationId: typeEducationValue!.id,
                            stageId: stageModel!.id,
                            classRoomId:
                                roleValue!.id == 1 ? classModel!.id : 0,
                            userName: "+20${_phoneController.text.trim()}",
                            password: _passwordController.text,
                            code: "0000",
                            role: roleValue!.id == 1
                                ? ApiConstants.studentRole
                                : ApiConstants.teacherRole,
                          );
                          if (widget.userResponse == null) {
                            UsersCubit.get(context).registerUser(
                              requestBodyRegister,
                              context,
                            );
                          } else {
                            UsersCubit.get(context).editeProfile(
                              requestBodyRegister,
                              widget.userResponse!.id,
                              context,
                            );
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
    if (roleValue == null) {
      showToast(msg: "اختار نوع التعليم", color: Colors.red);
      return false;
    } else if (typeEducationValue == null) {
      showToast(msg: "اختار نوع التعليم", color: Colors.red);
      return false;
    } else if (stageModel == null) {
      showToast(msg: "اختار المرحلة التعليمية", color: Colors.red);
      return false;
    } else if (roleValue!.id == 1 && classModel == null) {
      showToast(msg: "اختار الصف الدراسي", color: Colors.red);
      return false;
    } else if (roleValue!.id == 2 && subjectModel == null) {
      showToast(msg: "اختار التخصص", color: Colors.red);
      return false;
    } else if (_nameController.text.isEmpty || _nameController.text == "") {
      showToast(msg: "اكتب الاسم", color: Colors.red);
      return false;
    } else if (_nameController.text.isEmpty || _nameController.text == "") {
      showToast(msg: "اكتب رقم الهاتف", color: Colors.red);
      return false;
    } else if (_passwordController.text.isEmpty ||
        !(AppRegex.isPasswordValid(_passwordController.text))) {
      showToast(
          msg: "يجب ان يكون ٨ احرف و يحتوي علي احزف كبيرة و رموز",
          color: Colors.red);
      return false;
    } else {
      return true;
    }
  }
}
