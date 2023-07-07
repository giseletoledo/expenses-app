class User {
  String? name;
  String? photoUrl;
  double? _saldo = 0;

  User({
    this.name,
    this.photoUrl,
    double? saldo,
  }) : _saldo = saldo;

  double get saldo {
    return _saldo ?? 0.0;
  }

  set saldo(double? value) {
    // if (value != 0 || value! >= (_saldo ?? 0)) {
    _saldo = value!;
    // }
  }

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      name: json['name'],
      photoUrl: json['photoUrl'],
      saldo: json['saldo'].toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'photoUrl': photoUrl,
      'saldo': saldo,
    };
  }

  @override
  String toString() => 'User(name: $name, photoUrl: $photoUrl, saldo: $saldo)';
}
