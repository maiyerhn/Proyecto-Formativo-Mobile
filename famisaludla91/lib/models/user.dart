import 'dart:convert';

class Usuario {
  final int id;
  final String name;
  final String lastName;
  final String email;
  final String phone;
  final String? password;
  final String address;
  final String role;

  Usuario({
    required this.id,
    required this.name,
    required this.lastName,
    required this.email,
    required this.phone,
    this.password,
    required this.address,
    required this.role,
  });

  factory Usuario.fromJson(Map<String, dynamic> json) {
    return Usuario(
      id: json['id'],
      name: json['name'],
      lastName: json['last_name'],
      email: json['email'],
      phone: json['phone'],
      password: json['password'],
      address: json['address'],
      role: json['role'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'last_name': lastName,
      'email': email,
      'phone': phone,
      'password': password,
      'address': address,
      'role': role,
    };
  }
}
