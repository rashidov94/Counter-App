import 'package:floor/floor.dart';
import 'package:flutter_app/entity/todo.dart';
import 'dart:async';
import 'package:sqflite/sqflite.dart' as sqflite;

import 'package:flutter_app/repository/database/dao/todo_dao.dart';

part "app_database.g.dart";

@Database(version: 1, entities: [Todo])
abstract class AppDatabase extends FloorDatabase {
  TodoDao get todoDao;
}
