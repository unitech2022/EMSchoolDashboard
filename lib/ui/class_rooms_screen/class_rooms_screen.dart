import 'package:emschool_dashboard/bloc/class_rooms_cubit/class_rooms_cubit.dart';
import 'package:emschool_dashboard/core/extensions/extensions_routing.dart';
import 'package:emschool_dashboard/core/routing/routes.dart';
import 'package:emschool_dashboard/ui/class_rooms_screen/components/tables_class_room.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/enums/loading_status.dart';
import '../../core/helpers/spacing.dart';
import '../../core/theming/styles.dart';
import '../../core/utlis/app_model.dart';
import '../../core/widgets/drop_dwon_widget.dart';
import '../../core/widgets/loading_widget.dart';
import '../../core/widgets/title_widget.dart';
import '../../models/stage_model.dart';
import '../../models/type_education_model.dart';

class ClassRoomsScreen extends StatefulWidget {
  const ClassRoomsScreen({super.key});

  @override
  State<ClassRoomsScreen> createState() => _ClassRoomsScreenState();
}

class _ClassRoomsScreenState extends State<ClassRoomsScreen> {
  TypeEducationModel? typeEducationValue;
  StageModel? stageModel;

  List<StageModel> stages = [];

  @override
  void initState() {
    super.initState();
    ClassRoomsCubit.get(context)
        .getClassRooms(page: 1, typeId: 0, context: context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            verticalSpace(10),
            TitleWidget(
              title: "الصفوف الدراسية",
              titleButton: "اضافة جديد",
              onPress: () {
                context.navigateToNamed(Routes.addClassRoom);
              },
            ),
            verticalSpace(10),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    width: 230,
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
                  horizontalSpace(10),
                  Container(
                    width: 230,
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
                                style: TextStyles.textStyleFontBold15black,
                              )))
                          .toList(),
                      onSelect: (val) {
                        stageModel = val;
                        setState(() {});
                        ClassRoomsCubit.get(context).getClassRooms(
                            context: context, typeId: val!.id, page: 1);
                      },
                      hint: 'اختارالمرحلة التعليمية',
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: BlocBuilder<ClassRoomsCubit, ClassRoomsState>(
                builder: (context, state) {
                  return state.getClassRoomsState == RequestState.loaded
                      ? TableClassRooms(list: state.classRooms!.items)
                      : const LoadingWidget();
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
