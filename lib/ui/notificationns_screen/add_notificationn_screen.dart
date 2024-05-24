import 'package:emschool_dashboard/bloc/alerts_cubit/alert_cubit.dart';
import 'package:emschool_dashboard/core/enums/loading_status.dart';
import 'package:emschool_dashboard/core/extensions/extensions_routing.dart';
import 'package:emschool_dashboard/core/helpers/helper_functions.dart';
import 'package:emschool_dashboard/core/helpers/reponsiveness.dart';
import 'package:emschool_dashboard/core/helpers/spacing.dart';
import 'package:emschool_dashboard/core/theming/colors.dart';
import 'package:emschool_dashboard/core/widgets/custom_button.dart';
import 'package:emschool_dashboard/core/widgets/loading_widget.dart';
import 'package:emschool_dashboard/core/widgets/text_field_widget.dart';
import 'package:emschool_dashboard/models/alert_model.dart';
import 'package:emschool_dashboard/models/type_education_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../models/stage_model.dart';

class AddNotificationScreen extends StatefulWidget {
  final bool? isAll;
  final String? userId;

  const AddNotificationScreen({super.key, this.isAll = false, this.userId});

  @override
  State<AddNotificationScreen> createState() => _AddNotificationScreenState();
}

class _AddNotificationScreenState extends State<AddNotificationScreen> {
  TypeEducationModel? typeEducationValue;
  StageModel? stageModel;

  List<StageModel> stages = [];

  final _nameArController = TextEditingController();
  final _nameEngController = TextEditingController();
  final _descArController = TextEditingController();
  final _descEngController = TextEditingController();
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _nameArController.dispose();
    _nameEngController.dispose();
    _descArController.dispose();
    _descEngController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ColorsApp.mainColor,
        body: Center(
            child: SingleChildScrollView(
          child: Card(
            elevation: 10,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child: Container(
              width:
                  ResponsiveWidget.isSmallScreen(context) ? context.width : 500,
              margin: const EdgeInsets.all(20),
              padding: const EdgeInsets.all(30),
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(10)),
              child: Column(mainAxisSize: MainAxisSize.min, children: [
                // type Education

                Row(
                  children: [
                    Expanded(
                      child: TextFormFieldWidget(
                        hintText: " عنوان الاشعار باللغة العربية",
                        validator: (val) {},
                        controller: _nameArController,
                        isObscureText: false,
                        backgroundColor: Colors.white,
                      ),
                    ),
                    horizontalSpace(20),
                    Expanded(
                      child: TextFormFieldWidget(
                        controller: _nameEngController,
                        hintText: " عنوان الاشعار باللغة الانجليزية",
                        isObscureText: false,
                        textInputType: TextInputType.number,
                        validator: (val) {},
                        backgroundColor: Colors.white,
                      ),
                    ),
                  ],
                ),
                verticalSpace(20),

                Row(
                  children: [
                    Expanded(
                      child: TextFormFieldWidget(
                        hintText: "موضوع الاشعار باللغة العربية",
                        validator: (val) {},
                        controller: _descArController,
                        isObscureText: false,
                        backgroundColor: Colors.white,
                      ),
                    ),
                    horizontalSpace(20),
                    Expanded(
                      child: TextFormFieldWidget(
                        controller: _descEngController,
                        hintText: "موضوع الاشعار باللغة الانجليزية",
                        isObscureText: false,
                        textInputType: TextInputType.number,
                        validator: (val) {},
                        backgroundColor: Colors.white,
                      ),
                    ),
                  ],
                ),
                verticalSpace(20),
                BlocBuilder<AlertCubit, AlertState>(
                  builder: (context, state) {
                    return state.changeDataState==RequestState.loading?
                    
                    const LoadingWidget()
                    :  CustomButton(
                        title: "ارسال",
                        onPressed: () {
                          if (isValidate(context: context)) {
                            AlertModel alertModel = AlertModel(
                                id: 0,
                                userId: widget.isAll! ? 'All' : widget.userId!,
                                titleAr: _nameArController.text,
                                titleEng: _nameEngController.text,
                                descriptionAr: _descArController.text,
                                descriptionEng: _descEngController.text,
                                viewed: false,
                                pageId: 0,
                                type: 1,
                                createdAt: "createdAt");

                            if (widget.isAll!) {
                              AlertCubit.get(context).addAlertAll(alertModel,context: context);
                            } else {
                              AlertCubit.get(context)
                                  .addAlertToUser(alertModel,context: context);
                            }
                          }
                        });
                  },
                ),
              ]),
            ),
          ),
        )));
  }

  bool isValidate({context}) {
    if (_nameArController.text.isEmpty || _nameArController.text == "") {
      showToast(msg: "اكتب العنوان باللغة العربية", color: Colors.red);
      return false;
    } else if (_nameEngController.text.isEmpty ||
        _nameEngController.text == "") {
      showToast(msg: "اكتب العنوان باللغة الانجليزية", color: Colors.red);
      return false;
    } else if (_descArController.text.isEmpty || _descArController.text == "") {
      showToast(msg: "اكتب الشرح باللغة العربية", color: Colors.red);
      return false;
    } else if (_descEngController.text.isEmpty ||
        _descEngController.text == "") {
      showToast(msg: "اكتب الشرح باللغة الانجليزية", color: Colors.red);
      return false;
    } else {
      return true;
    }
  }
}
