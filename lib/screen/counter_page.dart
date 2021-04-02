import 'package:flutter/material.dart';
import 'package:flutter_app/base/base_state_full.dart';

import 'package:flutter_app/base/basic_page_mixin.dart';
import 'package:flutter_app/entity/language.dart';
import 'package:flutter_app/localization/language_constants.dart';
import 'package:flutter_app/screen/counter_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CounterPage extends BasePage {
  @override
  State<StatefulWidget> createState() {
    return _CounterPageState();
  }
}

class _CounterPageState extends BasePageState<CounterPage> with BasicPage {
  @override
  Widget createScaffold() {
    return Scaffold(
      appBar: AppBar(
        title: Text(getTranslated(context, 'change_language')!),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: DropdownButton<Language>(
              underline: SizedBox(),
              icon: Icon(
                Icons.language,
                color: Colors.white,
              ),
              onChanged: (Language? language) {
                changeLanguage(language!);
              },
              items: Language.languageList()
                  .map<DropdownMenuItem<Language>>(
                    (e) => DropdownMenuItem<Language>(
                      value: e,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Text(
                            e.flag,
                            style: TextStyle(fontSize: 30),
                          ),
                          Text(e.name)
                        ],
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
        ],
      ),
      body: BlocBuilder<CounterCubit, int>(
        builder: (context, count) {
          return Center(
            child: Text('$count'),
          );
        },
      ),
      floatingActionButton: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5.0),
            child: FloatingActionButton(
              onPressed: () =>
                  BlocProvider.of<CounterCubit>(context).increment(),
              child: const Icon(Icons.add),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5.0),
            child: Builder(
              builder: (context) {
                return FloatingActionButton(
                  onPressed: () {
                    BlocProvider.of<CounterCubit>(context).decrement();
                  },
                  child: const Icon(Icons.remove),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
