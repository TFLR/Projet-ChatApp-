import 'package:flutter/material.dart';
import 'package:projetchatapp/models/user.dart';
import 'package:projetchatapp/screens/authenticate/authenticate_screen.dart';
import 'package:projetchatapp/screens/home/home_screen.dart';
import 'package:provider/provider.dart';

class SplashScreenWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AppUser?>(context);
    if (user == null) {
      return AuthenticateScreen();
    } else {
      return HomeScreen();
    }
  }
}
