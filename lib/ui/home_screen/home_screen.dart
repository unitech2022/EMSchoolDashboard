

import 'package:emschool_dashboard/bloc/app_cubit/app_cubit.dart';
import 'package:emschool_dashboard/core/helpers/reponsiveness.dart';
import 'package:emschool_dashboard/core/theming/colors.dart';
import 'package:emschool_dashboard/core/theming/styles.dart';
import 'package:emschool_dashboard/core/utlis/app_model.dart';
import 'package:emschool_dashboard/core/widgets/image_network_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/utils.dart';
import '../../bloc/home_cubit/home_cubit.dart';
import '../../core/helpers/spacing.dart';
import 'components/side_menu.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _key = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    HomeCubit.get(context).getHomeData();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppState>(
      builder: (context, state) {
        return Scaffold(
          key: _key,
          drawer: ResponsiveWidget.isSmallScreen(context)
              ? Drawer(
                  child: SingleChildScrollView(
                    child: Container(
                      decoration: const BoxDecoration(
                        color: ColorsApp.boomSheetColor,
                      ),
                      child: Column(
                        children: [
                          SizedBox(
                            height: context.height / 3,
                            width: double.infinity,
                            child: Image.asset(
                              "assets/images/app_icon.png",
                              height: double.infinity,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                          ),
                          verticalSpace(30),
                          Column(
                            children: listItems
                                .map((e) => GestureDetector(
                                      onTap: () {
                                        AppCubit.get(context)
                                            .changeIndexSidMenu(
                                                e["id"].toInt());
                                      },
                                      child: Container(
                                        height: 60,
                                        // ignore: prefer_const_constructors
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 20),
                                        alignment: Alignment.center,
                                        decoration: const BoxDecoration(
                                          
                                            border: Border(
                                                bottom: BorderSide(
                                                    color: Colors.white,
                                                    width: 1))),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Icon(
                                              e["icon"],
                                              color: Colors.white,
                                            ),
                                            horizontalSpace(15),
                                            Text(
                                              e["name"],
                                              style: TextStyles
                                                  .textStyleFontBold14White,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ))
                                .toList(),
                          )
                        ],
                      ),
                    ),
                  ),
                )
              : null,
          body: SafeArea(
              child: Row(
            children: [
              // sideMenue
              ResponsiveWidget.isSmallScreen(context)
                  ? const SizedBox()
                  : Expanded(
                      child: SidMenu(
                        currentIndex: state.indexSideMenu,
                      ),
                    ),
              // body
              Expanded(
                  flex: 6,
                  child: Column(children: [
                    NAVBarWidget(
                      onPressed: () {
                        _key.currentState!.openDrawer();
                      },
                    ),

                    //screens
                    Expanded(
                        child: IndexedStack(
                      index: state.indexSideMenu,
                      children: screens,
                    ))
                  ]))
            ],
          )),
        );
      },
    );
  }
}

class NAVBarWidget extends StatelessWidget {
  final void Function() onPressed;

  const NAVBarWidget({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 80,
        width: double.infinity,
        color: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
           Row(
            children: [
               ResponsiveWidget.isSmallScreen(context)
                ? IconButton(
                    onPressed: onPressed,
                    icon: const Icon(
                      Icons.menu,
                      color: Colors.black,
                    ))
                : const SizedBox(),
            horizontalSpace(20),
            Text(
              "لوحة التحكم",
              style: TextStyles.textStyleFontBold20black,
            ),
            ],
           ),
            const ImageNetworkWidget(image:"",errorWidget: Icon(Icons.person,size: 30,color: Colors.black,), height: 50, width: 50)
          ],
        ));
  }
}
