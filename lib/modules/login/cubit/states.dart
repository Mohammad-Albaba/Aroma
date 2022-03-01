import 'package:apex2/models/RegisterModel.dart';

abstract class LoginStates {}

class LoginInitialState extends LoginStates {}

class LoginPhoneLoadingState extends LoginStates {}

class LoginPhoneSuccessState extends LoginStates {
final RegisterModel registerModel;
LoginPhoneSuccessState(
    this.registerModel
    );

}

class LoginPhoneErrorState extends LoginStates {
  final String error;

  LoginPhoneErrorState(this.error);
}

class LoginEmailLoadingState extends LoginStates {}

class LoginEmailSuccessState extends LoginStates {
}

class LoginEmailErrorState extends LoginStates {
  final String error;

  LoginEmailErrorState(this.error);
}

class ActiveUserLoadingState extends LoginStates {}

class ActiveUserSuccessState extends LoginStates {
}

class ActiveUserErrorState extends LoginStates {
  final String error;

  ActiveUserErrorState(this.error);
}

class ChangePasswordVisibilityState extends LoginStates {}