import 'package:flutter/material.dart';
import 'package:myexpenses/styles/palette_dark.dart';

import 'palette_light.dart';

class MyThemeStyle {
  static final PaletteLight _light = PaletteLight();
  static final PaletteDark _dark = PaletteDark();

  static final ThemeData claro = ThemeData.light().copyWith(
    colorScheme: ThemeData.light().colorScheme.copyWith(
          primary: _light.primary,
          secondary: _light.secondary,
          background: _light.background,
          error: _light.error,
        ),
    primaryColor: _light.primary,
    appBarTheme: AppBarTheme(
      backgroundColor: _light.accent,
      titleTextStyle: TextStyle(
        color: _light.white,
        fontWeight: FontWeight.bold,
        fontSize: 20,
      ),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: _light.backgroundDark,
      selectedItemColor:
          _light.accent, // Define a cor do item selecionado (ícone e texto)
      unselectedItemColor: _light
          .secondary, // Define a cor dos itens não selecionados (ícone e texto)
    ),
    cardTheme: CardTheme(
      color: _light.background, // Cor de fundo do Card
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: MaterialStateColor.resolveWith((states) {
        if (states.contains(MaterialState.disabled)) {
          return _light
              .secondary; // Cor de fundo quando o botão está desabilitado
        }
        return _light.accent; // Cor de fundo padrão
      }),
    ),
    checkboxTheme: CheckboxThemeData(
      fillColor: MaterialStateColor.resolveWith((states) => _light.primary),
    ),
    switchTheme: SwitchThemeData(
      thumbColor: MaterialStateColor.resolveWith((states) {
        return states.contains(MaterialState.selected)
            ? _light.primary
            : _light.secondary;
      }),
      trackColor: MaterialStateColor.resolveWith((states) {
        return states.contains(MaterialState.selected)
            ? _light.primaryDark
            : _light.secondary;
      }),
    ),
  );

  static final ThemeData escuro = ThemeData.dark().copyWith(
    colorScheme: ThemeData.dark().colorScheme.copyWith(
          primary: _dark.primary,
          secondary: _dark.secondary,
          background: _dark.background,
          error: _dark.error,
        ),
    primaryColor: _dark.primary,
    appBarTheme: AppBarTheme(
      backgroundColor: _dark.primaryDark,
      titleTextStyle: TextStyle(
        color: _dark.white,
        fontWeight: FontWeight.bold,
        fontSize: 20,
      ),
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: MaterialStateColor.resolveWith((states) {
        if (states.contains(MaterialState.disabled)) {
          return _dark
              .secondary; // Cor de fundo quando o botão está desabilitado
        }
        return _dark.accent; // Cor de fundo padrão
      }),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: _dark.backgroundDark,
      selectedItemColor:
          _dark.accent, // Define a cor do item selecionado (ícone e texto)
      unselectedItemColor: _dark
          .secondary, // Define a cor dos itens não selecionados (ícone e texto)
    ),
    cardTheme: CardTheme(
      color: _dark.backgroundDark, // Cor de fundo do Card
    ),
    checkboxTheme: CheckboxThemeData(
        fillColor: MaterialStateColor.resolveWith((states) => _dark.primary)),
    textTheme: TextTheme(
      titleMedium: TextStyle(
        color: _dark.text, // Cor do texto dos itens da lista dentro do Card
      ),
    ),
  );
}
