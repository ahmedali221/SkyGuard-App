import 'dart:convert';

class AppUser {
  final String name;
  final String email;
  final String password;
  AppUser({
    required this.name,
    required this.email,
    required this.password,
  });

  AppUser copyWith({
    String? name,
    String? email,
    String? password,
  }) {
    return AppUser(
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'email': email,
      'password': password,
    };
  }

  factory AppUser.fromMap(Map<String, dynamic> map) {
    return AppUser(
      name: map['name'] as String,
      email: map['email'] as String,
      password: map['password'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory AppUser.fromJson(String source) =>
      AppUser.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'user(name: $name, email: $email, password: $password)';

  @override
  bool operator ==(covariant AppUser other) {
    if (identical(this, other)) return true;

    return other.name == name &&
        other.email == email &&
        other.password == password;
  }

  @override
  int get hashCode => name.hashCode ^ email.hashCode ^ password.hashCode;
}
