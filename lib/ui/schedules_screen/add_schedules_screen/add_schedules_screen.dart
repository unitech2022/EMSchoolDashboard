import 'package:emschool_dashboard/bloc/schedules_cubit/schedules_cubit.dart';
import 'package:emschool_dashboard/core/enums/loading_status.dart';
import 'package:emschool_dashboard/core/helpers/spacing.dart';
import 'package:emschool_dashboard/core/widgets/custom_button.dart';
import 'package:emschool_dashboard/core/widgets/loading_widget.dart';
import 'package:emschool_dashboard/models/schedule_model.dart';
import 'package:emschool_dashboard/models/session_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/utils.dart';

import '../../../bloc/subjects_cubit/subjects_cubit.dart';
import '../../../core/helpers/helper_functions.dart';
import '../../../core/layout/app_fonts.dart';
import '../../../core/theming/colors.dart';
import '../../../core/theming/styles.dart';
import '../../../core/utlis/app_model.dart';
import '../../../core/widgets/drop_dwon_widget.dart';
import '../../../core/widgets/text_field_widget.dart';
import '../../../core/widgets/texts.dart';
import '../../../models/class_room_model.dart';
import '../../../models/stage_model.dart';
import '../../../models/type_education_model.dart';

List<BodySchedulRequist> allDays = [
  BodySchedulRequist("السبت", "Saturday"),
  BodySchedulRequist("الأحد", "Sunday"),
  BodySchedulRequist("الإثنين", "Monday"),
  BodySchedulRequist("الثلاثاء", "Tuesday"),
  BodySchedulRequist("الأربعاء", "Wednesday"),
  BodySchedulRequist("الخميس", "Thursday"),
];

class BodySchedulRequist {
  final String? nameAr;
  final String? nameEng;

  BodySchedulRequist(this.nameAr, this.nameEng);
}

class AddSchedulesScreen extends StatefulWidget {
  final bool? isUpdate;
  final ScheduleResponse? scheduleResponse;
  const AddSchedulesScreen(
      {super.key, isBlank, this.isUpdate=false, this.scheduleResponse});

  @override
  State<AddSchedulesScreen> createState() => _AddSchedulesScreenState();
}

class _AddSchedulesScreenState extends State<AddSchedulesScreen> {
  TypeEducationModel? typeEducationValue;
  StageModel? stageModel;
  ClassRoomModel? classRoomModelValue;
  List<StageModel> stages = [];
  List<ClassRoomModel> classRooms = [];

  final _nameArController = TextEditingController();
  final _nameEngController = TextEditingController();
  // days
  List<BodySchedulRequist> days = [];
  List<List<TextEditingController>> subjectsConntrollers = [];

  int? countDay;
  int? countSubject;

  List<BodySchedulRequist>? currentDays = [];

  @override
  void dispose() {
    super.dispose();
    _nameArController.dispose();
    _nameEngController.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    inItUpdate();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ColorsApp.mainColor,
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Card(
            elevation: 10,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child: Container(
                margin: const EdgeInsets.all(20),
                padding: const EdgeInsets.all(30),
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(10)),
                child: Column(
                  children: [
                    /// نوع التعليم     الصف المرحلة
                    Row(
                      children: [
                        // type Education

                        Container(
                          width: 220,
                          padding: const EdgeInsets.all(5),
                          margin: const EdgeInsets.only(
                              bottom: 20, left: 20, right: 20),
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
                          width: 220,
                          padding: const EdgeInsets.all(5),
                          margin: const EdgeInsets.only(
                              bottom: 20, left: 20, right: 20),
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
                          width: 220,
                          padding: const EdgeInsets.all(5),
                          margin: const EdgeInsets.only(
                              bottom: 20, left: 20, right: 20),
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
                                      style:
                                          TextStyles.textStyleFontBold15black,
                                    )))
                                .toList(),
                            onSelect: (val) {
                              classRoomModelValue = val;
                              setState(() {});
                              setState(() {});
                              SubjectsCubit.get(context).getSujects(
                                  page: 1, typeId: classRoomModelValue!.id);
                            },
                            hint: 'اختار الصف الدراسي',
                          ),
                        ),
                      ],
                    ),
                    verticalSpace(20),

