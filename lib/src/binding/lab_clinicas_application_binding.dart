import 'package:flutter_getit/flutter_getit.dart';
import 'package:lab_clinicas_core/lab_clinicas_core.dart';

import '../core/env.dart';

final class LabClinicasApplicationBinding extends ApplicationBindings {
  @override
  List<Bind<Object>> bindings() =>
      [Bind.lazySingleton((_) => RestClient(baseUrl: backendBaseUrl))];
}
