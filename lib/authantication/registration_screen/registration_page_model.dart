class PatientRegModel {
  int id;
  String name;
  String email;
  String password;
  String phone;
  String address;
  int age;
  String role;

  PatientRegModel({
    required this.id,
    required this.name,
    required this.email,
    required this.password,
    required this.phone,
    required this.address,
    required this.age,
    required this.role,
  });

  factory PatientRegModel.fromJson(Map<String, dynamic> json) {
    final Map<String, dynamic>? data = json['data'];

    return PatientRegModel(
      id: data != null && data['id'] != null ? data['id'] as int : 0,
      name: data != null ? data['name'] ?? '' : '',
      email: data != null ? data['email'] ?? '' : '',
      password: data != null ? data['password'] ?? '' : '',
      phone: data != null ? data['phone'] ?? '' : '',
      address: data != null ? data['address'] ?? '' : '',
      age: data != null && data['age'] != null ? data['age'] as int : 0,
      role: data != null ? data['user_type'] ?? '' : '', // <-- change here
    );
  }
}