                    // name table
                    Row(
                      children: [
                        Expanded(
                          child: TextFormFieldWidget(
                            hintText: "اسم الجدول باللغة العربية",
                            validator: (val) {},
                            controller: _nameArController,
                            isObscureText: false,
                            backgroundColor: Colors.white,
                          ),
                        ),
                        horizontalSpace(20),
                        Expanded(
                          child: TextFormFieldWidget(
                            controller: _nameEngController,
                            hintText: "اسم الجدول باللغة الانجليزية",
                            isObscureText: false,
                            textInputType: TextInputType.number,
                            validator: (val) {},
                            backgroundColor: Colors.white,
                          ),
                        ),
                      ],
                    ),

                    // colmens tabel
                    verticalSpace(10),
               widget.isUpdate!?const SizedBox():     Row(
                      children: [
                        // count dayes

                        Container(
                          width: 220,
                          padding: const EdgeInsets.all(5),
                          margin: const EdgeInsets.only(
                              bottom: 20, left: 10, right: 10),
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.black, width: 1),
                              borderRadius: BorderRadius.circular(10)),
                          child: CustomDropDownWidget(
                            currentValue: countDay,
                            list: [1, 2, 3, 4, 5, 6]
                                .map((e) => DropdownMenuItem<int>(
                                    value: e,
                                    child: Text(
                                      e.toString(),
                                      style:
                                          TextStyles.textStyleFontBold15black,
                                    )))
                                .toList(),
                            onSelect: (val) {
                              countDay = val;
                              currentDays = [];
                              for (var i = 0; i < val; i++) {
                                currentDays!.add(allDays[i]);
                                
                              }
                              setState(() {});
                            },
                            hint: 'اختار عدد الايام',
                          ),
                        ),
                        //count subjects
                        Container(
                          width: 220,
                          padding: const EdgeInsets.all(5),
                          margin: const EdgeInsets.only(
                              bottom: 20, left: 10, right: 10),
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.black, width: 1),
                              borderRadius: BorderRadius.circular(10)),
                          child: CustomDropDownWidget(
                            currentValue: countSubject,
                            list: [4, 5, 6, 7, 8]
                                .map((e) => DropdownMenuItem<int>(
                                    value: e,
                                    child: Text(
                                      e.toString(),
                                      style:
                                          TextStyles.textStyleFontBold15black,
                                    )))
                                .toList(),
                            onSelect: (val) {
                              subjectsConntrollers = [];
                              for (var i = 0; i < countDay!; i++) {
                                List<TextEditingController> controllers = [];
                                for (var i = 0; i < val; i++) {
                                  controllers.add(TextEditingController());
                                }
                                subjectsConntrollers.add(controllers);
                              }
                              countSubject = val;
                              setState(() {});
                            },
                            hint: 'اختار عدد الحصص  لكل يوم',
                          ),
                        ),
                      ],
                    ),

                    verticalSpace(10),
                    countDay == null
                        ? const SizedBox()
                        : BlocBuilder<SchedulesCubit, SchedulesState>(
                            builder: (contextBloc, state) {
                              return Expanded(
                                  child: SingleChildScrollView(
                                child: Row(
                                  children: [
                                    SizedBox(
                                      width: 150,
                                      child: Column(
                                        children:
                                            List.generate(countDay!, (index) {
                                          BodySchedulRequist model =
                                              currentDays![index];
                                          return GestureDetector(
                                              onTap: () async {
                                                await getDay(model, index)
                                                    .then((value) {});
                                              },
                                              child: Container(
                                                width: 150,
                                                height: 60,
                                                padding:
                                                    const EdgeInsets.all(5),
                                                margin: const EdgeInsets.only(
                                                    bottom: 10,
                                                    left: 10,
                                                    right: 10),
                                                decoration: BoxDecoration(
                                                    border: Border.all(
                                                        color: Colors.black,
                                                        width: 1),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10)),
                                                child: Text(currentDays![index]
                                                        .nameAr ??
                                                    ""),
                                              ));
                                        }).toList(),
                                      ),
                                    ),
                                    // horizontalSpace(10),
                                    Expanded(
                                        child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: subjectsConntrollers
                                          .map((e) => Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: List.generate(
                                                  e.length,
                                                  (index) => Expanded(
                                                        child: Container(
                                                          height: 60,
                                                          margin:
                                                              const EdgeInsets
                                                                  .all(5),
                                                          decoration: BoxDecoration(
                                                              border: Border.all(
                                                                  color: Colors
                                                                      .black,
                                                                  width: 1)),
                                                          child: TextField(
                                                            controller:
                                                                e[index],
                                                            decoration:
                                                                const InputDecoration(
                                                              hintText:
                                                                  "عربي \\ انجليزي",
                                                              border:
                                                                  InputBorder
                                                                      .none,
                                                            ),
                                                          ),
                                                        ),
                                                      ))))
                                          .toList(),
                                    ))
                                  ],
                                ),
                              ));
                            },
                          ),
                    verticalSpace(10),
                    currentDays!.isEmpty
                        ? const SizedBox()
                        : BlocBuilder<SchedulesCubit, SchedulesState>(
                            builder: (context, state) {
                              return state.addSchedulesState ==
                                      RequestState.loading
                                  ? const LoadingWidget()
                                  : Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        SizedBox(
                                          width: 150,
                                          child: CustomButton(
                                              title: "حفظ",
                                              onPressed: () {
                                                if (isValidate(context)) {
                                                  List<SessionAddSchedul>
                                                      sessions = [];

                                                  // get details tale
                                                  ScheduleModel? scheduleModel;
                                                  scheduleModel = ScheduleModel(
                                                      id: widget.isUpdate!
                                                          ? widget
                                                              .scheduleResponse!
                                                              .schedule
                                                              .id
                                                          : 0,
                                                      typeEducationId:
                                                          typeEducationValue!
                                                              .id,
                                                      stageId: stageModel!.id,
                                                      classRoomId:
                                                          classRoomModelValue!
                                                              .id,
                                                      nameAr: _nameArController
                                                          .text,
                                                      nameEng:
                                                          _nameEngController
                                                              .text,
                                                      status: 0,
                                                      createdAt: "");

                                                  // get subjects

                                                  for (var i = 0;
                                                      i < currentDays!.length;
                                                      i++) {
                                                    String subjetsAr = "";
                                                    String subjetsEng = "";
                                                    for (var element
                                                        in subjectsConntrollers[
                                                            i]) {
                                                      String subAr = element
                                                          .text
                                                          .split("\\")[0];
                                                      String subEng = element
                                                          .text
                                                          .split("\\")[1];
                                                      subjetsAr =
                                                          "$subjetsAr#$subAr";
                                                      subjetsEng =
                                                          "$subjetsEng#$subEng";
                                                    }

                                                    SessionAddSchedul
                                                        sessionModel =
                                                        SessionAddSchedul(
                                                      dayAr: currentDays![i]
                                                          .nameAr!,
                                                      dayEng: currentDays![i]
                                                          .nameEng!,
                                                      subjectsAr: subjetsAr,
                                                      subjectsEng: subjetsEng,
                                                      id: widget.isUpdate!
                                                          ? widget
                                                              .scheduleResponse!
                                                              .sessions[i]
                                                              .id
                                                          : 0,
                                                    );
                                                    sessions.add(sessionModel);
                                                  }

                                                  if (widget.isUpdate!) {
                                                    SchedulesCubit.get(context)
                                                      .updateSchedul(sessions,
                                                          scheduleModel,context: context);
                                                  } else {
                                                    SchedulesCubit.get(context)
                                                      .addSchedul(sessions,context:context,
                                                          scheduleModel);
                                                  }
                                                }
                                              }),
                                        )
                                      ],
                                    );
                            },
                          )
                  ],
                )),
          ),
        ));
  }

  Future getDay(BodySchedulRequist newModel, int indexList) async {
    showBottomSheetWidget(
        context,
        Container(
          padding:
              const EdgeInsets.only(top: 40, left: 30, right: 30, bottom: 20),
          decoration: const BoxDecoration(
              color: ColorsApp.boomSheetColor,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15), topRight: Radius.circular(15))),
          height: context.height / 2,
          width: double.infinity,
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            const SizedBox(
              height: 20,
            ),
            Expanded(
                child: ListView.builder(
                    itemCount: allDays.length,
                    itemBuilder: (ctx, index) {
                      BodySchedulRequist model = allDays[index];
                      return GestureDetector(
                        onTap: () {
                          newModel = model;
                          currentDays![indexList] = model;
                          setState(() {});

                          pop(context);
                        },
                        child: Container(
                          height: 60,
                          alignment: Alignment.center,
                          decoration: const BoxDecoration(),
                          child: Row(
                            children: [
                              Texts(
                                  title: model.nameAr!,
                                  textColor: Colors.white,
                                  family: AppFonts.innerMedium,
                                  size: 20),
                            ],
                          ),
                        ),
                      );
                    }))
          ]),
        ));

    // return bodySchedulRequist!;
  }

  bool isValidate(BuildContext context) {
    bool subjectController = false;
    for (var element in subjectsConntrollers) {
      if (element.any((element) => element.text.isEmpty)) {
        subjectController = false;
      } else {
        subjectController = true;
      }
    }
    if (subjectsConntrollers.isEmpty) {
      showToast(msg: "اكمل الجدول", color: Colors.red);
      return false;
    } else if (!subjectController) {
      showToast(msg: "اكمل الجدول", color: Colors.red);
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

  void inItUpdate() {
    if (widget.isUpdate!) {
      _nameArController.text = widget.scheduleResponse!.schedule.nameAr;
      _nameEngController.text = widget.scheduleResponse!.schedule.nameEng;

      countDay = widget.scheduleResponse!.sessions.length;
      for (int i = 0; i < widget.scheduleResponse!.sessions.length; i++) {
        currentDays!.add(allDays[i]);
      }
      countSubject = widget.scheduleResponse!.sessions[0].subjectsAr
          .split("#")
          .where((e) => e.isNotEmpty)
          .length;

      typeEducationValue = responseDataForLogin!.typeEducations.firstWhere(
          (element) =>
              element.id == widget.scheduleResponse!.schedule.typeEducationId);

      stageModel = responseDataForLogin!.stages.firstWhere(
          (element) => element.id == widget.scheduleResponse!.schedule.stageId);

      classRoomModelValue = responseDataForLogin!.classRooms.firstWhere(
          (element) =>
              element.id == widget.scheduleResponse!.schedule.classRoomId);

      for (var i = 0; i < widget.scheduleResponse!.sessions.length; i++) {
        List<TextEditingController> listConntroller = [];
        List<String> subjectsAr = widget
            .scheduleResponse!.sessions[i].subjectsAr
            .split("#")
            .where((e) => e.isNotEmpty)
            .toList();
        List<String> subjectsEng = widget
            .scheduleResponse!.sessions[i].subjectsEng
            .split("#")
            .where((e) => e.isNotEmpty)
            .toList();
        for (var i = 0; i < subjectsAr.length; i++) {
          listConntroller.add(TextEditingController(
              text: "${subjectsAr[i]}\\${subjectsEng[i]}"));
        }

        subjectsConntrollers.add(listConntroller);
      }

      setState(() {});
    }
  }
}
