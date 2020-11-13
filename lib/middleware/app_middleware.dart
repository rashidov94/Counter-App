import 'package:flutter_app/redux/app_state.dart';
import 'package:flutter_app/repository/repository.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';

ThunkAction<AppState> addTodoToGlobalStore(Repository repository) {
  return (Store<AppState> store) {};
}
