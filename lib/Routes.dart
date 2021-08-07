import 'package:final_project/Screens/AboutScreen.dart';
import 'package:final_project/Screens/MenuDetails.dart';
import 'package:final_project/Screens/MenuList.dart';

import 'Screens/LoginScreen.dart';
import 'Screens/HomeScreen.dart';
import 'Screens/RegisterScreen.dart';
import 'Screens/ResetPassword.dart';
import 'Screens/AboutScreen.dart';
import 'package:flutter/material.dart';

final Map<String, WidgetBuilder>  routeNames = {
  '/home' : (context) => HomeScreen(),
  '/login' : (context) => LoginScreen(),
  '/register' : (context) => RegisterScreen(),
  '/resetpw' : (context) => ResetPasswordScreen(),
  '/about' : (context) => AboutScreen(),
  '/menuList' : (context) => MenuList(),
  '/menuDetails' : (context) => MenuDetails(),
};

final String initialRouteName = '/login';