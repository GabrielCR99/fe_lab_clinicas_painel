import 'package:flutter/material.dart';
import 'package:flutter_getit/flutter_getit.dart';
import 'package:lab_clinicas_core/lab_clinicas_core.dart';

import 'src/binding/lab_clinicas_application_binding.dart';
import 'src/pages/login/login_router.dart';
import 'src/pages/painel/painel_router.dart';
import 'src/pages/splash/splash_page.dart';

final class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return LabClinicasCoreConfig(
      bindings: LabClinicasApplicationBinding(),
      routes: const [LoginRouter(), PainelRouter()],
      pageBuilders: [
        FlutterGetItPageBuilder(page: (_) => const SplashPage(), path: '/'),
      ],
      title: 'Lab Clinicas Painel',
    );
  }
}
