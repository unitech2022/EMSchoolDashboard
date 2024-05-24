import 'package:emschool_dashboard/core/extensions/extensions_routing.dart';
import 'package:emschool_dashboard/core/widgets/loading_widget.dart';
import 'package:emschool_dashboard/ui/dashboard_screen/recent_users.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/users_cubit/users_cubit.dart';
import '../../core/enums/loading_status.dart';
import '../../core/helpers/pagination_widget.dart';
import '../../core/helpers/spacing.dart';
import '../../core/routing/routes.dart';
import '../../core/utlis/api_constatns.dart';
import '../../core/widgets/title_widget.dart';

class TeachersScreen extends StatefulWidget {
  const TeachersScreen({super.key});

  @override
  State<TeachersScreen> createState() => _TeachersScreenState();
}

class _TeachersScreenState extends State<TeachersScreen> {
  int selectPage = 1;
 @override
  void initState() {
    super.initState();
   if(mounted){
     UsersCubit.get(context).getUsers(page: 1, role: ApiConstants.teacherRole,classRoomId: 0);
   }
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
                        title: "قائمة المدرسين",
                        titleButton: "اضافة جديد",
                        onPress: () {
                          context.navigateToNamed(Routes.addUser);
                        },
                      ),
                      verticalSpace(10),
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: RecentUsers(users: state.teachersResponse!.items,type: 1,),
                      ),
                             verticalSpace(20),
                      PaginationWidget(
                          selectPage: selectPage,
                          totalPages: state.teachersResponse!.totalPages,
                          onChange: (page) {
                            if (selectPage != page) {
                              selectPage = page;
                              UsersCubit.get(context).getUsers(
                                  page: page, role: ApiConstants.teacherRole);
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