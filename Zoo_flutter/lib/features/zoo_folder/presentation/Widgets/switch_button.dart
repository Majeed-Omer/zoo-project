import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/color_cubit.dart';

class SwitchExample extends StatefulWidget {
  const SwitchExample({super.key});

  @override
  State<SwitchExample> createState() => _SwitchExampleState();
}

class _SwitchExampleState extends State<SwitchExample> {
  bool mode = true;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
          builder: (context, state) {
        return 
    Switch(
      value: mode,
      activeThumbColor: Colors.red,
      onChanged: (bool value) {
        setState(() {
          mode = value;
          if(mode){
            BlocProvider.of<ThemeCubit>(context).change_to_dark();
          }else{
            BlocProvider.of<ThemeCubit>(context).change_to_light();
          }
        });
      },
    );});
  }
}