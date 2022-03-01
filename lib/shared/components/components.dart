import 'package:apex2/shared/styles/icon_broken.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

Widget defaultButton({
  double width = double.infinity,
  Color background = Colors.blue ,
  bool isUpperCase = true,
  double radius = 0.0,
  @required Function function,
  @required String text,
}) =>  Container(
  width: width,
  height: 50.0,
  child: MaterialButton(
    onPressed: function,
    child: Text(
      isUpperCase ? text.toUpperCase() : text,
      style: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
        fontSize: 15.0,
      ),
    ),
  ),
  decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(
      radius,
    ),
    color: background,
  ),
);

Widget defaultTextButton({
  @required Function function,
  @required String text,
}) =>
    TextButton(onPressed: function,
      child: Text(
        text.toUpperCase(),
      ),
    );

Widget defaultFormField({
  TextEditingController controller,
  @required TextInputType type,
  Function onSubmit,
  Function onChange,
  Function onTap,
  bool isClickable = true,
  bool isPassword = false,
  @required Function validate,
  @required String label,
  String hint,
   IconData prefix,
  IconData suffix,
  Function suffixPressed,
}) =>  TextFormField(
  controller: controller,
  keyboardType: type,
  obscureText: isPassword,
  onFieldSubmitted: onSubmit,
  onChanged: onChange,
  onTap: onTap,
  enabled: isClickable,
  validator: validate,
  decoration: InputDecoration(
    labelStyle: TextStyle(
      fontSize: 16.0,
      color: Colors.grey,
    ),
    labelText: label,
    hintText: hint,
    prefixIcon: Icon(
      prefix,
    ),
    suffixIcon: suffix != null ? IconButton(
        onPressed: suffixPressed,
        icon: Icon(
          suffix,
        )
    ) : null,
    border: OutlineInputBorder(),
  ),
);

void navigateTo(context, widget) => Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => widget,
    )
);

void navigateAndFinish(context, widget) => Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(
      builder: (context) => widget,
    ),
        (route){
      return false;
    }
);
void showToast({
  @required String text,
  @required ToastStates state,
}) => Fluttertoast.showToast(
    msg: text,
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 5,
    backgroundColor: chooseToastColor(state),
    textColor: Colors.white,
    fontSize: 16.0
);
enum ToastStates{SUCCESS, ERROR,WARNING}

Color chooseToastColor(ToastStates state)
{
  Color color;
  switch(state)
  {
    case ToastStates.SUCCESS :
      color = Colors.green;
      break;
    case ToastStates.ERROR :
      color = Colors.red;
      break;
    case ToastStates.WARNING :
      color = Colors.amber;
      break;
  }
  return color;
}

Widget myDivider() => Padding (
  padding: const EdgeInsetsDirectional.only(
    start: 20.0,
    end: 16.0,
  ),
  child: Container(
    width: double.infinity,
    height: 1.0,
    color: Colors.grey[300],
  ),
);

Widget defaultAppBar({
  @required BuildContext context,
  String title,
  List<Widget> actions,
  AppBarTheme theme,
  Color backgroundColor,
}) => AppBar(
  centerTitle: true,
  backgroundColor: backgroundColor,
  leading: IconButton(
    onPressed: (){
      Navigator.pop(context);
    },
    icon: Icon(
      IconBroken.Arrow___Left_2,
    ),
  ),
   titleSpacing: 90.0,
  title: Text(
    title,
    textAlign: TextAlign.center,
  ),
  actions: actions,
);

Widget defaultCheckBox({
  @required Function onChange,
  @required String title,
  bool isCheckbox = false,

}) => CheckboxListTile(
    controlAffinity: ListTileControlAffinity.leading,
    title: Text(title),
    value: isCheckbox,
    onChanged: onChange,
  );