// ignore: import_of_legacy_library_into_null_safe
import 'package:fluid_bottom_nav_bar/fluid_bottom_nav_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:zoo/features/zoo_folder/presentation/Screens/home_screen.dart';
import 'package:zoo/features/zoo_folder/presentation/Screens/ticket_sell.dart';
import 'package:zoo/features/zoo_folder/presentation/Screens/account_screen.dart';

class Wrapper extends StatefulWidget {
  final String name;
  final String email;
  final image;
  Wrapper({required this.name, required this.email, required this.image});

  _WrapperState createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  Widget? _child;

  @override
  void initState() {
    _child = Home();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _child,
      extendBody: true,
      bottomNavigationBar: SizedBox(
        width: double.infinity,
        child: FluidNavBar(
          icons: [
            FluidNavBarIcon(
                icon: Icons.home,
                backgroundColor: Colors.pink,
                extras: {"label": "home"}),
            FluidNavBarIcon(
                icon: CupertinoIcons.ticket,
                backgroundColor: Colors.pink,
                extras: {"label": "ticket"}),
            FluidNavBarIcon(
                icon: Icons.account_circle,
                backgroundColor: Colors.pink,
                extras: {"label": "account"}),
          ],
          onChange: _handleNavigationChange,
          style: FluidNavBarStyle(
              iconSelectedForegroundColor: Colors.white,
              iconUnselectedForegroundColor: Colors.white60,
              barBackgroundColor: Colors.green),
          scaleFactor: 1.5,
          defaultIndex: 0,
          itemBuilder: (icon, item) => Semantics(
            label: icon.extras!["label"],
            child: item,
          ),
        ),
      ),
    );
  }

  void _handleNavigationChange(int index) {
    setState(() {
      switch (index) {
        case 0:
          _child = Home();
          break;
        case 1:
          _child = ticket_sell();
          break;
        case 2:
          _child = Account(
            name: widget.name,
            email: widget.email,
            image: widget.image,
          );
          break;
      }
      _child = AnimatedSwitcher(
        switchInCurve: Curves.easeOut,
        switchOutCurve: Curves.easeIn,
        duration: Duration(milliseconds: 100),
        child: _child,
      );
    });
  }
}
