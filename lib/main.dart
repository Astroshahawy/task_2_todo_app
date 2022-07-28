import 'package:flutter/material.dart';

import 'app.dart';
import 'presentation/routes/app_router.dart';


void main() async {
  runApp(
    MyApp(
      appRouter: AppRouter(),
    ),
  );
}
