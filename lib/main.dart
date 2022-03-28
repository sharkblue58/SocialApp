import 'package:bloc/bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_social_app/layout/social_layout.dart';
import 'package:my_social_app/shared/component/constants.dart';
import 'package:my_social_app/shared/network/local/cache_helper.dart';
import 'package:my_social_app/shared/network/remote/dio_helper.dart';
import 'package:my_social_app/shared/style/themes.dart';
import 'block_observer.dart';
import 'layout/cubit/cubit.dart';
import 'layout/cubit/states.dart';
import 'modules/login/social_login_screen.dart';
import 'package:firebase_messaging/firebase_messaging.dart';


Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
print('on background message');
print(message.data.toString());
}
void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  var token = await FirebaseMessaging.instance.getToken();
  FirebaseMessaging.onMessage.listen((event) { print(event.data.toString());});
  FirebaseMessaging.onMessageOpenedApp.listen((event) { print(event.data.toString());});
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  print('device token');
  print(token);
  DioHelper.init();
  await CacheHelper.init();
  Widget widget;
  Bloc.observer = MyBlocObserver();
   uId = CacheHelper.getData(key: 'uId');
  if(uId!=null)
  {
      widget=SocialLayout();
    }else{widget=SocialLoginScreen();}


  runApp( MyApp(startwidget:widget));
}

class MyApp extends StatelessWidget {

  final Widget startwidget;
  MyApp({required this.startwidget});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (BuildContext context)=>SocialCubit()..getUserData()..getPosts(),),
      ],
      child: BlocConsumer<SocialCubit,SocialStates>(
        listener:(context,state){} ,
        builder:(context,state){
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: lightTheme,
            darkTheme:darkTheme,
            themeMode: ThemeMode.light,
            home:startwidget,
          );
        } ,
      ),
    );
  }
}


