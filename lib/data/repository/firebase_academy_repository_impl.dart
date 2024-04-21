import 'package:alimipro_mock_data/domain/model/academy.dart';
import 'package:alimipro_mock_data/domain/repository/academy_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseAcademyRepositoryImpl implements AcademyRepository {
  final String _uid;
  final FirebaseFirestore _firebaseFirestore;

  const FirebaseAcademyRepositoryImpl({
    required String uid,
    required FirebaseFirestore firebaseFirestore,
  })  : _uid = uid,
        _firebaseFirestore = firebaseFirestore;

  @override
  Stream<Academy> get academyStream => _firebaseFirestore
      .collection('Academies')
      .doc(_uid)
      .withConverter<Academy>(
          fromFirestore: (snapshot, _) {
            return Academy.fromJson(snapshot.data()!);
          },
          toFirestore: (student, _) => student.toJson())
      .snapshots()
      .map((event) => event.data()!);

  @override
  Future<Academy> getAcademy() async {
    final snapshot = await _firebaseFirestore
        .collection('Academies')
        .doc(_uid)
        .withConverter<Academy>(
            fromFirestore: (snapshot, _) {
              return Academy.fromJson(snapshot.data()!);
            },
            toFirestore: (student, _) => student.toJson())
        .get();

    if (!snapshot.exists) {
      throw Exception('미등록 학원');
    }

    return snapshot.data()!;
  }
}
