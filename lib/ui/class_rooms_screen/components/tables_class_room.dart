import 'package:emschool_dashboard/bloc/class_rooms_cubit/class_rooms_cubit.dart';
import 'package:emschool_dashboard/core/extensions/extensions_routing.dart';
import 'package:emschool_dashboard/core/theming/colors.dart';
import 'package:emschool_dashboard/core/theming/styles.dart';
import 'package:emschool_dashboard/models/class_room_model.dart';
import 'package:emschool_dashboard/ui/class_rooms_screen/add_class_room_screen/add_class_room_screen.dart';
import 'package:flutter/material.dart';
import '../../../core/helpers/helper_functions.dart';

class TableClassRooms extends StatelessWidget {
  final List<ClassRoomModel> list;

  const TableClassRooms({super.key, required this.list});

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
            (index) => recentClassRoomDataRow(list[index], context),
          ),
        ),
      ),
    );
  }
}

DataRow recentClassRoomDataRow(ClassRoomModel model, BuildContext context) {
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
                context.navigatePush(AddClassRoomScreen(
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
                      ClassRoomsCubit.get(context)
                          .deleteClassRoom(context: context, id: model.id);
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
