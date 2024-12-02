import 'dart:convert';
import 'package:http/http.dart' as http;

class User {
  final String id;
  final String username;
  final String email;
  final int berat;
  final int tinggi;
  final String gender;

  User({
    required this.id,
    required this.username,
    required this.email,
    required this.berat,
    required this.tinggi,
    required this.gender,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'].toString(),
      username: json['username'],
      email: json['email'],
      berat: json['berat'],
      tinggi: json['tinggi'],
      gender: json['gender'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'email': email,
      'berat': berat,
      'tinggi': tinggi,
      'gender': gender,
    };
  }
}

class UserClient {
  static final String url = '10.0.2.2:8000';
  static final String registerEndpoint = '/api/register';
  static final String loginEndpoint = '/api/login';
  static final String usersEndpoint = '/api/users';
  static final String updateUserEndpoint = '/api/update';
  static final String deleteUserEndpoint = '/api/delete';

  // Register new user
  static Future<User> register(User user) async {
    try {
      var response = await http.post(
        Uri.http(url, registerEndpoint),
        headers: {"Content-Type": "application/json"},
        body: json.encode(user.toJson()),
      );

      if (response.statusCode != 201) throw Exception(response.reasonPhrase);

      return User.fromJson(json.decode(response.body)['user']);
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  // Login user
  static Future<Map<String, dynamic>> login(String email, String password) async {
    try {
      var response = await http.post(
        Uri.http(url, loginEndpoint),
        headers: {"Content-Type": "application/json"},
        body: json.encode({'email': email, 'password': password}),
      );

      if (response.statusCode != 200) throw Exception(response.reasonPhrase);

      return json.decode(response.body);
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  // Show all users
  static Future<List<User>> fetchAll() async {
    try {
      var response = await http.get(Uri.http(url, usersEndpoint));

      if (response.statusCode != 200) throw Exception(response.reasonPhrase);

      Iterable list = json.decode(response.body);
      return list.map((e) => User.fromJson(e)).toList();
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  // Update user
  static Future<User> update(User user) async {
    try {
      var response = await http.put(
        Uri.http(url, '$updateUserEndpoint/${user.id}'),
        headers: {"Content-Type": "application/json"},
        body: json.encode(user.toJson()),
      );

      if (response.statusCode != 200) throw Exception(response.reasonPhrase);

      return User.fromJson(json.decode(response.body));
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  // Delete user
  static Future<void> delete(String id) async {
    try {
      var response = await http.delete(Uri.http(url, '$deleteUserEndpoint/$id'));

      if (response.statusCode != 200) throw Exception(response.reasonPhrase);
    } catch (e) {
      return Future.error(e.toString());
    }
  }
}
