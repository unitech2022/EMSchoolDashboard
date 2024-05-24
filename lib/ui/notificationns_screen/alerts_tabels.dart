import 'package:emschool_dashboard/bloc/alerts_cubit/alert_cubit.dart';
import 'package:emschool_dashboard/core/helpers/helper_functions.dart';
import 'package:emschool_dashboard/core/theming/colors.dart';
import 'package:emschool_dashboard/core/theming/styles.dart';
import 'package:emschool_dashboard/models/alert_model.dart';
import 'package:flutter/material.dart';

class AlertsTablesWidget extends StatelessWidget {
  final List<AlertModel> list;
  final int type;
  const AlertsTablesWidget({super.key, required this.list, this.type = 0});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      width: double.infinity,
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
                "#ID",
                style: TextStyles.textStyleFontBold12whit,
              ),
            ),
            DataColumn(
              label: Text("العنوان بالعربي",
                  style: TextStyles.textStyleFontBold12whit),
            ),
            DataColumn(
              label: Text("العنوان بالانجليزي",
                  style: TextStyles.textStyleFontBold12whit),
            ),
            DataColumn(
              label: Text("الموضوع بالعربي",
                  style: TextStyles.textStyleFontBold12whit),
            ),
            DataColumn(
              label: Text("الموضوع بالانجليزي",
                  style: TextStyles.textStyleFontBold12whit),
            ),
            DataColumn(
              label: Text("وقت الانشاء",
                  style: TextStyles.textStyleFontBold12whit),
            ),
            DataColumn(
              label: Text("الفعل", style: TextStyles.textStyleFontBold12whit),
            ),
          ],
          rows: List.generate(
            list.length,
            (index) => recentAlertDataRow(list[index], context, type),
          ),
        ),
      ),
    );
  }
}

DataRow recentAlertDataRow(AlertModel model, BuildContext context, int type) {
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
            model.titleAr.toString(),
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
            model.titleEng,
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
            model.descriptionAr,
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
            model.descriptionEng,
            maxLines: 1,
            style: TextStyles.textStyleFontMeduim12White,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
      DataCell(Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            formatDate2(DateTime.parse(model.createdAt)),
            maxLines: 1,
            style: TextStyles.textStyleFontMeduim12White,
            overflow: TextOverflow.ellipsis,
          ))),
      DataCell(
        TextButton(
          child: const Text("حذف", style: TextStyle(color: Colors.redAccent)),
          onPressed: () {
            dailogDeleteData(
                context: context,
                onCancel: () {
                  pop(context);
                },
                onDelete: () {
                  pop(context);
                  AlertCubit.get(context)
                      .deleteAlert(context: context, id: model.id);
                },
                value: model.titleAr);
          },
          // Delete
        ),
      ),
    ],
  );
}
