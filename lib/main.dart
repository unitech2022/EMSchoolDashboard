import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:emschool_dashboard/core/routing/app_router.dart';
import 'package:emschool_dashboard/emschool_web.dart';
import 'package:flutter/material.dart';

import 'core/network/my_http_overrides.dart';
import 'core/utlis/session_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
 HttpOverrides.global = MyHttpOverrides();
  await EasyLocalization.ensureInitialized();
await SessionManager().getUserData();
  runApp(EasyLocalization(
      supportedLocales: const [Locale("ar"), Locale("en")],
      path: "assets/i18n",
      // <-- change the path of the translation files
      fallbackLocale: const Locale("ar"),
      startLocale: const Locale("ar"),
      child: EMSchoolWeb(
        appRouter: AppRouter(),
      )));
}
