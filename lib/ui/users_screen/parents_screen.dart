import 'package:emschool_dashboard/bloc/users_cubit/users_cubit.dart';
import 'package:emschool_dashboard/core/enums/loading_status.dart';
import 'package:emschool_dashboard/core/extensions/extensions_routing.dart';
import 'package:emschool_dashboard/core/helpers/pagination_widget.dart';
import 'package:emschool_dashboard/core/helpers/spacing.dart';
import 'package:emschool_dashboard/core/routing/routes.dart';
import 'package:emschool_dashboard/core/utlis/api_constatns.dart';
import 'package:emschool_dashboard/core/widgets/title_widget.dart';
import 'package:emschool_dashboard/ui/dashboard_screen/recent_users.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/widgets/loading_widget.dart';

class ParentssScreen extends StatefulWidget {
  const ParentssScreen({super.key});

  @override
  State<ParentssScreen> createState() => _ParentssScreenState();
}

class _ParentssScreenState extends State<ParentssScreen> {
  int selectPage = 1;
  @override
  void initState() {
    super.initState();
    UsersCubit.get(context).getUsers(page: 1, role: ApiConstants.parentRole,classRoomId: 0);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UsersCubit, UsersState>(
      builder: (context, state) {
        return state.getUsersState == RequestState.loading
            ? const LoadingWidget()
            : Scaffold(
                body: SingleChildScrollView(
                  child: Column(
                    children: [
                      verticalSpace(10),
                      TitleWidget(
                        title: "قائمة آولياء الآمور",
                        isButton: false,
                        titleButton: "اضافة جديد",
                        onPress: () {
                          context.navigateToNamed(Routes.addUser);
                        },
                      ),
                      verticalSpace(10),
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: state.getUsersState == RequestState.loaded
                            ? RecentUsers(
                                users: state.parentsResponse!.items,
                                type: 0,
                              )
                            : const LoadingWidget(),
                      ),
                      verticalSpace(20),
                      PaginationWidget(
                          selectPage: selectPage,
                          totalPages: state.parentsResponse!.totalPages,
                          onChange: (page) {
                            if (selectPage != page) {
                              selectPage = page;
                              UsersCubit.get(context).getUsers(
                                  page: page, role: ApiConstants.parentRole);
                            }
                          })
                    ],
                  ),
                ),
              );
      },
    );
  }
}
