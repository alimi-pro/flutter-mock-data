import 'package:alimipro_mock_data/data/repository/firebase_academy_repository_impl.dart';
import 'package:alimipro_mock_data/domain/model/academy.dart';
import 'package:alimipro_mock_data/domain/repository/academy_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  final db = FirebaseFirestore.instance..useFirestoreEmulator('10.0.2.2', 8080);

  runApp(MyApp(db: db));
}

class MyApp extends StatelessWidget {
  final FirebaseFirestore db;

  const MyApp({
    super.key,
    required this.db,
  });

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: AlimiproSample(
        academyRepository: FirebaseAcademyRepositoryImpl(
          uid: 'KSm9vmT57KNDRb0QFWlZ0W416qs1',
          firebaseFirestore: db,
        ),
      ),
    );
  }
}

class AlimiproSample extends StatelessWidget {
  final AcademyRepository academyRepository;

  const AlimiproSample({
    super.key,
    required this.academyRepository,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Alimipro 샘플'),
      ),
      body: FutureBuilder<Academy>(
          future: academyRepository.getAcademy(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(child: Text(snapshot.error.toString()));
            }

            if (!snapshot.hasData) {
              return const Center(child: Text('값 없음'));
            }

            return Center(
              child: Text(snapshot.data.toString()),
            );
          }),
    );
  }
}
