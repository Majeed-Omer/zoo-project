import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import '../Widgets/app_themes.dart';
part 'Theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit()
      : super(
            ThemeState(themeData: AppThemes.appThemeData[AppTheme.lightTheme]));

  void change_to_dark() {
    emit(ThemeState(themeData: AppThemes.appThemeData[AppTheme.lightTheme]));
  }

  void change_to_light() =>
      emit(ThemeState(themeData: AppThemes.appThemeData[AppTheme.darkTheme]));
}
