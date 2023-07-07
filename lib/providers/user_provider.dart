import 'package:flutter/material.dart';

import '../entities/user.dart';
import '../services/user_service.dart';

class UserProvider with ChangeNotifier {
  User? user;
  final UserService _userService;

  UserProvider({required UserService userService}) : _userService = userService;

  Future<void> init() async {
    await loadUserFromSharedPreferences();
    if (user == null) {
      await createAndSaveMockUser();
    }
  }

  User createMockUser() {
    return User(
      name: 'Dash',
      photoUrl: 'https://res.cloudinary.com/startup-grind/image/upload/c_fill,dpr_2,f_auto,g_center,q_auto:good/v1/gcs/platform-data-goog/events/learn-hero.png',
      saldo: 2000,
    );
  }

  Future<void> createAndSaveMockUser() async {
    // Cria o usuário mocado
    user = createMockUser();
    await _userService.saveUser(user!);
    notifyListeners();
  }

  void setUser(String name, String photoUrl, double saldo) {
    user = User(name: name, photoUrl: photoUrl, saldo: saldo);
    _userService.saveUser(user!);
    notifyListeners();
  }

  void updateSaldo(double saldo) {
    user?.saldo = saldo;
    notifyListeners();
  }

  Future<void> loadUserFromSharedPreferences() async {
    final loadedUser = await _userService.loadUser();
    if (loadedUser != null) {
      user = loadedUser;
      notifyListeners();
    }
  }
}
