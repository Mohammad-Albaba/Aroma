import 'package:apex2/layout/cubit/cubit.dart';
import 'package:apex2/layout/home_layout.dart';
import 'package:apex2/modules/login/cubit/states.dart';
import 'package:apex2/shared/components/components.dart';
import 'package:apex2/shared/components/constant.dart';
import 'package:apex2/shared/styles/colors.dart';
import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'cubit/cubit.dart';

class LoginEmail extends StatefulWidget {
 final String email;
 LoginEmail({
   this.email,
 });

  @override
  State<LoginEmail> createState() => _LoginEmailState();
}

class _LoginEmailState extends State<LoginEmail> {
  var formLoginEmailKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var codeController = TextEditingController();
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginStates>(
      listener: (context, state){},
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
                  Padding(
                    padding: const EdgeInsets.only(top: 150),
                    child: Center(
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
                                    onTap: () => {},
                                    child: Container(
                                      alignment: AlignmentDirectional.center,
                                      height: 44.0,
                                      decoration: BoxDecoration(
                                        color: greyColor,
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
                                    onTap: () => {},
                                    child: Container(
                                      alignment: AlignmentDirectional.center,
                                      height: 44.0,
                                      decoration: BoxDecoration(
                                        color: primColor,
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
                           emailUi(context, state),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            )
        );
      },
    );
  }
  Color getColor(Set<MaterialState> states) {
    const Set<MaterialState> interactiveStates = <MaterialState>{
      MaterialState.pressed,
      MaterialState.hovered,
      MaterialState.focused,
    };
    if (states.any(interactiveStates.contains)) {
      return primColor;
    }
    return primColor;
  }

  Widget emailUi(BuildContext context, LoginStates state){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0),
      child: Form(
        key: formLoginEmailKey,
        child: Column(
          children: [
            Container(
              height: 44.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(22.0),
                color: backgroundTextFieldColor,
              ),
              child: TextFormField(
                controller: TextEditingController(text: widget.email),
                keyboardType: TextInputType.emailAddress,
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
                    showToast(text: 'please enter email', state:ToastStates.ERROR);
                  }
                },
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            Container(
              height: 44.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(22.0),
                color: backgroundTextFieldColor,
              ),
              child: TextFormField(
                controller: codeController,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'code'.tr(),
                    hintStyle: TextStyle(
                      fontSize: 14.0,
                      color: hintTextColor,
                    ),
                    contentPadding: EdgeInsets.symmetric(horizontal: 20.0,vertical: 10)
                ),
                validator: (String value){
                  if (value.isEmpty) {
                    showToast(text: 'please enter code', state:ToastStates.ERROR);
                  }
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Checkbox(
                    checkColor: primColor,
                    fillColor: MaterialStateProperty.resolveWith(getColor),
                    activeColor: primColor,
                    value: isChecked,
                    onChanged: (bool value) {
                      setState(() {
                        isChecked = value;
                      });
                    },
                    side: MaterialStateBorderSide.resolveWith((states) => BorderSide(color: Colors.white)),
                  ),
                  SizedBox(
                    width: 2,
                  ),
                  Expanded(
                    child: Text(
                      'policy'.tr(),
                      overflow: TextOverflow.clip,
                      maxLines: 2,
                      style: TextStyle(
                        fontSize: 12.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 10,
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
                  if (formLoginEmailKey.currentState.validate()) {
                    if( activeCodeEmail == codeController.text){
                      navigateAndFinish(context, HomeLayout());
                      if(state is! ActiveUserLoadingState){
                        LoginCubit.get(context).activeEmailUser(
                          ActiveCode: activeCodeEmail,
                        );
                      }
                    }else{
                      showToast(text: 'الايميل أو كود التحقق خطأ', state: ToastStates.ERROR);
                    }
                  }
                  // CacheHelper.saveData(key: 'phone', value:  dialCodeDigits +'-'+ _controller.text);
                },
                child: Text('send'.tr(),style: TextStyle(color: Colors.white,fontSize: 16.0,fontWeight: FontWeight.bold
                ),),
              ),
            ),
            SizedBox(
              height: 33.0,
            ),
            Text(
              'retrySendCode'.tr(),
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
