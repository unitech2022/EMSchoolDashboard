import 'package:emschool_dashboard/bloc/entertainments_cubit/entertainments_cubit.dart';
import 'package:emschool_dashboard/bloc/news_cubit/news_cubit.dart';
import 'package:emschool_dashboard/core/extensions/extensions_routing.dart';
import 'package:emschool_dashboard/core/helpers/helper_functions.dart';
import 'package:emschool_dashboard/core/helpers/reponsiveness.dart';
import 'package:emschool_dashboard/core/helpers/spacing.dart';
import 'package:emschool_dashboard/core/theming/colors.dart';
import 'package:emschool_dashboard/core/theming/styles.dart';
import 'package:emschool_dashboard/core/widgets/custom_button.dart';
import 'package:emschool_dashboard/core/widgets/text_field_widget.dart';

import 'package:emschool_dashboard/models/news_model.dart';
import 'package:emschool_dashboard/models/type_education_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../models/stage_model.dart';
import '../../core/enums/loading_status.dart';
import '../../core/widgets/image_network_widget.dart';
import '../../core/widgets/loading_widget.dart';

class AddNewsScreen extends StatefulWidget {
  final bool isUpdate;
  final NewsModel? model;

  const AddNewsScreen({super.key, this.isUpdate = false, this.model});

  @override
  State<AddNewsScreen> createState() => _AddNewsScreenState();
}

class _AddNewsScreenState extends State<AddNewsScreen> {
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
    if (widget.isUpdate) {
      EntertainmentsCubit.get(context).changImage(widget.model!.image);

      _nameArController.text = widget.model!.nameAr;
      _nameEngController.text = widget.model!.nameEng;
      _descArController.text = widget.model!.descAr;
       _descEngController.text = widget.model!.descEng;
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
        body: BlocBuilder<NewsCubit, NewsState>(
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
                  

                    TextFormFieldWidget(
                      hintText: "العنوان بالعربية",
                      validator: (val) {},
                      controller: _nameArController,
                      isObscureText: false,
                      backgroundColor: Colors.white,
                    ),
                    verticalSpace(20),
                    TextFormFieldWidget(
                      controller: _nameEngController,
                      hintText: "العنوان بالانجليزية",
                      isObscureText: false,
                      textInputType: TextInputType.number,
                      validator: (val) {},
                      backgroundColor: Colors.white,
                    ),
               verticalSpace(20),


                    TextFormFieldWidget(
                      hintText: "التفاصيل بالعربية",
                      validator: (val) {},
                      controller: _descArController,
                      isObscureText: false,
                      backgroundColor: Colors.white,
                    ),
                    verticalSpace(20),
                    TextFormFieldWidget(
                      controller: _descEngController,
                      hintText: "التفاصيل بالانجليزية",
                      isObscureText: false,
                      textInputType: TextInputType.number,
                      validator: (val) {},
                      backgroundColor: Colors.white,
                    ),
               verticalSpace(20),
                    // image lesson

                    GestureDetector(
                      onTap: () async {
                        await NewsCubit.get(context).uploadImage();
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
                              NewsCubit.get(context)
                                  .updateNews(
                                      context: context,
                                      id: widget.model!.id,
                                      descAr: _descArController.text,
                                         descEng: _descEngController.text,
                                      nameAr: _nameArController.text,
                                        image: state.image,
                                      nameEng: _nameEngController.text);
                            } else {
                              NewsCubit.get(context).addNews(
                                  context: context,
                                   descAr: _descArController.text,
                                         descEng: _descEngController.text,
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
    if (_descArController.text.isEmpty || _descArController.text == "") {
      showToast(msg: "اكتب التفاصيل بالعربية", color: Colors.red);
      return false;
    }else  if (_descEngController.text.isEmpty || _descEngController.text == "") {
      showToast(msg: "اكتب التفاصيل بالانجليزية", color: Colors.red);
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
