class UserProfile {
  String? firstName;
  String? lastName;
  dynamic email;
  dynamic phoneNumber;

  UserProfile({this.firstName, this.lastName, this.email, this.phoneNumber});

  UserProfile.fromJson(Map<String, dynamic> json) {
    firstName = json['firstName'];
    lastName = json['lastName'];
    email = json['email'];
    phoneNumber = json['phoneNumber'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['email'] = this.email;
    data['phoneNumber'] = this.phoneNumber;
    return data;
  }
}
