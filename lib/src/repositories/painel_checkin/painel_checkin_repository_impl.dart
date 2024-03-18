import 'package:dio/dio.dart';
import 'package:intl/intl.dart';
import 'package:lab_clinicas_core/lab_clinicas_core.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import '../../core/env.dart';
import '../../models/painel_checkin_model.dart';
import './painel_checkin_repository.dart';

final class PainelCheckinRepositoryImpl implements PainelCheckinRepository {
  final RestClient restClient;

  const PainelCheckinRepositoryImpl({required this.restClient});

  @override
  Stream<List<PainelCheckinModel>> getTodayPanel(
    WebSocketChannel channel,
  ) async* {
    yield await _requestData();

    yield* channel.stream.asyncMap((_) => _requestData());
  }

  @override
  ({WebSocketChannel channel, void Function() dispose}) openChannelSocker() {
    final channel = WebSocketChannel.connect(
      Uri.parse('$wsBackendBaseUrl?tables=painelCheckin'),
    );

    return (channel: channel, dispose: channel.sink.close);
  }

  Future<List<PainelCheckinModel>> _requestData() async {
    final dateFormat = DateFormat('y-MM-d');
    final Response(:data!) = await restClient.auth.get<List<Object?>>(
      '/painelCheckin',
      queryParameters: {
        'time_called': dateFormat.format(DateTime.now()),
      },
    );

    return data.reversed
        .take(7)
        .cast<Map<String, dynamic>>()
        .map(PainelCheckinModel.fromJson)
        .toList();
  }
}
