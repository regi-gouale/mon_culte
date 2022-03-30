import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mon_culte/data/models/person_model.dart';

class PersonRepository {
  final CollectionReference personsRef = FirebaseFirestore.instance
      .collection("persons")
      .withConverter<PersonModel>(
        fromFirestore: (snapshot, _) => PersonModel.fromJson(snapshot.data()!),
        toFirestore: (movie, _) => movie.toJson(),
      );

  Stream<QuerySnapshot> getStream() {
    return personsRef.snapshots();
  }

  Future<DocumentReference<PersonModel>> addPerson(PersonModel person) async {
    return await personsRef.add(person.toJson())
        as Future<DocumentReference<PersonModel>>;
  }

  Future<PersonModel> getPersonByID({required String id}) async {
    return await personsRef
        .doc(id)
        .get()
        .then((snapshot) => snapshot.data()! as PersonModel);
  }

  Future<void> updatePerson({
    required String id,
    required PersonModel person,
  }) {
    return personsRef.doc(id).update(person.toJson());
  }

//   Future<PersonModel> getPersonByName({required String fistName, required String lastName,}) async{
// await personsRef.where(FieldPath.fromString("path"));
//   }
}
