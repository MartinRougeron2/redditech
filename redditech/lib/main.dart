import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:reditech/widgets/routerApp.dart';


void main() {
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(statusBarColor: Colors.grey[200]),
  );

  runApp(
    MaterialApp(
      title: 'Art Nô',
      color: Colors.indigo,
      home: RouterApp(),
    ),
  );
}