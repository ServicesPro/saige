class Verify {
  String email;
  String pseudo;
  String password;

  Verify({this.email, this.pseudo, this.password});

  Verify.fromMap(Map<String, dynamic> data)
      : email = data['email'],
        pseudo = data['pseudo'],
        password = data['password'];

  Map<String, dynamic> toJson() {
    return {
      'email': this.email,
      'pseudo': this.pseudo,
      'password': this.password,
    };
  }
}
