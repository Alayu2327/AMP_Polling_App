class User {
  String? username;
  String? phone_number;
  String? email;
  String? password;
  String? password_confirm;

  User({
    this.username,
    this.phone_number,
    this.email,
    this.password,
    this.password_confirm,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return  User(
        username: json['username'],
        phone_number: json['phone_number'],
        email: json['email'],
        password: json['password'],
        password_confirm: json['password_confirm']
    );
  }

  Map<String, dynamic> tojson() {
    return {
      "userName": username,
      "email": email,
      "phone_number": phone_number,
      "password": password,
      "password_confirm": password_confirm,
     
    };
  }
}
