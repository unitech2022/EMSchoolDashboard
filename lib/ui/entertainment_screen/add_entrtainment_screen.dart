import 'package:emschool_dashboard/bloc/entertainments_cubit/entertainments_cubit.dart';
import 'package:emschool_dashboard/core/extensions/extensions_routing.dart';
import 'package:emschool_dashboard/core/helpers/helper_functions.dart';
import 'package:emschool_dashboard/core/helpers/reponsiveness.dart';
import 'package:emschool_dashboard/core/helpers/spacing.dart';
import 'package:emschool_dashboard/core/theming/colors.dart';
import 'package:emschool_dashboard/core/theming/styles.dart';
import 'package:emschool_dashboard/core/widgets/custom_button.dart';
import 'package:emschool_dashboard/core/widgets/text_field_widget.dart';
import 'package:emschool_dashboard/models/entertainment_model.dart';
import 'package:emschool_dashboard/models/type_education_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../models/stage_model.dart';
import '../../core/enums/loading_status.dart';
import '../../core/widgets/image_network_widget.dart';
import '../../core/widgets/loading_widget.dart';

class AddEntertainmentScreen extends StatefulWidget {
  final bool isUpdate;
  final EntertainmentModel? model;

  const AddEntertainmentScreen({super.key, this.isUpdate = false, this.model});

  @override
  State<AddEntertainmentScreen> createState() => _AddEntertainmentScreenState();
}

class _AddEntertainmentScreenState extends State<AddEntertainmentScreen> {
  TypeEducationModel? typeEducationValue;
  StageModel? stageModel;

  List<StageModel> stages = [];

  final _nameArController = TextEditingController();
  final _nameEngController = TextEditingController();
  final _linkController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.isUpdate) {
      EntertainmentsCubit.get(context).changImage(widget.model!.image);

      _nameArController.text = widget.model!.nameAr;
      _nameEngController.text = widget.model!.nameEng;
      _linkController.text = widget.model!.link;
    }
  }

  @override
  void dispose() {
    super.dispose();
    _nameArController.dispose();
    _nameEngController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ColorsApp.mainColor,
        body: BlocBuilder<EntertainmentsCubit, EntertainmentsState>(
          builder: (context, state) {
            return Center(
                child: SingleChildScrollView(
              child: Card(
                elevation: 10,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                child: Container(
                  width: ResponsiveWidget.isSmallScreen(context)
                      ? context.width
                      : 500,
                  margin: const EdgeInsets.all(20),
                  padding: const EdgeInsets.all(30),
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(10)),
                  child: Column(mainAxisSize: MainAxisSize.min, children: [
                    // type Education

                    TextFormFieldWidget(
                      hintText: "الاسم بالعربية",
                      validator: (val) {},
                      controller: _nameArController,
                      isObscureText: false,
                      backgroundColor: Colors.white,
                    ),
                    verticalSpace(20),
                    TextFormFieldWidget(
                      controller: _nameEngController,
                      hintText: "الاسم بالانجليزية",
                      isObscureText: false,
                      textInputType: TextInputType.number,
                      validator: (val) {},
                      backgroundColor: Colors.white,
                    ),
                    verticalSpace(20),
                    TextFormFieldWidget(
                      controller: _linkController,
                      hintText: "لينك",
                      isObscureText: false,
                      textInputType: TextInputType.number,
                      validator: (val) {},
                      backgroundColor: Colors.white,
                    ),
                    verticalSpace(20),
                    // image lesson

                    GestureDetector(
                      onTap: () async {
                        await EntertainmentsCubit.get(context).uploadImage();
                      },
                      child: Column(
                        children: [
                          Text(
                            state.image == null
                                ? "اضافة صورة "
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

                    verticalSpace(40),
                    CustomButton(
                        title: !widget.isUpdate ? "انشاء" : "تعديل",
                        onPressed: () {
                          if (isValidate(context: context,image: state.image)) {
                            if (widget.isUpdate) {
                              EntertainmentsCubit.get(context)
                                  .updateEntrtainment(
                                      context: context,
                                      id: widget.model!.id,
                                      link: _linkController.text,
                                      nameAr: _nameArController.text,
                                        image: state.image,
                                      nameEng: _nameEngController.text);
                            } else {
                              EntertainmentsCubit.get(context).addEntrtainment(
                                  context: context,
                                  link: _linkController.text,
                                  nameAr: _nameArController.text,
                                  image: state.image,
                                  nameEng: _nameEngController.text);
                            }
                          }
                        }),
                  ]),
                ),
              ),
            ));
          },
        ));
  }

  bool isValidate({context,image}) {
    if (_linkController.text.isEmpty || _linkController.text == "") {
      showToast(msg: "اكتب اللينك", color: Colors.red);
      return false;
    } else if (_nameArController.text.isEmpty || _nameArController.text == "") {
      showToast(msg: "اكتب الاسم باللغة العربية", color: Colors.red);
      return false;
    } else if (_nameEngController.text.isEmpty ||
        _nameEngController.text == "") {
      showToast(msg: "اكتب الاسم باللغة الانجليزية", color: Colors.red);
      return false;
    } else if ( image== null) {
      showToast(msg: "اختار صورة ");
      return false;
    } else {
      return true;
    }
  }
}
