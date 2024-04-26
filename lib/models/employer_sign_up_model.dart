class EmployerSignUpModel {
  String? email;
  String? password;

  EmployerSignUpModel({
    this.email,
    this.password,
  });

  factory EmployerSignUpModel.fromMap(Map<String, dynamic> map) {
    return EmployerSignUpModel(
      email: map['email'] ?? 'NO DATA',
      password: map['password'] ?? 'NO DATA',
    );
  }
}
