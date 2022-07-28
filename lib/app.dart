import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'constants/constants.dart';
import 'presentation/routes/app_router.dart';

class MyApp extends StatelessWidget {
  final AppRouter appRouter;
  const MyApp({
    Key? key,
    required this.appRouter,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ),
    );
    return MaterialApp(
      title: 'Todo App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Poppins',
        textTheme: const TextTheme(
          button: TextStyle(
            fontWeight: FontWeight.bold,
          ),
          bodyText2: TextStyle(
            fontWeight: FontWeight.bold,
          ),
          subtitle1: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
        ),
        scaffoldBackgroundColor: Colors.white,
        pageTransitionsTheme: const PageTransitionsTheme(
          builders: <TargetPlatform, PageTransitionsBuilder>{
            TargetPlatform.android: CupertinoPageTransitionsBuilder(),
          },
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            primary: kButtonColor,
          ),
        ),
        timePickerTheme: const TimePickerThemeData().copyWith(
          dialHandColor: kButtonColor,
          hourMinuteTextColor: kButtonColor,
          dayPeriodTextColor: kButtonColor,
          entryModeIconColor: kButtonColor,
          helpTextStyle: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
            color: kButtonColor,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
      ),
      onGenerateRoute: appRouter.generateRoutes,
    );
  }
}
