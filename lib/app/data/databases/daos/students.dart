import 'package:moor/moor.dart';
import 'package:pecker_flutter/app/data/databases/tables/students.dart';

import '../app_db.dart';

part 'students.g.dart';

@UseDao(tables: [Students])
class StudentsDao extends DatabaseAccessor<AppDb> with _$StudentsDaoMixin {
  StudentsDao(AppDb db) : super(db);

  Future<List<Student>> getAll() {
    return select(students).get();
  }

  Future<int> addOne({
    required String name,
    required int score,
  }) {
    return into(students)
        .insert(StudentsCompanion.insert(name: name, score: score));
  }

  Future<int> removeOne(int id) {
    return (delete(students)..where((tbl) => tbl.id.equals(id))).go();
  }

  Future updateOne(Student student) {
    return (update(students)..where((tbl) => tbl.id.equals(student.id)))
        .write(student);
  }
}
