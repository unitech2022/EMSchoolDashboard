import 'package:emschool_dashboard/bloc/subjects_cubit/subjects_cubit.dart';
import 'package:emschool_dashboard/core/extensions/extensions_routing.dart';
import 'package:emschool_dashboard/core/helpers/helper_functions.dart';
import 'package:emschool_dashboard/core/theming/colors.dart';
import 'package:emschool_dashboard/core/theming/styles.dart';
import 'package:emschool_dashboard/core/widgets/image_network_widget.dart';
import 'package:emschool_dashboard/models/subject_model.dart';
import 'package:emschool_dashboard/ui/subjects_screen/add_subject_screen/add_subject_screen.dart';
import 'package:flutter/material.dart';

class SubjectsTable extends StatelessWidget {
  final List<SubjectModel> users;
  final int type;
  const SubjectsTable({super.key, required this.users, this.type = 0});

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
                "#ID",
                style: TextStyles.textStyleFontBold12whit,
              ),
            ),
            DataColumn(
              label: Text(" اسم المادة بالعربية",
                  style: TextStyles.textStyleFontBold12whit),
            ),
            DataColumn(
              label: Text("اسم المادة بالانجليزية",
                  style: TextStyles.textStyleFontBold12whit),
            ),
            DataColumn(
              label: Text("صورة", style: TextStyles.textStyleFontBold12whit),
            ),
            DataColumn(
              label: Text("وقت الاضافة",
                  style: TextStyles.textStyleFontBold12whit),
            ),
            DataColumn(
              label: Text("الفعل", style: TextStyles.textStyleFontBold12whit),
            ),
          ],
          rows: List.generate(
            users.length,
            (index) => recentSubjectsDataRow(users[index], context, type),
          ),
        ),
      ),
    );
  }
}

DataRow recentSubjectsDataRow(
    SubjectModel userInfo, BuildContext context, int type) {
  return DataRow(
    cells: [
      DataCell(
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            userInfo.id.toString(),
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
            userInfo.nameAr,
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
            userInfo.nameEng,
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
                image: userInfo.image,
                height: 40,
                width: 40,
              ),
            ),
          ))),
      DataCell(Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            formatDate2(DateTime.parse(userInfo.createdAt)),
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
                context.navigatePush(AddSubjectScreen(
                  isUpdate: true,
                  model: userInfo,
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
                      SubjectsCubit.get(context)
                          .deleteSubject(context: context, id: userInfo.id);
                    },
                    value: userInfo.nameAr);
              },
              // Delete
            ),
          ],
        ),
      ),
    ],
  );
}
