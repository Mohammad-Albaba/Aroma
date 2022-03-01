import 'package:apex2/layout/cubit/cubit.dart';
import 'package:apex2/modules/login/cubit/states.dart';
import 'package:apex2/modules/login/login_email.dart';
import 'package:apex2/shared/components/components.dart';
import 'package:apex2/shared/styles/colors.dart';
import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'cubit/cubit.dart';
import 'login_phone.dart';

class LoginScreen extends StatefulWidget {

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var formEmailKey = GlobalKey<FormState>();
  var formPhoneKey = GlobalKey<FormState>();
  var phoneController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  bool isClicked = true;

  void changeState(){
    if(isClicked){
      setState(() {
        isClicked = false;
      });
    }else
      setState(() {
        isClicked = true;
      });
  }
  String dialCodeDigits = '+00';
  TextEditingController _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginStates>(
      listener: (context, state){
        if (state is LoginPhoneSuccessState) {
          Navigator.of(context).push(MaterialPageRoute
            (builder: (c) => LoginPhone(
            phone: phoneController.text,
            codeDigits: dialCodeDigits,
          )));
        }
        if (state is LoginEmailSuccessState) {
          Navigator.of(context).push(MaterialPageRoute
            (builder: (c) => LoginEmail(
            email: emailController.text,
          ),
          ));
        }
      },
      builder: (context, state){
        return  Scaffold(
            appBar: AppBar(
              toolbarHeight: 0,
              systemOverlayStyle: SystemUiOverlayStyle(
                statusBarColor: Colors.black,
                statusBarIconBrightness: Brightness.light,
              ),
            ),
            body: SingleChildScrollView(
              child: Stack(
                alignment: AlignmentDirectional.center,
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height,
                    width: double.infinity,
                    child: Image(
                      image: AssetImage('assets/images/background.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    top: 20,
                    right: 16,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Icon(
                        Icons.cancel_presentation,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        RichText(
                          text: TextSpan(
                            children: <TextSpan>[
                              TextSpan(
                                text: 'si'.tr(),
                                style: TextStyle(
                                  color: primColor,
                                  fontSize: 24.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              TextSpan(
                                text: 'sign in'.tr(),
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 24.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Text(
                          'by'.tr(),
                          style: Theme.of(context).textTheme.subtitle2.copyWith(
                            color: Colors.white,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(30.0),
                          child: Row(
                            children: [
                              Expanded(
                                child: InkWell(
                                  onTap: () => changeState(),
                                  child: Container(
                                    alignment: AlignmentDirectional.center,
                                    height: 44.0,
                                    decoration: BoxDecoration(
                                      color: isClicked == true? primColor : greyColor,
                                      borderRadius: BorderRadius.circular(
                                        21.0,
                                      ),
                                    ),
                                    child: Text(
                                      'phone'.tr(),
                                      style: Theme.of(context).textTheme.subtitle1.copyWith(
                                        color: Colors.white,),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 20.0,
                              ),
                              Expanded(
                                child: InkWell(
                                  onTap: () => changeState(),
                                  child: Container(
                                    alignment: AlignmentDirectional.center,
                                    height: 44.0,
                                    decoration: BoxDecoration(
                                      color:isClicked != true? primColor : greyColor,
                                      borderRadius: BorderRadius.circular(
                                        21.0,
                                      ),
                                    ),
                                    child: Text(
                                      'emailAddress'.tr(),
                                      style: Theme.of(context).textTheme.subtitle1.copyWith(
                                        color: Colors.white,),
                                    ),
                                  ),

                                ),
                              ),
                            ],
                          ),
                        ),
                        isClicked == true  ? phoneUi(context,state) : emailUi(context,state),
                      ],
                    ),
                  ),
                ],
              ),
            )
        );
      },
    );
  }

  Widget phoneUi(BuildContext context, LoginStates state){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0),
      child: Form(
        key: formPhoneKey,
        child: Column(
          children: [
            Container(
              height: 44.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(22.0),
                color: backgroundTextFieldColor,
              ),
              child: Row(
                children: [
                  Expanded(
                    flex:3,
                    child: TextFormField(
                      keyboardType: TextInputType.phone,
                      controller: phoneController,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'phone'.tr(),
                        hintStyle: TextStyle(
                          fontSize: 14.0,
                          color: hintTextColor,
                        ),
                        contentPadding: EdgeInsets.symmetric(horizontal: 20.0,vertical: 10)
                      ),
                    validator: (String value) {
                    if (value.isEmpty) {
                      showToast(text: 'please enter phone', state:ToastStates.ERROR);
                    }
                    },
                    ),
                  ),
                  Expanded(
                    flex:2,
                    child: CountryCodePicker(
                      padding: EdgeInsets.only(
                        right: 20
                      ),
                      onChanged: (country){
                        setState(() {
                          dialCodeDigits = country.dialCode;
                        });
                      },
                      alignLeft: true,
                      textStyle: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                      initialSelection: 'IT',
                      showCountryOnly: false,
                      showOnlyCountryWhenClosed: false,
                      favorite: ['+1', 'US', '+92', 'PAK'],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(22.0),
                color: primColor,
              ),
              width: double.infinity,
              height: 44,
              child: MaterialButton(
                onPressed: (){
              if (formPhoneKey.currentState.validate()) {
                if (state is! LoginPhoneLoadingState) {
                   LoginCubit.get(context).userRegisterPhone(
                   mobile: '${dialCodeDigits}${phoneController.text}',
                  );
                }

                // CacheHelper.saveData(key: 'phone', value:  dialCodeDigits +'-'+ _controller.text);
              }
                },
                child: Text('send'.tr(),style: TextStyle(color: Colors.white,fontSize: 16.0,fontWeight: FontWeight.bold
                ),),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget emailUi(BuildContext context, LoginStates state){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0),
      child: Form(
        key: formEmailKey,
        child: Column(
          children: [
            Container(
              height: 44.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(22.0),
                color: backgroundTextFieldColor,
              ),
              child: TextFormField(
                keyboardType: TextInputType.emailAddress,
                controller: emailController,
                decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'emailAddress'.tr(),
                    hintStyle: TextStyle(
                      fontSize: 14.0,
                      color: hintTextColor,
                    ),
                    contentPadding: EdgeInsets.symmetric(horizontal: 20.0,vertical: 10)
                ),
                validator: (String value){
                  if (value.isEmpty) {
                    showToast(text: 'please enter emailAddress', state:ToastStates.ERROR);
                  }
                },
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(22.0),
                color: primColor,
              ),
              width: double.infinity,
              height: 44,
              child: MaterialButton(
                onPressed: (){
                if (formEmailKey.currentState.validate()) {
                 if (state is! LoginEmailLoadingState) {
                   LoginCubit.get(context).userRegisterEmail(
                     email: '${emailController.text}',
                   );
                 }
                  Navigator.of(context).push(MaterialPageRoute
                    (builder: (c) => LoginEmail()));
                }
                },
                child: Text('send'.tr(),style: TextStyle(color: Colors.white,fontSize: 16.0,fontWeight: FontWeight.bold
                ),),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
