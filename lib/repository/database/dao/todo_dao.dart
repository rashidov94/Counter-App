import 'package:floor/floor.dart';
import 'package:flutter_app/entity/todo.dart';
import 'package:flutter_app/repository/database/abstract_dao.dart';

@dao
abstract class TodoDao extends AbstractDao<Todo> {
  @Query('SELECT * FROM todo')
  Future<List<Todo>> getAllTodo();
}
