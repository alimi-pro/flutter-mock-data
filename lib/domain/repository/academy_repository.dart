import 'package:alimipro_mock_data/domain/model/academy.dart';

// TODO: CRUD
abstract interface class AcademyRepository {
  Stream<Academy> get academyStream;

  Future<Academy> getAcademy();
}
