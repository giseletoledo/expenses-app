import 'dart:convert';

import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../entities/user.dart';

final Logger logger = Logger();

class UserService {
  final String _userKey = 'user';

  Future<User?> loadUser() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final userData = prefs.getString(_userKey);
      if (userData != null) {
        final saldo = await loadSaldo();
        final Map<String, dynamic> json = jsonDecode(userData);
        final user = User.fromJson(json);
        user.saldo = saldo;
        return user;
      }
    } catch (error, stackTrace) {
      logger.e('Failed to load user', error, stackTrace);
    }
    return null;
  }

  Future<void> saveUser(User user) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final userData = jsonEncode(user.toJson());
      await prefs.setString(_userKey, userData);
    } catch (error) {
      logger.e('Failed to save user', error);
    }
  }

  Future<double> loadSaldo() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final saldoData = prefs.getDouble('saldo');
      return saldoData ?? 0.0;
    } catch (error, stackTrace) {
      logger.e('Failed to load saldo', error, stackTrace);
    }
    return 0.0;
  }

  Future<void> saveSaldo(double saldo) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setDouble('saldo', saldo);
    } catch (error) {
      logger.e('Failed to save saldo', error);
    }
  }
}
