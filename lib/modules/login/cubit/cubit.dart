import 'package:apex2/models/ActiveModel.dart';
import 'package:apex2/models/RegisterModel.dart';
import 'package:apex2/modules/login/cubit/states.dart';
import 'package:apex2/shared/components/constant.dart';
import 'package:apex2/shared/network/end_points.dart';
import 'package:apex2/shared/network/local/cache_helper.dart';
import 'package:apex2/shared/network/remote/dio_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(LoginInitialState());

  static LoginCubit get(context) => BlocProvider.of(context);

  RegisterModel registerModel;
  String activeCode;
  void userRegisterPhone({
    @required String mobile,
  }) {
    emit(LoginPhoneLoadingState());
    DioHelper.postData(
        url: REGISTER,
        data: {
      'mobile': mobile,
    }).then((value) {
      print('RegisterModelData' + value.data.toString());
      registerModel = RegisterModel.fromJson(value.data);
      activeCodePhone = registerModel.data.user.activeCode;
      emit(LoginPhoneSuccessState(registerModel));
    }).catchError((error) {
      emit(LoginPhoneErrorState(error.toString()));
      print('${error.toString()} + error');
    });
  }

  void userRegisterEmail({
    @required String email,
  }) {
    emit(LoginEmailLoadingState());
    DioHelper.postData(
        url: REGISTER,
        data: {
          'email': email,
        }).then((value) {
      print('RegisterModelData' + value.data.toString());
      registerModel = RegisterModel.fromJson(value.data);
      activeCodeEmail = registerModel.data.user.activeCode;
      emit(LoginEmailSuccessState());
    }).catchError((error) {
      emit(LoginEmailErrorState(error.toString()));
      print('${error.toString()} + error');
    });
  }
  
  ActiveModel activeModel;
  var timToken;
  void activePhoneUser({
  @required ActiveCode,
}){
    emit(ActiveUserLoadingState());
    DioHelper.postData(
        url: '$ACTIVEUSER?active_code=${activeCodePhone}',
        data: {
          'active_code' : ActiveCode,
        },
    ).then((value) => {
      // print('ValueData ${value.data.toString().contains('message')}'),
      activeModel =  ActiveModel.fromJson(value.data),
       timToken = printFullText(('${activeModel.data.token}'),),
       //timToken = activeModel.data.token,
      CacheHelper.saveData(
        key: 'token',
        value: "Bearer $timToken",
      ).then((value)  => {
        token = 'Bearer $timToken',
      }),
      emit(ActiveUserSuccessState()),
    }).catchError((error) {
      emit(ActiveUserErrorState(error.toString()));
      print('${error.toString()} + error');
    });;
  }

  void activeEmailUser({
    @required ActiveCode,
  }){
    emit(ActiveUserLoadingState());
    DioHelper.postData(
        url: '$ACTIVEUSER?active_code=${activeCodeEmail}',
        data: {
          'active_code' : ActiveCode,
        }
    ).then((value) {

      activeModel = ActiveModel.fromJson(value.data);
      var timToken = activeModel.data.token;
      CacheHelper.saveData(
        key: 'token',
        value: "Bearer $timToken",
      ).then((value) => {
        token = 'Bearer $timToken',
      });
      emit(ActiveUserSuccessState());
    }).catchError((error) {
      emit(ActiveUserErrorState(error.toString()));
      print('${error.toString()} + error');
    });;
  }


  IconData suffix = Icons.visibility_outlined;
  bool isPassword = true;

  void changePasswordVisibility() {
    isPassword = !isPassword;
    suffix =
    isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(ChangePasswordVisibilityState());
  }
}