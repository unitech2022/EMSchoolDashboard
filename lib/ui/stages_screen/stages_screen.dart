import 'package:emschool_dashboard/bloc/stages_cubit/stages_cubit.dart';
import 'package:emschool_dashboard/core/enums/loading_status.dart';
import 'package:emschool_dashboard/core/extensions/extensions_routing.dart';
import 'package:emschool_dashboard/core/helpers/reponsiveness.dart';
import 'package:emschool_dashboard/core/routing/routes.dart';
import 'package:emschool_dashboard/ui/stages_screen/components/tables_stages_widget.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/helpers/spacing.dart';
import '../../core/theming/styles.dart';
import '../../core/utlis/app_model.dart';

import '../../core/widgets/drop_dwon_widget.dart';
import '../../core/widgets/loading_widget.dart';

import '../../core/widgets/title_widget.dart';
import '../../models/type_education_model.dart';

class StagesScreen extends StatefulWidget {
  const StagesScreen({super.key});

  @override
  State<StagesScreen> createState() => _StagesScreenState();
}

class _StagesScreenState extends State<StagesScreen> {
  TypeEducationModel? typeEducationValue;

  @override
  void initState() {
    super.initState();
    StagesCubit.get(context).getStages(page: 1, typeId: 0, context: context);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StagesCubit, StagesState>(
      builder: (context, state) {
        return Scaffold(
          body: SingleChildScrollView(
            child: Column(
              children: [
                verticalSpace(10),
                TitleWidget(
                  title: "المراحل التعليمية",
                  titleButton: "اضافة جديد",
                  onPress: () {
                    context.navigateToNamed(Routes.addStage);
                  },
                ),
                verticalSpace(10),
                Row(
                  children: [
                    Container(
                      width: ResponsiveWidget.isSmallScreen(context)
                          ? double.infinity
                          : 300,
                      padding: const EdgeInsets.all(5),
                      margin: const EdgeInsets.symmetric(horizontal: 20),
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
                          StagesCubit.get(context).getStages(
                              page: 1, typeId: val.id, context: context);
                        },
                        hint: 'اختار نوع التعليم',
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: state.getStagessStage == RequestState.loaded
                      ? TableStages(list: state.stages!.items) 
                      :const LoadingWidget(),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
