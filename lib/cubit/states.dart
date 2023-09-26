class AppStates  {}

class InitState extends AppStates {}

class LoginSucssesState extends AppStates {}

class LoginErorrState extends AppStates {
  var error;

  LoginErorrState(this.error);
}

class LodingState extends AppStates {}