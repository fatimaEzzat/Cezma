class UserModel {
  late String? firstName;
  late String? secondName;
  late String? phone;
  late String? email;
  late String? address;
  late String? fullName;
  UserModel(
      {required this.firstName,
      required this.address,
      required this.email,
      required this.phone,
      required this.secondName,
      required this.fullName});
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
        address: json["address"] as String,
        email: json["email"] as String,
        firstName: json["first_name"] as String,
        phone: json["phone"] as String,
        secondName: json["last_name"] as String,
        fullName: json["full_name"] as String);
  }
}
