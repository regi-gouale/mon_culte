import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mon_culte/data/models/person_model.dart';

class MinistryModel {
  final String ministry;
  final PersonModel leader;

  DocumentReference? reference;

  MinistryModel({required this.ministry, required this.leader, this.reference});

  factory MinistryModel.fromJson(Map<String, dynamic> json) =>
      _ministryFromJson(json);

  Map<String, dynamic> toJson() => _ministryModelToJson(this);
  
  @override
  String toString() => "Ministry<$ministry>";
}

Map<String, dynamic> _ministryModelToJson(MinistryModel ministryModel) {
  return {
    "ministry":ministryModel.ministry,
    "leader": ministryModel.leader
  };
}

MinistryModel _ministryFromJson(Map<String, dynamic> json) {
  return MinistryModel(
    ministry: json["ministry"] as String,
    leader: json["leader"] as PersonModel,
  );
}
