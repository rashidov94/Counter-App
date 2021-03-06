import 'package:flutter/material.dart';
import 'package:flutter_app/entity/language.dart';
import 'package:flutter_app/repository/repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../main.dart';
import 'base_state_full.dart';

mixin BasicPage<Page extends BasePage> on BasePageState<Page> {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(750, 1334),
      allowFontScaling: false,
      builder: () => createScaffold(),
    );
  }

  Widget createScaffold();

  changeLanguage(Language language) async {
    Locale _locale = await RepositoryProvider.of<Repository>(context)
        .setLocale(language.languageCode);
    MyApp.changeLocale(context, _locale);
  }

  changeRepository(context, {@required hostUrl, @required databaseName}) {
    Repository.createRepository(hostUrl, databaseName,
            RepositoryProvider.of<Repository>(context).sharedPreference)
        .then((value) {
      MyApp.changeRepository(context, value);
      return;
    });
  }

  showSnackBar(context, String error) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(error)));
  }

  showAlertDialog(BuildContext context) {
    Widget okButton = TextButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

    AlertDialog alert = AlertDialog(
      title: Text("Simple Alert"),
      content: Text("This is an alert message."),
      actions: [
        okButton,
      ],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
