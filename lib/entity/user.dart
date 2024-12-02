import 'dart:convert';
import 'package:http/http.dart' as http;

class User {
  String id;
  String username;
  String email;
  int berat;
  int tinggi;
  String gender;

  User({
    required this.id,
    required this.username,
    required this.email,
    required this.berat,
    required this.tinggi,
    required this.gender,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"].toString(),
        username: json["username"],
        email: json["email"],
        berat: json["berat"],
        tinggi: json["tinggi"],
        gender: json["gender"],
      );

  String toRawJson() => json.encode(toJson());

  Map<String, dynamic> toJson() => {
        "id": id,
        "username": username,
        "email": email,
        "berat": berat,
        "tinggi": tinggi,
        "gender": gender,
      };
}

// Fungsi untuk memanggil data user
Future<User> fetchUserProfile() async {
  final response = await http.get(Uri.parse('http://your-server-url/api/user-profile.php'));

  if (response.statusCode == 200) {
    return User.fromJson(json.decode(response.body));
  } else {
    throw Exception('Failed to load profile');
  }
}
