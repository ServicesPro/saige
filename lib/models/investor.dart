class Investor {
  String fullName;
  String email;
  String phone;
  String country;
  String amount;

  Investor({this.fullName, this.email, this.phone, this.country, this.amount});

  Investor.fromMap(Map<String, dynamic> data)
      : fullName = data['fullName'],
        email = data['email'],
        phone = data['phone'],
        country = data['country'],
        amount = data['amount'];

  Map<String, dynamic> toJson() {
    return {
      'fullName': fullName,
      'email': email,
      'phone': phone,
      'country': country,
      'amount': amount,
    };
  }
}
