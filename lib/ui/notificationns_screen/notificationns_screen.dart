import 'package:emschool_dashboard/bloc/alerts_cubit/alert_cubit.dart';
import 'package:emschool_dashboard/core/extensions/extensions_routing.dart';
import 'package:emschool_dashboard/ui/notificationns_screen/add_notificationn_screen.dart';
import 'package:emschool_dashboard/ui/notificationns_screen/alerts_tabels.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/enums/loading_status.dart';
import '../../core/helpers/spacing.dart';
import '../../core/widgets/loading_widget.dart';
import '../../core/widgets/title_widget.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    AlertCubit.get(context).getAlerts(page: 1);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AlertCubit, AlertState>(
      builder: (context, state) {
        return state.getAlertState == RequestState.loading
            ? const LoadingWidget()
            : Scaffold(
                body: SingleChildScrollView(
                  child: Column(
                    children: [
                      verticalSpace(10),
                      TitleWidget(
                        title: "قائمة الاشعار",
                        titleButton: "اشعار للعملاء",
                        onPress: () {
                          context.navigatePush(AddNotificationScreen(
                            isAll: true,
                          
                          ));
                        },
                      ),
                      verticalSpace(10),
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: AlertsTablesWidget(
                          list: state.alertsResponse!.items,
                          type: 0,
                        ),
                      )
                    ],
                  ),
                ),
              );
      },
    );
  }
}
