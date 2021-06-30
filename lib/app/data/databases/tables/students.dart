import 'package:moor/moor.dart';

class Students extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
  IntColumn get score => integer()();
}
