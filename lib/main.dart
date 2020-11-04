import 'package:flutter/material.dart';
import 'package:flutter_app/redux/app_reducer.dart';
import 'package:flutter_app/redux/app_state.dart';
import 'package:flutter_app/repository/repository.dart';
import 'package:flutter_app/repository/shared_preferences/app_shared_preference.dart';
import 'package:flutter_app/screen/counter_cubit.dart';
import 'package:flutter_app/screen/counter_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'localization/app_localization.dart';

void main() async {
  // var remoteDevTools = RemoteDevToolsMiddleware('192.168.1.52:8000');
  // final store = DevToolsStore<AppState>(appReducer, middleware: [
  //   remoteDevTools,
  // ]);
  // remoteDevTools.store = store;
  // await remoteDevTools.connect();
  WidgetsFlutterBinding.ensureInitialized();

  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  Repository.createRepository(
          null, null, AppSharedPreference(sharedPreferences))
      .then((repository) {
    final store =
        Store<AppState>(appReducer, initialState: AppState(), middleware: [
      thunkMiddleware,
    ]);
    runApp(MyApp(store, repository));
  });
}

class MyApp extends StatefulWidget {
  //final DevToolsStore<AppState> store;
  final Store<AppState> store;
  final Repository _repository;

  MyApp(this.store, this._repository);

  static changeRepository(BuildContext context, Repository repository) {
    _MyAppState state = context.findAncestorStateOfType<_MyAppState>();
    state.changeRepository(repository);
  }

  static void changeLocale(BuildContext context, Locale newLocale) {
    _MyAppState state = context.findAncestorStateOfType<_MyAppState>();
    state.changeLocale(newLocale);
  }

  @override
  State<StatefulWidget> createState() {
    return _MyAppState(store, _repository);
  }
}

class _MyAppState extends State<MyApp> {
  //final DevToolsStore<AppState> store;
  final Store<AppState> store;
  Repository _repository;
  Locale _locale;

  _MyAppState(this.store, this._repository);

  changeRepository(Repository repository) {
    setState(() {
      _repository = repository;
    });
  }

  changeLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
        store: store,
        child: RepositoryProvider(
          create: (_) {
            return _repository;
          },
          child: BlocProvider(
            create: (BuildContext context) {
              return CounterCubit();
            },
            child: MaterialApp(
              title: "Flutter Application",
              theme: ThemeData(primarySwatch: Colors.blue),
              locale: _locale,
              supportedLocales: [
                Locale("en", "US"),
                Locale("ru", "RU"),
                Locale("uz", "UZ")
              ],
              localizationsDelegates: [
                AppLocalization.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              localeResolutionCallback: (locale, supportedLocales) {
                for (var supportedLocale in supportedLocales) {
                  if (supportedLocale.languageCode == locale.languageCode &&
                      supportedLocale.countryCode == locale.countryCode) {
                    return supportedLocale;
                  }
                }
                return supportedLocales.first;
              },
              home: CounterPage(),
            ),
          ),
        ));
  }
}
