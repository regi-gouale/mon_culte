import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mon_culte/data/repositories/person_repository.dart';
import 'package:mon_culte/firebase_options.dart';
import 'package:mon_culte/ui/screens/scanner_code_view.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const IccLyonApp());
}

final List<Map<String, dynamic>> cultes = [
  {
    "id": 1,
    "designation": "Culte de célébration",
    "date": "06/03/2022",
    "heureDebut": "08:30",
    "participants": [],
  },
  {
    "id": 2,
    "designation": "Culte de célébration",
    "date": "06/03/2022",
    "heureDebut": "11:00",
    "participants": [],
  },
  {
    "id": 3,
    "designation": "Culte de célébration",
    "date": "13/03/2022",
    "heureDebut": "08:30",
    "participants": [],
  },
  {
    "id": 4,
    "designation": "Culte de célébration",
    "date": "13/03/2022",
    "heureDebut": "11:00",
    "participants": [],
  },
  {
    "id": 5,
    "designation": "Culte de célébration",
    "date": "20/03/2022",
    "heureDebut": "08:30",
    "participants": [],
  },
  {
    "id": 6,
    "designation": "Culte de célébration",
    "date": "20/03/2022",
    "heureDebut": "11:00",
    "participants": [],
  },
  {
    "id": 7,
    "designation": "Culte de célébration",
    "date": "27/03/2022",
    "heureDebut": "08:30",
    "participants": [],
  },
  {
    "id": 8,
    "designation": "Culte de célébration",
    "date": "27/03/2022",
    "heureDebut": "11:00",
    "participants": [],
  },
];

final List<Map<String, dynamic>> personnes = [
  {
    "id": 0,
    "nom": "GOUALE",
    "prénom": "Régi",
    "annéeNaissance": 1993,
    "sexe": "homme",
    "mail": "regi.gouale.icc@gmail.com",
  },
  {
    "id": 1,
    "nom": "GOUALE",
    "prénom": "Leslie",
    "annéeNaissance": 1992,
    "sexe": "femme",
    "mail": "regi.gouale.icc@gmail.com",
  },
  {
    "id": 2,
    "nom": "YENO",
    "prénom": "Pearl",
    "annéeNaissance": 1990,
    "sexe": "femme",
    "mail": "regi.gouale.icc@gmail.com",
  },
  {
    "id": 3,
    "nom": "DJATCHI",
    "prénom": "Willerm",
    "annéeNaissance": 1993,
    "sexe": "homme",
    "mail": "regi.gouale.icc@gmail.com",
  },
  {
    "id": 4,
    "nom": "ONAMBELE",
    "prénom": "Achil",
    "annéeNaissance": 1981,
    "sexe": "homme",
    "mail": "regi.gouale.icc@gmail.com",
  },
  {
    "id": 5,
    "nom": "YAOKOKORE",
    "prénom": "Esther",
    "annéeNaissance": 1990,
    "sexe": "femme",
    "mail": "regi.gouale.icc@gmail.com",
  },
];

class IccLyonApp extends StatelessWidget {
  const IccLyonApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Mon Culte ICC Lyon',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: const MonCulte(),
    );
  }
}

class MonCulte extends StatefulWidget {
  const MonCulte({Key? key}) : super(key: key);

  @override
  State<MonCulte> createState() => _MonCulteState();
}

class _MonCulteState extends State<MonCulte> {
  final PersonRepository personRepository = PersonRepository();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Liste des événements",
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: personRepository.getStream(),
          builder: (context, snapshot) {
            return ListView.builder(
              itemBuilder: (context, index) {
                return Card(
                  child: ListTile(
                    title: Text(
                      "${cultes[index]['designation']} du ${cultes[index]['date']}",
                    ),
                    leading: const Icon(Icons.church_rounded),
                    onTap: () {
                      print(snapshot.data!.docs);
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => ScannerCodeView(
                            cultes: cultes,
                            personnes: personnes,
                            index: index,
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
              itemCount: cultes.length,
            );
          }),
    );
  }
}
