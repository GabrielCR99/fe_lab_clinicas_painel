import 'package:flutter/material.dart';
import 'package:flutter_getit/flutter_getit.dart';
import 'package:lab_clinicas_core/lab_clinicas_core.dart';
import 'package:signals_flutter/signals_flutter.dart';

import '../../models/painel_checkin_model.dart';
import 'painel_controller.dart';
import 'widgets/painel_main_widget.dart';
import 'widgets/password_tile.dart';

final class PainelPage extends StatefulWidget {
  const PainelPage({super.key});

  @override
  State<PainelPage> createState() => _PainelPageState();
}

final class _PainelPageState extends State<PainelPage> {
  final _controller = Injector.get<PainelController>();

  @override
  void initState() {
    super.initState();
    _controller.painelListener();
  }

  @override
  Widget build(BuildContext context) {
    final PainelCheckinModel? current;
    final PainelCheckinModel? lastCall;
    final List<PainelCheckinModel>? others;

    final panelList = _controller.painelData.watch(context);
    current = panelList.firstOrNull;

    if (panelList.isNotEmpty) {
      panelList.removeAt(0);
    }

    lastCall = panelList.firstOrNull;
    if (panelList.isNotEmpty) {
      panelList.removeAt(0);
    }

    others = panelList;

    return Scaffold(
      appBar: LabClinicasAppBar(),
      body: ListView(
        children: [
          const SizedBox(height: 32),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (lastCall != null)
                SizedBox(
                  width: MediaQuery.sizeOf(context).width * 0.4,
                  child: PainelMainWidget(
                    label: 'Senha anterior',
                    password: lastCall.password,
                    deskNumber:
                        lastCall.attendantDesk.toString().padLeft(2, '0'),
                    labelColor: orangeColor,
                    buttonColor: blueColor,
                  ),
                )
              else
                const SizedBox.shrink(),
              const SizedBox(width: 20),
              if (current != null)
                SizedBox(
                  width: MediaQuery.sizeOf(context).width * 0.4,
                  child: PainelMainWidget(
                    label: 'Chamando senha',
                    password: current.password,
                    deskNumber:
                        current.attendantDesk.toString().padLeft(2, '0'),
                    labelColor: blueColor,
                    buttonColor: orangeColor,
                  ),
                )
              else
                const SizedBox.shrink(),
            ],
          ),
          const SizedBox(height: 40),
          const Divider(color: orangeColor),
          const SizedBox(height: 30),
          const Center(
            child: Text(
              'Últimos chamados',
              style: TextStyle(
                color: orangeColor,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 16),
          Wrap(
            alignment: WrapAlignment.center,
            spacing: 10,
            runSpacing: 10,
            children: [
              for (final PainelCheckinModel(:password, :attendantDesk)
                  in others)
                PasswordTile(password: password, deskNumber: '$attendantDesk'),
            ],
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
