import 'package:emschool_dashboard/bloc/events_cubit/events_cubit.dart';
import 'package:emschool_dashboard/core/helpers/helper_functions.dart';
import 'package:emschool_dashboard/core/theming/colors.dart';
import 'package:emschool_dashboard/core/theming/styles.dart';
import 'package:emschool_dashboard/core/widgets/image_network_widget.dart';
import 'package:emschool_dashboard/models/bunner_model.dart';
import 'package:emschool_dashboard/ui/events_screen/events_screen.dart';
import 'package:flutter/material.dart';

class EventsTablesWidget extends StatelessWidget {
  final List<BannerModel> list;
  final int type;
  const EventsTablesWidget({super.key, required this.list, this.type = 0});

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
              label: Text("الصورة", style: TextStyles.textStyleFontBold12whit),
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
            (index) => recentUserDataRow(list[index], context, type),
          ),
        ),
      ),
    );
  }
}

DataRow recentUserDataRow(BannerModel model, BuildContext context, int type) {
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
      DataCell(Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Container(
            height: 40,
            width: 40,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white, width: 1)),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(40),
              child: ImageNetworkWidget(
                image: model.image,
                height: 40,
                width: 40,
              ),
            ),
          ))),
      DataCell(Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            formatDate2(DateTime.parse(model.createAte)),
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
                EventsCubit.get(context).changImage(model.image);
                bottomAddDataEvent(context, isUpdate: true, eventId: model.id);
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
                      EventsCubit.get(context)
                          .deleteEvent(context: context, id: model.id);
                    },
                    value: "");
              },
              // Delete
            ),
          ],
        ),
      ),
    ],
  );
}
