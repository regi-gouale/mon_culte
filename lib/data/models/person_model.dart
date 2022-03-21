import 'package:cloud_firestore/cloud_firestore.dart';

class PersonModel {
  final String firstName;
  final String lastName;
  final int birthYear;
  final String sex;
  final String mailAddress;

  DocumentReference? reference;

  PersonModel({
    required this.firstName,
    required this.lastName,
    required this.birthYear,
    required this.sex,
    required this.mailAddress,
    this.reference,
  });

  factory PersonModel.fromJson(Map<dynamic, dynamic> json) =>
      _personModelFromJson(json);

  factory PersonModel.fromSnapshot(DocumentSnapshot snapshot) {
    PersonModel personModel = PersonModel.fromJson(snapshot.data as Map);
    personModel.reference = snapshot.reference;
    return personModel;
  }

  Map<String, dynamic> toJson() => _personModelToJson(this);

  @override
  String toString() => "Person<$firstName $lastName>";
}

Map<String,dynamic> _personModelToJson(PersonModel personModel) {
  return {
    "firstName": personModel.firstName,
    "lastName": personModel.lastName,
    "birthYear": personModel.birthYear,
    "sex": personModel.sex,
    "mailAddress": personModel.mailAddress,
    "reference": personModel.reference,
  };
}

PersonModel _personModelFromJson(Map<dynamic, dynamic> json) {
  return PersonModel(
    firstName: json["firstName"] as String,
    lastName: json["lastName"] as String,
    birthYear: json["birthYear"] as int,
    sex: json["sex"] as String,
    mailAddress: json["mailAddress"] as String,
  );
}
