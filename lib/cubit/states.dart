class AppStates  {}

class InitState extends AppStates {}

class LoginSucssesState extends AppStates {}

class LoginErorrState extends AppStates {
  var error;

  LoginErorrState(this.error);
}

class LodingState extends AppStates {}

class BottomNavBarState extends AppStates {}

class HomeDataSucssesState extends AppStates {}

class HomeDataErorrState extends AppStates {
  var error;

  HomeDataErorrState(this.error);
}

class CategoriesDataSucssesState extends AppStates {}

class CategoriesDataErorrState extends AppStates {
  var error;

  CategoriesDataErorrState(this.error);
}
class FavoriteChangeSucssesState extends AppStates {}

class FavoriteChangeErorrState extends AppStates {
  var error;

  FavoriteChangeErorrState(this.error);
}

class FavoriteDataSucssesState extends AppStates {}

class FavoriteDataErorrState extends AppStates {
  var error;

  FavoriteDataErorrState(this.error);
}
