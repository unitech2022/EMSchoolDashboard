import 'package:emschool_dashboard/bloc/schedules_cubit/schedules_cubit.dart';
import 'package:emschool_dashboard/core/extensions/extensions_routing.dart';
import 'package:emschool_dashboard/core/theming/colors.dart';
import 'package:emschool_dashboard/core/theming/styles.dart';
import 'package:emschool_dashboard/models/schedule_model.dart';
import 'package:emschool_dashboard/ui/schedules_screen/add_schedules_screen/add_schedules_screen.dart';
import 'package:flutter/material.dart';
import '../../../core/helpers/helper_functions.dart';

class TableSchedules extends StatelessWidget {
  final List<ScheduleResponse> list;

  const TableSchedules({super.key, required this.list});

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
            (index) => recentSchedulesDataRow(list[index], context),
          ),
        ),
      ),
    );
  }
}

DataRow recentSchedulesDataRow(ScheduleResponse model, BuildContext context) {
  return DataRow(
    cells: [
      DataCell(
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            model.schedule.id.toString(),
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
            model.schedule.nameAr,
            maxLines: 1,
            style: TextStyles.textStyleFontMeduim12White,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
      DataCell(Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            model.schedule.nameEng,
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
                context.navigatePush(AddSchedulesScreen(
                  isUpdate: true,
                  scheduleResponse: model,
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
                      SchedulesCubit.get(context).deleteSchedul(
                          classId: model.schedule.classRoomId,
                          scheduleId: model.schedule.id,
                          context: context);
                    },
                    value: model.schedule.nameAr);
              },
              // Delete
            ),
          ],
        ),
      ),
    ],
  );
}
