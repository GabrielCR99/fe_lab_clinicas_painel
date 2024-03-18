import 'package:flutter/material.dart';
import 'package:lab_clinicas_core/lab_clinicas_core.dart';

final class PainelMainWidget extends StatelessWidget {
  final String label;
  final String password;
  final String deskNumber;
  final Color labelColor;
  final Color buttonColor;

  const PainelMainWidget({
    required this.label,
    required this.password,
    required this.deskNumber,
    required this.labelColor,
    required this.buttonColor,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border.fromBorderSide(BorderSide(color: orangeColor)),
        borderRadius: BorderRadius.all(Radius.circular(16)),
      ),
      margin: const EdgeInsets.all(10),
      child: Column(
        children: [
          Text(label, style: titleStyle.copyWith(color: labelColor)),
          Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 24),
            decoration: BoxDecoration(
              color: buttonColor,
              borderRadius: const BorderRadius.all(Radius.circular(16)),
            ),
            child: Text(
              password,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 48,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 24),
          Text('Guichê', style: titleStyle.copyWith(color: labelColor)),
          Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 24),
            decoration: BoxDecoration(
              color: buttonColor,
              borderRadius: const BorderRadius.all(Radius.circular(16)),
            ),
            child: Text(
              deskNumber,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 48,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
