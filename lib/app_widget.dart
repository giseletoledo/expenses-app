import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'app_routes.dart';
import 'providers/config_provider.dart';
import 'styles/my_theme_style.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late ConfigProvider storeConfig;

  @override
  Widget build(BuildContext context) {
    storeConfig = Provider.of<ConfigProvider>(context);

    return MaterialApp(
      title: 'Controle de gastos',
      debugShowCheckedModeBanner: false,
      routes: AppRoutes.routes(),
      themeMode: storeConfig.tema,
      theme: MyThemeStyle.claro,
      darkTheme: MyThemeStyle.escuro,
    );
  }
}
