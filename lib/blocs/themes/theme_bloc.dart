import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:miniblog/blocs/themes/dark_theme.dart';
import 'package:miniblog/blocs/themes/light_theme.dart';

enum ThemeEvent { toggle }

class ThemeBloc extends Bloc<ThemeEvent, ThemeData> {
  ThemeBloc() : super(lightTheme);

  Stream<ThemeData> mapEventToState(ThemeEvent event) async* {
    if (event == ThemeEvent.toggle) {
      yield state == lightTheme ? darkTheme : lightTheme;
    }
  }
}

