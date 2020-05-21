class User {
  String firstName = '';
  String lastName = '';
  String email = '';
  String status = '';
  String password = '';
  String rePassword = '';
  String address = '';
}

class Login {
  final String uid;
  String emailLog = '';
  String passwordLog = '';

  Login({this.uid});
  
  login() {
    return true;
  }
}
