import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/features/zoo_folder/Services/local_notifications.dart';
import 'package:flutter_application_1/features/zoo_folder/presentation/Screens/onBoarding_screen.dart';
import 'package:flutter_application_1/features/zoo_folder/presentation/Screens/register_screen.dart';
import 'package:flutter_application_1/features/zoo_folder/presentation/Widgets/wrapper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'features/zoo_folder/presentation/cubit/color_cubit.dart';

Future<void> backroundHandler(RemoteMessage message) async {
  print(" This is message from background");
  print(message.notification!.title);
  print(message.notification!.body);
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await FirebaseMessaging.instance.getToken();
  FirebaseMessaging.onBackgroundMessage(backroundHandler);

  SharedPreferences preferences = await SharedPreferences.getInstance();
  var status = preferences.getBool("isLoggedIn") ?? false;

  var name = preferences.getString("name") ?? '';
  var email = preferences.getString("email") ?? '';
  var image = preferences.getString("image");

  final showHome = preferences.getBool('showHome') ?? false;

  runApp(BlocProvider(
      create: (context) => ThemeCubit(),
      child: BlocBuilder<ThemeCubit, ThemeState>(
          builder: (context, state) => MaterialApp(
                theme: state.themeData,
                home: status == true
                    ? Wrapper(email: email, name: name, image: image)
                    : showHome
                        ? MyApp()
                        : onBoarding(),
                debugShowCheckedModeBanner: false,
              ))));
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String notificationMsg = "Waiting for notifications";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    LocalNotificationService.initilize();

    //Terminated State
    FirebaseMessaging.instance.getInitialMessage().then((event) {
      if (event != null) {
        setState(() {
          notificationMsg =
              "${event.notification!.title} ${event.notification!.body} I am coming from terminated state";
        });
      }
    });

    // Foregrand State
    FirebaseMessaging.onMessage.listen((event) {
      LocalNotificationService.showNotificationOnForeground(event);
      setState(() {
        notificationMsg =
            "${event.notification!.title} ${event.notification!.body} I am coming from foreground";
      });
    });

    // background State
    FirebaseMessaging.onMessageOpenedApp.listen((event) {
      setState(() {
        notificationMsg =
            "${event.notification!.title} ${event.notification!.body} I am coming from background";
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: RegisterScreen(),
    );
  }
}
