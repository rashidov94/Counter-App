import 'package:floor/floor.dart';

@Entity(tableName: 'todo')
class Todo {

  @PrimaryKey(autoGenerate: true)
  int id;

  String description;

  Todo({this.description});

  @override
  String toString() {
    return 'Todo{id: $id, description: $description}';
  }
}
