import 'package:frontend/model/entities/asn.dart';

class ReceptionCreated {
  int id;
  int asnId;
  Asn asn;

  ReceptionCreated({required this.id, required this.asnId, required this.asn});

  ReceptionCreated.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        asnId = json['asnId'],
        asn = Asn.fromJson(json['asn']);
}
