import 'package:extended_image/extended_image.dart';
import 'package:get/get.dart';
import 'package:pecker_flutter/app/data/databases/app_db.dart';
import 'package:pecker_flutter/app/data/databases/daos/students.dart';
import 'package:pecker_flutter/app/data/services/index.dart';
import 'package:pecker_flutter/utils/index.dart';

class DbSampleController extends GetxController {
  late StudentsDao dao;

  RxList<Student> students = RxList<Student>();

  final names = [];

  @override
  void onInit() {
    dao = DbService.to.db.studentsDao;
    reset();
    super.onInit();
  }

  void reset() async {
    students.assignAll(await dao.getAll());
  }

  void updateOne(int index) {
    final data = Student(
      id: students[index].id,
      name: randName(),
      score: MyTools.rand(100),
    );
    dao
        .updateOne(
      data,
    )
        .then((value) {
      students[index] = data;
    });
  }

  void addOne() {
    final name = randName();
    final score = MyTools.rand(100);
    dao
        .addOne(
      name: name,
      score: score,
    )
        .then((value) {
      students.add(Student(id: value, name: name, score: score));
    });
  }

  void remove(int index) {
    final data = students[index];
    dao.removeOne(data.id).then((value) => students.remove(data));
  }

  randName() {
    List<int> list = [];
    for (int i = 0; i < 10; i++) {
      list.add(65 + MyTools.rand(26));
    }
    return String.fromCharCodes(list);
  }
}
