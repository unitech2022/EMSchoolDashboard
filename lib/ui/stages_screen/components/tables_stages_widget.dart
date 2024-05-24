import 'package:emschool_dashboard/bloc/stages_cubit/stages_cubit.dart';
import 'package:emschool_dashboard/core/extensions/extensions_routing.dart';
import 'package:emschool_dashboard/core/theming/colors.dart';
import 'package:emschool_dashboard/core/theming/styles.dart';
import 'package:emschool_dashboard/models/stage_model.dart';
import 'package:emschool_dashboard/ui/stages_screen/add_stage_screen/add_stage_screen.dart';
import 'package:flutter/material.dart';
import '../../../core/helpers/helper_functions.dart';

class TableStages extends StatelessWidget {
  final List<StageModel> list;

  const TableStages({super.key, required this.list});

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
            list.length,
            (index) => recentStageDataRow(list[index], context),
          ),
        ),
      ),
    );
  }
}

DataRow recentStageDataRow(StageModel model, BuildContext context) {
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
              child: const Text('تعديل', style: TextStyle(color: Colors.green)),
              onPressed: () {
                context.navigatePush(AddStageScreen(
                  isUpdate: true,
                  model: model,
                ));
              },
            ),
            const SizedBox(
              width: 6,
            ),
            TextButton(
              child:
                  const Text("حذف", style: TextStyle(color: Colors.redAccent)),
              onPressed: () {
                dailogDeleteData(
                    context: context,
                    onCancel: () {
                      pop(context);
                    },
                    onDelete: () {
                      pop(context);
                      StagesCubit.get(context)
                          .deleteStage(context: context, id: model.id);
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
