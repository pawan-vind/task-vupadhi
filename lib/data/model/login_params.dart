class LoginParams {
  final String userName;
  final String password;
  final String usedsalt;
  final String lang;

  LoginParams({
    required this.userName,
    required this.password,
    required this.usedsalt,
    required this.lang,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'userName': userName,
      'password': password,
      'usedsalt': usedsalt,
      'lang': lang
    };
  }
}
