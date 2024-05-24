import 'package:emschool_dashboard/bloc/entertainments_cubit/entertainments_cubit.dart';
import 'package:emschool_dashboard/core/extensions/extensions_routing.dart';
import 'package:emschool_dashboard/ui/entertainment_screen/add_entrtainment_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/enums/loading_status.dart';
import '../../core/helpers/spacing.dart';
import '../../core/widgets/loading_widget.dart';
import '../../core/widgets/title_widget.dart';
import 'entrtainments_tables_widget.dart';

class EntertainmentScreen extends StatefulWidget {
  const EntertainmentScreen({super.key});

  @override
  State<EntertainmentScreen> createState() => _EntertainmentScreenState();
}

class _EntertainmentScreenState extends State<EntertainmentScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    EntertainmentsCubit.get(context).getEntrtainments(page: 1);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EntertainmentsCubit, EntertainmentsState>(
      builder: (context, state) {
        return state.getEntertainmentsState == RequestState.loading
            ? const LoadingWidget()
            : Scaffold(
                body: SingleChildScrollView(
                  child: Column(
                    children: [
                      verticalSpace(10),
                      TitleWidget(
                        title: "قائمة الفعاليات",
                        titleButton: "اضافة جديد",
                        onPress: () {
                          context.navigatePush(const AddEntertainmentScreen());
                        },
                      ),
                      verticalSpace(10),
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: EntertainmentsTablesWidget(
                          list: state.entertainments!.items,
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
