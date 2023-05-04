import 'dart:convert';

class User {
 
  final String username;
  final String password;
  final String email;
  User({
    required this.username,
    required this.password,
    required this.email,
  });

 

  // User copyWith({
  //   String? username,
  //   String? password,
  //   String? email,
  // }) {
  //   return User(
  //     username: username ?? this.username,
  //     password: password ?? this.password,
  //     email: email ?? this.email,
  //   );
  // }

  Map<String, dynamic> toMap() {
    return {
      'username': username,
      'password': password,
      'email': email,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      username: map['username'] ?? '',
      password: map['password'] ?? '',
      email: map['email'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source));

  @override
  String toString() => 'User(username: $username, password: $password, email: $email)';

  // @override
  // bool operator ==(Object other) {
  //   if (identical(this, other)) return true;
  
  //   return other is User &&
  //     other.username == username &&
  //     other.password == password &&
  //     other.email == email;
  // }

  // @override
  // int get hashCode => username.hashCode ^ password.hashCode ^ email.hashCode;
  }

   

 
