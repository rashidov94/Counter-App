import 'package:flutter/material.dart';
import 'package:flutter_app/entity/todo.dart';
import 'package:flutter_app/repository/database/app_database.dart';
import 'package:flutter_app/repository/database/database_interface.dart';
import 'package:flutter_app/repository/remote_data_source/app_remote_source.dart';
import 'package:flutter_app/repository/remote_data_source/remote_source_interface.dart';
import 'package:flutter_app/repository/shared_preferences/app_shared_preference.dart';
import 'package:flutter_app/repository/shared_preferences/shared_preferences_interface.dart';

class Repository
    implements
        DatabaseInterface,
        SharedPreferenceInterface,
        RemoteSourceInterface {
  static Future<Repository> createRepository(String? hostUrl,
      String? databaseName, AppSharedPreference sharedPreference) async {
    final database = databaseName == null
        ? null
        : await $FloorAppDatabase.databaseBuilder('$databaseName.db').build();

    final appRemoteSource = hostUrl == null ? null : AppRemoteSource(hostUrl);

    return Repository(
        database: database,
        remoteSource: appRemoteSource,
        sharedPreference: sharedPreference);
  }

  final AppDatabase? database;
  final AppRemoteSource? remoteSource;
  final AppSharedPreference sharedPreference;

  Repository(
      {this.database, this.remoteSource, required this.sharedPreference});

  @override
  String toString() {
    return 'Repository{database: $database, remoteSource: $remoteSource, sharedPreference: $sharedPreference}';
  }

  @override
  Future<void> deleteItem(Todo item) {
    return database!.todoDao.deleteItem(item);
  }

  @override
  Future<List<Todo>> getAllTodo() {
    return database!.todoDao.getAllTodo();
  }

  @override
  Future<void> insertItem(Todo item) {
    return database!.todoDao.insertItem(item);
  }

  @override
  Future<void> updateItem(Todo item) {
    return database!.todoDao.updateItem(item);
  }

  @override
  Future<Locale> getLocale() {
    return sharedPreference.getLocale();
  }

  @override
  Future<Locale> setLocale(String languageCode) {
    return sharedPreference.setLocale(languageCode);
  }

  @override
  Future<String> getHttp() {
    return remoteSource!.getHttp();
  }
}
