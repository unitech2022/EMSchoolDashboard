import 'package:emschool_dashboard/bloc/auth_cubit/auth_cubit.dart';
import 'package:emschool_dashboard/core/enums/loading_status.dart';

import 'package:emschool_dashboard/core/helpers/helper_functions.dart';
import 'package:emschool_dashboard/core/helpers/reponsiveness.dart';
import 'package:emschool_dashboard/core/helpers/spacing.dart';

import 'package:emschool_dashboard/core/theming/colors.dart';
import 'package:emschool_dashboard/core/theming/styles.dart';
import 'package:emschool_dashboard/core/widgets/circular_progress.dart';
import 'package:emschool_dashboard/core/widgets/custom_button.dart';
import 'package:emschool_dashboard/core/widgets/text_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isObscureText = true;

  final _userNameController = TextEditingController(text: "adminschool");
  final _passwordController = TextEditingController(text: "Abc123@");

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _passwordController.dispose();
    _userNameController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        return Scaffold(
            backgroundColor: Colors.white,
            body: SafeArea(
              child: Container(
                color: ColorsApp.mainColor,
                child: Center(
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 30),
                    height: 500,
                    width: ResponsiveWidget.isSmallScreen(context)
                        ? double.infinity
                        : 500,
                    child: Card(
                      elevation: 10,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      child: Padding(
                        padding: const EdgeInsets.all(30),
                        child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              verticalSpace(10),
                              Text(
                                "مرحبا بك في لوحة التحكم والادارة - EMSchool",
                                textAlign: TextAlign.center,
                                style: TextStyles.textStyleFontBold20black,
                              ),
                              verticalSpace(50),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Expanded(
                                      child: Container(
                                    height: .8,
                                    color: Colors.grey,
                                  )),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20),
                                    child: Text(
                                      "تسجيل الدخول",
                                      style:
                                          TextStyles.textStyleFontBold20black,
                                    ),
                                  ),
                                  Expanded(
                                      child: Container(
                                    height: .8,
                                    color: Colors.grey,
                                  )),
                                ],
                              ),
                              verticalSpace(30),
                              TextFormFieldWidget(
                                controller: _userNameController,
                                  backgroundColor: Colors.transparent,
                                  textInputType: TextInputType.emailAddress,
                                  hintText: "البريد الإلكتروني ",
                                  isObscureText: false,
                                  validator: (valu) {}),
                              verticalSpace(10),
                              TextFormFieldWidget(
                                controller: _passwordController,
                                  backgroundColor: Colors.transparent,
                                  hintText: "الرقم السري",
                                  textInputType: TextInputType.visiblePassword,
                                  isObscureText: isObscureText,
                                  suffixIcon: IconButton(
                                    icon: Icon(isObscureText
                                        ? Icons.visibility_off
                                        : Icons.visibility),
                                    onPressed: () {
                                      isObscureText = !isObscureText;
                                      setState(() {});
                                    },
                                  ),
                                  validator: (valu) {}),
                              verticalSpace(30),
                            state.loginSignUpState==RequestState.loading?
                            
                            const CustomCircularProgress(color: ColorsApp.mainColor,)
                            :  CustomButton(
                                  title: "دخول",
                                  onPressed: () {
                                    if (isValidate(context: context)) {
                                      AuthCubit.get(context).loginAdmin(
                                         context,
                                          userName: _userNameController.text,
                                          password: _passwordController.text);
                                    }
                                    // context.navigateToNamed(Routes.home);
                                  })
                            ]),
                      ),
                    ),
                  ),
                ),
              ),
            ));
      },
    );
  }

  bool isValidate({context}) {
    if (_userNameController.text.isEmpty || _userNameController.text == "") {
      showToast(msg: "اكتب الاسم", color: Colors.red);
      return false;
    } else if (_passwordController.text.isEmpty ||
        _passwordController.text == "") {
      showToast(msg: "اكتب الرقم السري ", color: Colors.red);
      return false;
    }
    return true;
  }
}
