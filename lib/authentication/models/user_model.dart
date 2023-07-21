class UserModel {
  UserModel({
    String? token,
    String? firstName,
    String? lastName,
    String? role,
    String? email,
  }) {
    _token = token;
    _firstName = firstName;
    _lastName = lastName;
    _role = role;
    _email = email;
  }

  UserModel.fromJson(dynamic json) {
    _token = json['token'];
    _firstName = json['firstName'];
    _lastName = json['lastName'];
    _role = json['role'];
    _email = json['email'];
  }
  String? _token;
  String? _firstName;
  String? _lastName;
  String? _role;
  String? _email;

  String? get token => _token;
  String? get firstName => _firstName;
  String? get lastName => _lastName;
  String? get role => _role;
  String? get email => _email;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['token'] = _token;
    map['firstName'] = _firstName;
    map['lastName'] = _lastName;
    map['role'] = _role;
    map['email'] = _email;
    return map;
  }
}
