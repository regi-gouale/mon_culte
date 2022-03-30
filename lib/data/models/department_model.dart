import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mon_culte/data/models/ministry_model.dart';
import 'package:mon_culte/data/models/person_model.dart';

class DepartmentModel {
  final String department;
  final PersonModel leader;
  final MinistryModel ministry;

  DocumentReference? reference;

  DepartmentModel({
    required this.department,
    required this.leader,
    required this.ministry,
    this.reference,
  });

  factory DepartmentModel.fromJson(Map<String, dynamic> json) =>
      _departmentFromJson(json);

  Map<String, dynamic> toJson() => _departmentModelToJson(this);

  @override
  String toString() => "Department<$department>";
}

Map<String, dynamic> _departmentModelToJson(DepartmentModel departmentModel) {
  return {
    "department": departmentModel.department,
    "leader": departmentModel.leader,
    "ministry": departmentModel.ministry,
  };
}

DepartmentModel _departmentFromJson(Map<String, dynamic> json) {
  return DepartmentModel(
    department: json["department"] as String,
    leader: json["leader"] as PersonModel,
    ministry: json["ministry"] as MinistryModel,
  );
}
