import 'package:emschool_dashboard/bloc/events_cubit/events_cubit.dart';
import 'package:emschool_dashboard/core/extensions/extensions_routing.dart';
import 'package:emschool_dashboard/ui/events_screen/events_tables_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/enums/loading_status.dart';
import '../../core/helpers/helper_functions.dart';
import '../../core/helpers/spacing.dart';
import '../../core/theming/colors.dart';
import '../../core/theming/styles.dart';
import '../../core/widgets/custom_button.dart';
import '../../core/widgets/image_network_widget.dart';
import '../../core/widgets/loading_widget.dart';
import '../../core/widgets/title_widget.dart';

class EventsScreen extends StatefulWidget {
  const EventsScreen({super.key});

  @override
  State<EventsScreen> createState() => _EventsScreenState();
}

class _EventsScreenState extends State<EventsScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    EventsCubit.get(context).getEvents(page: 1);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EventsCubit, EventsState>(
      builder: (context, state) {
        return state.getEventsState == RequestState.loading
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
                          bottomAddDataEvent(context);
                        },
                      ),
                      verticalSpace(10),
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: EventsTablesWidget(
                          list: state.eventsResponse!.items,
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
  void bottomAddDataEvent(BuildContext context, {eventId, isUpdate = false}) {
    showBottomSheetWidget(context, BlocBuilder<EventsCubit, EventsState>(
      builder: (contextBloc, state) {
        return StatefulBuilder(
          builder: (BuildContext context,
              void Function(void Function()) setStateSheet) {
            return Container(
              padding: const EdgeInsets.only(
                  top: 40, left: 30, right: 30, bottom: 20),
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15))),
              height: context.height / 2,
              width: double.infinity,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // icon back
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(
                          Icons.close,
                          color: Colors.black,
                        ),
                        onPressed: () {
                          pop(context);
                        },
                      ),
                      const Spacer(),
                      Text(
                        "اضافة",
                        style: TextStyles.textStyleFontMeduim20Black,
                      ),
                      const Spacer()
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  // body ======================================================================
// image
                  GestureDetector(
                    onTap: () async {
                      await EventsCubit.get(context).uploadImage();
                    },
                    child: Column(
                      children: [
                        Text(
                          state.image == null
                              ? "اضافة صورة الدرس"
                              : "تم اضافة الصورة",
                          style: TextStyles.textStyleFontBold20mainColor
                              .copyWith(
                                  color: state.image == null
                                      ? ColorsApp.mainColor
                                      : Colors.green),
                        ),
                        verticalSpace(10),
                        state.image == null
                            ? const Icon(
                                Icons.photo,
                                color: ColorsApp.mainColor,
                                size: 100,
                              )
                            : state.uploadImageState == RequestState.loading
                                ? const LoadingWidget()
                                : SizedBox(
                                    width: 250,
                                    height: 150,
                                    child: ImageNetworkWidget(
                                      image: state.image!,
                                      width: 250,
                                      height: 150,
                                    ))
                      ],
                    ),
                  ),
                  verticalSpace(20),
                  state.changeDataState == RequestState.loading
                      ? const LoadingWidget()
                      : CustomButton(
                          title: isUpdate ? "تعديل" : "اضافة",
                          onPressed: () {
                            if (state.image != null) {
                              if (isUpdate) {
                                EventsCubit.get(context).updateEvent(
                                    context: context,
                                    image: state.image,
                                    id: eventId);
                              } else {
                                EventsCubit.get(context).addEvent(
                                  context: context,
                                  image: state.image,
                                );
                              }
                            }
                          })
                ],
              ),
            );
          },
        );
      },
    ));
  }
