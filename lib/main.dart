import 'package:flutter/material.dart';
import 'package:liquid_galaxy_task/pages/home_screen.dart';
import 'package:liquid_galaxy_task/services/lg_service.dart';
import 'package:liquid_galaxy_task/utils/theme.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        Provider<LgService>(
          create: (_) => LgService(),
        ),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: darkTheme,
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}
