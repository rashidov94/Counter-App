import 'package:floor/floor.dart';

abstract class AbstractDao<T> {
  @insert
  Future<void> insertItem(T item);

  @update
  Future<void> updateItem(T item);

  @delete
  Future<void> deleteItem(T item);
}
