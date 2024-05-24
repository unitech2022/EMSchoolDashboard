import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bloc/app_cubit/app_cubit.dart';
import '../../../core/helpers/reponsiveness.dart';
import '../../../core/helpers/spacing.dart';
import '../../../core/theming/colors.dart';
import '../../../core/theming/styles.dart';
import '../../../core/utlis/app_model.dart';

class SidMenu extends StatelessWidget {
  final int currentIndex;

  const SidMenu({super.key, required this.currentIndex});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppState>(
      builder: (context, state) {
        return Container(
          color: ColorsApp.boomSheetColor,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                        height: 50,
                        width: 50,
                        decoration: const BoxDecoration(shape: BoxShape.circle),
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(40),
                            child: Image.asset("assets/images/app_icon.png"))),
                   
                 ResponsiveWidget.isLargeScreen(context)?   Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Text(
                                              "مدرسة ادفا الصباحية",
                                              style: TextStyles.textStyleFontSemiBold15White,
                                            ),
                        )):const SizedBox()
                  ],
                ),
                verticalSpace(40),
                Column(
                  children: listItems
                      .map((e) => GestureDetector(
                            onTap: () {
                              AppCubit.get(context)
                                  .changeIndexSidMenu(e["id"].toInt());
                            },
                            child: Container(
                              height: 50,
                              width: double.infinity,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: state.indexSideMenu == e["id"]
                                      ? ColorsApp.mainColor
                                      : Colors.transparent),
                              alignment: Alignment.center,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(
                                    e["icon"],
                                    color: Colors.white,
                                  ),
                                  horizontalSpace(
                                      ResponsiveWidget.isMediumScreen(context)
                                          ? 0
                                          : 15),
                                  ResponsiveWidget.isMediumScreen(context)
                                      ? const SizedBox()
                                      : Text(
                                          e["name"],
                                          style: TextStyles
                                              .textStyleFontBold14White,
                                        ),
                                ],
                              ),
                            ),
                          ))
                      .toList(),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
