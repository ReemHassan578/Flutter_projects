class AppRegex {
  static bool isPasswordValid(String password) {
    RegExp regExp = RegExp(
       r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
 return   regExp.hasMatch(password);    
  }

  static bool hasUpperLetter(String password) {
    RegExp regExp = RegExp(r'^(?=.*?[A-Z])');
    return regExp.hasMatch(password);
  }

 static bool haslowerLetter(String password) {
    RegExp regExp = RegExp(r'^(?=.*[a-z])');
    return regExp.hasMatch(password);
  }

 static bool hasNumber(String password) {
    RegExp regExp = RegExp(r'^(?=.*?[0-9])');
    return regExp.hasMatch(password);
  }
  static bool hasSpeacialChar(String password) {
    RegExp regExp = RegExp(r'^(?=.*?[!@#\$&*~])');
    return regExp.hasMatch(password);
  }

  static bool has8DigitsOrMore(String password) {
    RegExp regExp = RegExp(r'^.{8,}$');
    return regExp.hasMatch(password);
  }

   static bool isPhoneValid(String phone) {
    RegExp regExp = RegExp(r'^(010||011||012||015)[0-9]{8}$');
    return regExp.hasMatch(phone);
  }

static  bool isEmailValid(String email) {
    RegExp regExp = RegExp(
       r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
 return   regExp.hasMatch(email);
  }
}