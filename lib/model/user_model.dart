class UserModel {
  String uid; // This will be set after user is created in Firebase
  String email;
  String password;
  String username;
  String phoneNumber;
  String address;
  double balance;

  UserModel({
    this.uid = '',
    required this.email,
    required this.password,
    this.username = '',
    this.phoneNumber = '',
    this.address = '',
    this.balance = 0.0, // Default balance is set to 0
  });
}
