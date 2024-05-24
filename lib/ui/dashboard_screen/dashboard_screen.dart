import 'package:emschool_dashboard/bloc/home_cubit/home_cubit.dart';
import 'package:emschool_dashboard/core/enums/loading_status.dart';
import 'package:emschool_dashboard/core/extensions/extensions_routing.dart';
import 'package:emschool_dashboard/core/helpers/reponsiveness.dart';
import 'package:emschool_dashboard/core/helpers/spacing.dart';
import 'package:emschool_dashboard/core/theming/styles.dart';
import 'package:emschool_dashboard/core/widgets/loading_widget.dart';
import 'package:emschool_dashboard/models/home_response.dart';
import 'package:emschool_dashboard/ui/dashboard_screen/recent_users.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/routing/routes.dart';
import '../../core/widgets/title_widget.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(builder: (context, state) {
      return Scaffold(
          body: state.getHomeDataState == RequestState.loaded
              ? Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        // INFORMATIONS
                        InformationsWidget(homeResponse: state.homeResponse!),
                        verticalSpace(30),
                        // recenntUsers
                        TitleWidget(
                          title: "الطلاب الجدد",
                          titleButton: "اضافة جديد",
                          onPress: () {
                            context.navigateToNamed(Routes.addUser);
                          },
                        ),

                        RecentUsers(
                          users: state.homeResponse!.recentUsers,
                        )
                      ],
                    ),
                  ),
                )
              : const LoadingWidget());
    });
  }
}

class InformationsWidget extends StatelessWidget {
  final HomeResponse homeResponse;
  const InformationsWidget({
    super.key,
    required this.homeResponse,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      direction: Axis.horizontal,
      children: [
        ContainerDataDashboard(
          title: "عدد المواد",
          backgrounndColor: const Color(0xff0C2D57),
          value: homeResponse.subjects.toString(),
          icon: Icons.subject,
        ),
        ContainerDataDashboard(
          title: "عدد الدروس",
          backgrounndColor: const Color(0xff474F7A),
          value: homeResponse.lessons.toString(),
          icon: Icons.book_rounded,
        ),
        ContainerDataDashboard(
          title: "عدد المعلمين",
          backgrounndColor: const Color(0xff81689D),
          value: homeResponse.teachers.toString(),
          icon: Icons.layers_sharp,
        ),
        ContainerDataDashboard(
          title: "عدد الطلاب",
          backgrounndColor: const Color(0xff40A2E3),
          value: homeResponse.students.toString(),
          icon: Icons.group_sharp,
        ),
      ],
    );
  }
}

class ContainerDataDashboard extends StatelessWidget {
  final Color backgrounndColor;
  final String title, value;
  final IconData icon;

  const ContainerDataDashboard(
      {super.key,
      required this.backgrounndColor,
      required this.title,
      required this.icon,
      required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: ResponsiveWidget.isLargeScreen(context)
          ? context.width / 5
          : context.width,
      margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.all(10),
      alignment: Alignment.center,
      height: 150,
      decoration: BoxDecoration(
        color: backgrounndColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: TextStyles.textStyleFontExteraBold22White,
                ),
                verticalSpace(5),
                Text(
                  value,
                  style: TextStyles.textStyleFontExteraBold47White,
                ),
              ],
            ),
          ),
          Icon(
            icon,
            color: Colors.white,
            size: 50,
          )
        ],
      ),
    );
  }
}
