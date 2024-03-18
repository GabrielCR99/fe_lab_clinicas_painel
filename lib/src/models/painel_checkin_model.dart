import 'package:json_annotation/json_annotation.dart';

part 'painel_checkin_model.g.dart';

@JsonSerializable(createToJson: false)
final class PainelCheckinModel {
  final String id;
  final String password;
  @JsonKey(name: 'attendant_desk')
  final int attendantDesk;

  const PainelCheckinModel({
    required this.id,
    required this.password,
    required this.attendantDesk,
  });

  factory PainelCheckinModel.fromJson(Map<String, dynamic> json) =>
      _$PainelCheckinModelFromJson(json);
}
