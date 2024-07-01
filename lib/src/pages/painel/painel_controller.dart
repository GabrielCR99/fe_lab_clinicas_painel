import 'package:flutter/foundation.dart';
import 'package:lab_clinicas_core/lab_clinicas_core.dart';
import 'package:signals_flutter/signals_flutter.dart';

import '../../models/painel_checkin_model.dart';
import '../../repositories/painel_checkin/painel_checkin_repository.dart';

final class PainelController extends MessagesControllerMixin {
  final painelData =
      listSignal<PainelCheckinModel>(const [], autoDispose: true);

  late final Connect<void, void> _painelConnect;
  VoidCallback? _socketDispose;
  final PainelCheckinRepository _painelCheckinRepository;

  PainelController({required PainelCheckinRepository painelCheckinRepository})
      : _painelCheckinRepository = painelCheckinRepository;

  void painelListener() {
    final (:channel, :dispose) = _painelCheckinRepository.openChannelSocker();
    final painelStream = _painelCheckinRepository.getTodayPanel(channel);

    _socketDispose = dispose;
    _painelConnect = connect(painelData);
    _painelConnect.from(painelStream);
  }

  void dispose() {
    _painelConnect.dispose();
    _socketDispose?.call();
  }
}
