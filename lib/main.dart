import 'package:apex2/layout/cubit/states.dart';
import 'package:apex2/layout/home_layout.dart';
import 'package:apex2/modules/home_screen.dart';
import 'package:apex2/modules/login/cubit/states.dart';
import 'package:apex2/modules/login/login_screen.dart';
import 'package:apex2/modules/product_details.dart';
import 'package:apex2/shared/bloc_observer.dart';
import 'package:apex2/shared/components/components.dart';
import 'package:apex2/shared/components/constant.dart';
import 'package:apex2/shared/network/local/cache_helper.dart';
import 'package:apex2/shared/network/remote/dio_helper.dart';
import 'package:apex2/shared/styles/colors.dart';
import 'package:apex2/shared/styles/themes.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';

import 'layout/cubit/cubit.dart';
import 'modules/login/cubit/cubit.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  //await Firebase.initializeApp();
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CacheHelper.init();
  runApp(EasyLocalization(
      supportedLocales: [Locale('en'), Locale('ar')],
      path: 'assets/languages', // <-- change the path of the translation files
      fallbackLocale: Locale('en'),
      child: MyApp()
  )
  );
}

class MyApp extends StatelessWidget {

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (BuildContext context) => ApexCubit(),
        ),
        BlocProvider(
          create: (BuildContext context) => LoginCubit(),
        ),
      ],
      child: BlocConsumer<ApexCubit,ApexStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode: ThemeMode.light,
            home: SplashScreen(),
            localizationsDelegates: context.localizationDelegates,
            supportedLocales: context.supportedLocales,
            locale: context.locale,
          );
        },
      ),
    );
  }
}
class SplashScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 3)).then((value){
      navigateAndFinish(context, LoginScreen(),);
    }
    );
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        toolbarHeight: 0,
        shadowColor: endAppbarColor,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: endAppbarColor,
          statusBarIconBrightness: Brightness.light,
        ),
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        child: Image(
          image: AssetImage('assets/images/splach.png'),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

