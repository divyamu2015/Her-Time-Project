class UserLoginModel {
  String role;
  int userId;
  String name;
  String password;
  String phone;
  String email;

  UserLoginModel({
    required this.phone,
    required this.role,
    required this.userId,
    required this.name,
    required this.password,
    required this.email,
  });

  factory UserLoginModel.fromJson(Map<String, dynamic> json) {
    return UserLoginModel(
      role: json['role'] ?? '',             // Role may not exist in JSON; default to empty string
      userId: json['id'] ?? 0,
      name: json['name'] ?? '',
      password: json['password'] ?? '',
      email: json['email'] ?? '',
      phone: json['phone'] ?? '',            // Phone might be missing, default empty
    );
  }
}
