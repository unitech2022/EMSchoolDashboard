import 'package:easy_localization/easy_localization.dart';
import 'package:emschool_dashboard/bloc/alerts_cubit/alert_cubit.dart';
import 'package:emschool_dashboard/bloc/auth_cubit/auth_cubit.dart';
import 'package:emschool_dashboard/bloc/class_rooms_cubit/class_rooms_cubit.dart';
import 'package:emschool_dashboard/bloc/entertainments_cubit/entertainments_cubit.dart';
import 'package:emschool_dashboard/bloc/events_cubit/events_cubit.dart';
import 'package:emschool_dashboard/bloc/home_cubit/home_cubit.dart';
import 'package:emschool_dashboard/bloc/lessons_cubit/lessons_cubit.dart';
import 'package:emschool_dashboard/bloc/news_cubit/news_cubit.dart';
import 'package:emschool_dashboard/bloc/schedules_cubit/schedules_cubit.dart';
import 'package:emschool_dashboard/bloc/stages_cubit/stages_cubit.dart';
import 'package:emschool_dashboard/bloc/subjects_cubit/subjects_cubit.dart';
import 'package:emschool_dashboard/bloc/type_educations_cubit/type_educations_cubit.dart';
import 'package:emschool_dashboard/bloc/users_cubit/users_cubit.dart';
import 'package:emschool_dashboard/core/api_service/api_service.dart';
import 'package:emschool_dashboard/core/routing/app_router.dart';
import 'package:emschool_dashboard/core/routing/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/app_cubit/app_cubit.dart';
import 'core/theming/colors.dart';

class EMSchoolWeb extends StatelessWidget {
  final AppRouter appRouter;
  const EMSchoolWeb({super.key, required this.appRouter});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AppCubit>(create: (BuildContext context) => AppCubit()),
        BlocProvider<AuthCubit>(create: (BuildContext context) => AuthCubit()),
        BlocProvider<HomeCubit>(create: (BuildContext context) => HomeCubit()),
        BlocProvider<UsersCubit>(
            create: (BuildContext context) => UsersCubit()),
        BlocProvider<TypeEducationsCubit>(
            create: (BuildContext context) => TypeEducationsCubit()),
        BlocProvider<StagesCubit>(
            create: (BuildContext context) => StagesCubit()),
        BlocProvider<SubjectsCubit>(
            create: (BuildContext context) =>
                SubjectsCubit(apiService: ApiApiService())),
        BlocProvider<LessonsCubit>(
            create: (BuildContext context) =>
                LessonsCubit(apiService: ApiApiService())),
        BlocProvider<ClassRoomsCubit>(
            create: (BuildContext context) => ClassRoomsCubit()),
        BlocProvider<EventsCubit>(
            create: (BuildContext context) =>
                EventsCubit(apiService: ApiApiService())),
        BlocProvider<EntertainmentsCubit>(
            create: (BuildContext context) =>
                EntertainmentsCubit(apiService: ApiApiService())),
                 BlocProvider<SchedulesCubit>(
            create: (BuildContext context) =>
                SchedulesCubit()),
                 BlocProvider<AlertCubit>(
            create: (BuildContext context) =>
                AlertCubit()),
                 BlocProvider<NewsCubit>(
            create: (BuildContext context) =>
                NewsCubit(apiService: ApiApiService()))
      ],
      child: MaterialApp(
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        debugShowCheckedModeBanner: false,
        title: 'EMSchool Dashboard',
        theme: ThemeData(
          appBarTheme: const AppBarTheme(
              backgroundColor: Colors.white,
              elevation: 0,
              systemOverlayStyle: SystemUiOverlayStyle(
                  statusBarIconBrightness: Brightness.light)),
          primaryColor: ColorsApp.mainColor,
          scaffoldBackgroundColor: Colors.white,
        ),
        initialRoute: Routes.splashScreen,
        onGenerateRoute: appRouter.generateRoute,
      ),
    );
  }
}
