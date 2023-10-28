
import '../Enumerations/user_role.dart';

class User{
  final int id;
  final String name;
  final String familyName;
  final String email;
  final DateTime birthDay;
  final String password;
  final String phone;
  final UserRole role;
  final String photo; //the photo's path

  //constructor
  User({
    required this.id,
    required this.name,
    required this.familyName,
    required this.email,
    required this.birthDay,
    required this.password,
    required this.phone,
    required this.role,
    required this.photo
  });
  //convert fom User object to Json
  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'familyName': familyName,
    'email': email,
    'birthDay': birthDay,
    'password': password,
    'phone': phone,
    'role': role,
    'photo': photo
  };
  //convert from Json to User object
  factory User.fromJson(Map<String, dynamic> userJson) => User(
    id: userJson['id'],
    name: userJson['name'],
    familyName: userJson['familyName'],
    email: userJson['email'],
    birthDay: userJson['birthDay'],
    password: userJson['password'],
    phone: userJson['phone'],
    role: userJson['role'],
    photo: userJson['photo']
  );
}