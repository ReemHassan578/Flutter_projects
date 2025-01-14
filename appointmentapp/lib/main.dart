
import 'package:appointmentapp/core/routing/app_router.dart';
import 'package:appointmentapp/doc_app.dart';
import 'package:flutter/material.dart';

import 'core/di/dependency_injection.dart';

void main() {
  setupGetIt();
  runApp(DocApp(appRouter: AppRouter()));
}

