class EmployerSignUpModel {
  String? email;
  String? password;
  String? phoneNumber;

  EmployerSignUpModel({
    this.email,
    this.password,
    this.phoneNumber,
  });

  factory EmployerSignUpModel.fromMap(Map<String, dynamic> map) {
    return EmployerSignUpModel(
      email: map['email'] ?? 'NO DATA',
      password: map['password'] ?? 'NO DATA',
      phoneNumber: map['phoneNumber'] ?? 'NO DATA',
    );
  }
}
