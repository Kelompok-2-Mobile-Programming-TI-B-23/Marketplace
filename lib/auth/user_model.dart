class UserModel {
  String uid; // This will be set after user is created in Firebase
  String email;
  String password;
  String username;
  String phoneNumber;
  String address;

  UserModel({
    this.uid = '',
    required this.email,
    required this.password,
    this.username = '',
    this.phoneNumber = '',
    this.address = '',
  });
}
