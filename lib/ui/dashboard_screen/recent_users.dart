import 'package:emschool_dashboard/core/helpers/helper_functions.dart';
import 'package:emschool_dashboard/core/theming/colors.dart';
import 'package:emschool_dashboard/core/theming/styles.dart';
import 'package:emschool_dashboard/core/utlis/api_constatns.dart';

import 'package:emschool_dashboard/core/widgets/image_network_widget.dart';
import 'package:emschool_dashboard/models/user_model.dart';
import 'package:emschool_dashboard/ui/notificationns_screen/add_notificationn_screen.dart';
import 'package:emschool_dashboard/ui/users_screen/add_user_screen/add_user_screen.dart';
import 'package:flutter/material.dart';

class RecentUsers extends StatefulWidget {
  final List<UserResponse> users;
  final int type;
  const RecentUsers({super.key, required this.users, this.type = 0});

  @override
  State<RecentUsers> createState() => _RecentUsersState();
}

class _RecentUsersState extends State<RecentUsers> {
  List<String> selectors = [];
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      width: double.infinity,
      decoration: const BoxDecoration(
        color: ColorsApp.mainColor,
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          horizontalMargin: 20,
          columnSpacing: 20,
          columns: [
            DataColumn(
              label: Text(
                "الاسم",
                style: TextStyles.textStyleFontBold12whit,
              ),
            ),
            // DataColumn(
            //   label:
            //       Text("", style: TextStyles.textStyleFontBold12whit),
            // ),
            DataColumn(
              label: Text("الرقم السري",
                  style: TextStyles.textStyleFontBold12whit),
            ),
            DataColumn(
              label: Text("الكود", style: TextStyles.textStyleFontBold12whit),
            ),
            DataColumn(
              label: Text("صورة", style: TextStyles.textStyleFontBold12whit),
            ),

            DataColumn(
              label: Text("وقت التسجيل",
                  style: TextStyles.textStyleFontBold12whit),
            ),
            DataColumn(
              label: Text("الفعل", style: TextStyles.textStyleFontBold12whit),
            ),
            DataColumn(
              label: Text("نحديد", style: TextStyles.textStyleFontBold12whit),
            ),
          ],
          rows: List.generate(
            widget.users.length,
            (index) => recentUserDataRow(
                widget.users[index],
                context,
                widget.type,
                selectors.contains(widget.users[index].id) ? true : false,
                onChange: (val) {
              if (selectors.contains(widget.users[index].id)) {
                selectors.removeWhere(
                    (element) => element == widget.users[index].id);
              } else {
                selectors.add(widget.users[index].id);
              }
              setState(() {
                
              });
            }),
          ),
        ),
      ),
    );
  }
}

DataRow recentUserDataRow(
    UserResponse userInfo, BuildContext context, int type, bool selector,
    {onChange}) {
  return DataRow(
    cells: [
      DataCell(
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            userInfo.fullName!,
            maxLines: 1,
            style: TextStyles.textStyleFontMeduim12White,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
      // DataCell(
      //   Padding(
      //     padding: const EdgeInsets.symmetric(horizontal: 10),
      //     child: Text(
      //       userInfo.userName,
      //       maxLines: 1,
      //       style: TextStyles.textStyleFontMeduim12White,
      //       overflow: TextOverflow.ellipsis,
      //     ),
      //   ),
      // ),
      DataCell(
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: SelectableText(
            userInfo.password!,
            maxLines: 1,
            style: TextStyles.textStyleFontMeduim12White,
            // overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
      DataCell(
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: SelectableText(
            userInfo.role == ApiConstants.parentRole
                ? userInfo.userName!
                : userInfo.uniqCode!,
            maxLines: 1,
            style: TextStyles.textStyleFontMeduim12White,
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
                image: userInfo.profileImage ?? "",
                height: 40,
                width: 40,
              ),
            ),
          ))),
      // DataCell(Padding(
      //     padding: const EdgeInsets.symmetric(horizontal: 10),
      //     child: Text(
      //      type==0? responseDataForLogin!.classRooms
      //           .firstWhere((element) => userInfo.classRoomId == element.id)
      //           .nameAr:responseDataForLogin!.subjects
      //           .firstWhere((element) => userInfo.subjectId == element.id)
      //           .nameAr,
      //       maxLines: 1,
      //       style: TextStyles.textStyleFontMeduim12White,
      //       overflow: TextOverflow.ellipsis,
      //     ))),
      DataCell(Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            formatDate2(DateTime.parse(userInfo.createdAt!)),
            maxLines: 1,
            style: TextStyles.textStyleFontMeduim12White,
            overflow: TextOverflow.ellipsis,
          ))),
      DataCell(
        Row(
          children: [
            TextButton(
              child: const Text('عرض', style: TextStyle(color: Colors.green)),
              onPressed: () {},
            ),
            const SizedBox(
              width: 6,
            ),
            TextButton(
              child: const Text("تعديل",
                  style: TextStyle(color: Colors.redAccent)),
              onPressed: () {
                pushPage(
                    context,
                    AddUserScreen(
                      userResponse: userInfo,
                    ));
              },
              // Delete
            ),
            TextButton(
              child: const Text(" ارسال اشعار",
                  style: TextStyle(color: Colors.orange)),
              onPressed: () {
                pushPage(
                    context,
                    AddNotificationScreen(
                      isAll: false,
                      userId: userInfo.id,
                    ));
              },
              // Delete
            ),
          ],
        ),
      ),
      DataCell(Checkbox(value: selector, onChanged: onChange))
    ],
  );
}
