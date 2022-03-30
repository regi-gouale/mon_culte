import 'package:cloud_firestore/cloud_firestore.dart';

class EventsModel {
  final String eventType;
  final String eventDesignation;
  final DateTime date;

  DocumentReference? reference;

  EventsModel({
    required this.eventType,
    required this.eventDesignation,
    required this.date,
    this.reference,
  });

  factory EventsModel.fromJson(Map<String, dynamic> json) {
    return EventsModel(
      eventType: json["eventType"] as String,
      eventDesignation: json["eventDesignation"] as String,
      date: (json["date"] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "eventType": eventType,
      "eventDesignation": eventDesignation,
      "date": date,
    };
  }
}
