import 'package:emschool_dashboard/bloc/subjects_cubit/subjects_cubit.dart';
import 'package:emschool_dashboard/core/enums/loading_status.dart';
import 'package:emschool_dashboard/core/extensions/extensions_routing.dart';
import 'package:emschool_dashboard/core/helpers/helper_functions.dart';
import 'package:emschool_dashboard/core/helpers/reponsiveness.dart';
import 'package:emschool_dashboard/core/helpers/spacing.dart';
import 'package:emschool_dashboard/core/theming/colors.dart';
import 'package:emschool_dashboard/core/theming/styles.dart';
import 'package:emschool_dashboard/core/utlis/app_model.dart';
import 'package:emschool_dashboard/core/widgets/circular_progress.dart';
import 'package:emschool_dashboard/core/widgets/custom_button.dart';
import 'package:emschool_dashboard/core/widgets/text_field_widget.dart';
import 'package:emschool_dashboard/models/subject_model.dart';
import 'package:emschool_dashboard/models/type_education_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/widgets/drop_dwon_widget.dart';
import '../../../core/widgets/image_network_widget.dart';
import '../../../models/class_room_model.dart';
import '../../../models/stage_model.dart';

class AddSubjectScreen extends StatefulWidget {
  final bool isUpdate;
  final SubjectModel? model;
  const AddSubjectScreen({super.key, this.isUpdate = false, this.model});

  @override
  State<AddSubjectScreen> createState() => _AddSubjectScreenState();
}

class _AddSubjectScreenState extends State<AddSubjectScreen> {
  TypeEducationModel? typeEducationValue;
  StageModel? stageModel;
  ClassRoomModel? classRoomModelValue;
  List<StageModel> stages = [];
  List<ClassRoomModel> classRooms = [];
  final _nameArController = TextEditingController();
  final _nameEngController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.isUpdate) {
      SubjectsCubit.get(context).changImage(widget.model!.image);
      typeEducationValue = responseDataForLogin!.typeEducations
          .firstWhere((element) => element.id == widget.model!.typeEducationId);
      classRoomModelValue = responseDataForLogin!.classRooms
          .firstWhere((element) => element.id == widget.model!.classRoomId);

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
    return BlocBuilder<SubjectsCubit, SubjectsState>(
      builder: (context, state) {
        return Scaffold(
            backgroundColor: ColorsApp.mainColor,
            body: Center(
                child: SingleChildScrollView(
              child: Card(
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
                                  element.typeEducationId ==
                                  typeEducationValue!.id)
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

                    Container(
                      padding: const EdgeInsets.all(5),
                      margin: const EdgeInsets.only(bottom: 20),
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
                        },
                        hint: 'اختار الصف الدراسي',
                      ),
                    ),

                    TextFormFieldWidget(
                      hintText: "اسم المادة باللغة العربية",
                      validator: (val) {},
                      controller: _nameArController,
                      isObscureText: false,
                      backgroundColor: Colors.white,
                    ),
                    verticalSpace(20),
                    TextFormFieldWidget(
                      controller: _nameEngController,
                      hintText: "اسم المادة باللغة الانجليزية",
                      isObscureText: false,
                      textInputType: TextInputType.number,
                      validator: (val) {},
                      backgroundColor: Colors.white,
                    ),
                    verticalSpace(20),

                    // image lesson

                    GestureDetector(
                      onTap: () async {
                        await SubjectsCubit.get(context).uploadImage();
                      },
                      child: Column(
                        children: [
                          Text(
                            "اضافة صورة المادة",
                            style: TextStyles.textStyleFontMeduim19White
                                .copyWith(color: Colors.green),
                          ),
                          verticalSpace(10),
                          state.image == null
                              ? const Icon(
                                  Icons.photo,
                                  color: ColorsApp.mainColor,
                                  size: 100,
                                )
                              : state.uploadImageState == RequestState.loading
                                  ? const CustomCircularProgress(
                                      color: ColorsApp.mainColor,
                                    )
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
                    verticalSpace(10),
                    CustomButton(
                        title: !widget.isUpdate ? "انشاء" : "تعديل",
                        onPressed: () {
                          if (isValidate(
                              context: context, image: state.image)) {
                            if (widget.isUpdate) {
                              SubjectsCubit.get(context).updateSubject(
                                  context: context,
                                  subjectId: widget.model!.id,
                                  stageId: stageModel!.id,
                                  classId: classRoomModelValue!.id,
                                  image: state.image,
                                  typeId: typeEducationValue!.id,
                                  nameAr: _nameArController.text,
                                  nameEng: _nameEngController.text);
                            } else {
                              SubjectsCubit.get(context).addSubject(
                                  context: context,
                                  stageId: stageModel!.id,
                                  classId: classRoomModelValue!.id,
                                  image: state.image,
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
      },
    );
  }

  bool isValidate({context, image}) {
    if (typeEducationValue == null) {
      showToast(msg: "اختار نوع التعليم", color: Colors.red);
      return false;
    } else if (stageModel == null) {
      showToast(msg: "اختار المرحلة التعليمية", color: Colors.red);
      return false;
    } else if (classRoomModelValue == null) {
      showToast(msg: "اختار الصف الدراسي ", color: Colors.red);
      return false;
    } else if (_nameArController.text.isEmpty || _nameArController.text == "") {
      showToast(msg: "اكتب الاسم باللغة العربية", color: Colors.red);
      return false;
    } else if (_nameEngController.text.isEmpty ||
        _nameEngController.text == "") {
      showToast(msg: "اكتب الاسم باللغة الانجليزية", color: Colors.red);
      return false;
    } else if (image == null) {
      showToast(msg: "اختار الصورة", color: Colors.red);
      return false;
    } else {
      return true;
    }
  }
}
