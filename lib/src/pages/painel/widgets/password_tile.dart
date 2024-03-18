import 'package:flutter/material.dart';
import 'package:lab_clinicas_core/lab_clinicas_core.dart';

final class PasswordTile extends StatelessWidget {
  final String password;
  final String deskNumber;

  const PasswordTile({
    required this.password,
    required this.deskNumber,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border.fromBorderSide(BorderSide(color: orangeColor)),
        borderRadius: BorderRadius.all(Radius.circular(16)),
      ),
      child: Column(
        children: [
          Text(
            password,
            style: const TextStyle(
              color: blueColor,
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            'GUICHÊ $deskNumber',
            style: const TextStyle(
              color: orangeColor,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
