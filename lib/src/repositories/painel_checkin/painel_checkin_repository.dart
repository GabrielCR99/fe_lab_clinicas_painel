import 'package:web_socket_channel/web_socket_channel.dart';

import '../../models/painel_checkin_model.dart';

abstract interface class PainelCheckinRepository {
  ({WebSocketChannel channel, void Function() dispose}) openChannelSocker();
  Stream<List<PainelCheckinModel>> getTodayPanel(WebSocketChannel channel);
}
