
import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import 'HomePage/home_page.dart';
import 'LoginPage/login_page.dart';


class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext? context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
  }
}
Future main() async {
  HttpOverrides.global = MyHttpOverrides();
  WidgetsFlutterBinding.ensureInitialized();

  Platform.isAndroid ? await Firebase.initializeApp(
    options: kIsWeb || Platform.isAndroid
        ? const FirebaseOptions(
      apiKey: 'AIzaSyBUA91qYmdwiieMNmOXBV5OBoOnuaEZYAk',
      appId: '1:964552601387:android:0d8ff94e209ddcb7dedf6e',
      messagingSenderId: '964552601387',
      projectId: 'real-estate-565af',
      storageBucket: "real-estate-565af.appspot.com",
    )
        : null,
  ) : await Firebase.initializeApp();





  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key,});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      // Use builder only if you need to use library outside ScreenUtilInit context
      builder: (_ , child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'First Method',
          // You can use the library anywhere in the app even in theme
          theme: ThemeData(
            primarySwatch: Colors.blue,
            textTheme: Typography.englishLike2018.apply(fontSizeFactor: 1.sp),
          ),
          home: child,
        );
      },
      child:  AuthenticationWrapper(),
    );



    //   MaterialApp(
    //   debugShowCheckedModeBanner: false,
    //   title: 'Flutter Demo',
    //   theme: ThemeData(
    //     colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
    //     useMaterial3: true,
    //   ),
    //   home:  AuthenticationWrapper(),
    //   // home:   PhoneAuthScreen(),
    // );
  }
}


class AuthenticationWrapper extends StatefulWidget {


  @override
  State<AuthenticationWrapper> createState() => _AuthenticationWrapperState();
}

class _AuthenticationWrapperState extends State<AuthenticationWrapper> {
  // final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;


  bool isLoggedIn = false;

  @override
  void initState() {
    super.initState();
    checkLoginStatus();
  }


  //   _firebaseMessaging.requestPermission();
  //   FirebaseMessaging.onMessage.listen((RemoteMessage message) {
  //     print("onMessage: $message");
  //   });
  //
  //   FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
  //     print("onMessageOpenedApp: $message");
  //   });
  //
  //   FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  // }
  // Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  //   print("Handling a background message: ${message.messageId}");
  // }


  Future<void> checkLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // Check if user credentials exist
    bool loggedIn = prefs.getBool('isLoggedIn') ?? false;
    if (loggedIn) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Homepage()),
      );
    } else {
      // If user is not logged in, navigate to login page
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginPage()),
      );
    }
  }
  @override
  Widget build(BuildContext context) {
    // You can show a loading indicator or splash screen here
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}



//
// class PushNotificationService {
//   Future<void> setupInteractedMessage() async {
//     await Firebase.initializeApp();
//     FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
//       if (message.data['type'] == 'chat') {
//         // Navigator.pushNamed(context, '/chat',
//         //     arguments: ChatArguments(message));
//       }
//     });
//     await enableIOSNotifications();
//     await registerNotificationListeners();
//   }
//
//   registerNotificationListeners() async {
//     AndroidNotificationChannel channel = androidNotificationChannel();
//     final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
//     FlutterLocalNotificationsPlugin();
//     await flutterLocalNotificationsPlugin
//         .resolvePlatformSpecificImplementation<
//         AndroidFlutterLocalNotificationsPlugin>()
//         ?.createNotificationChannel(channel);
//     var androidSettings =
//     new AndroidInitializationSettings('app_icon');
//
//     var iOSSettings = DarwinInitializationSettings(
//       requestSoundPermission: true,
//       requestBadgePermission: true,
//       requestAlertPermission: true,
//     );
//
//     var initSetttings =
//     InitializationSettings(android: androidSettings, iOS: iOSSettings);
//     flutterLocalNotificationsPlugin.initialize(initSetttings,
//         onDidReceiveNotificationResponse: (message) async {
//         });
//
//     FirebaseMessaging.onMessage.listen((RemoteMessage? message) {
//       print("message is: $message");
//       /* FlutterRingtonePlayer.play(fromAsset: "assets/12.mp3",asAlarm: true);*/
//       RemoteNotification? notification = message!.notification;
//       AndroidNotification? android = message.notification?.android;
//       if (notification != null && android != null) {
//         flutterLocalNotificationsPlugin.show(
//           notification.hashCode,
//           notification.title,
//           notification.body,
//           NotificationDetails(
//             android: AndroidNotificationDetails(
//               '123456', // id
//               'High Importance Notifications',
//               icon: android.smallIcon,
//               priority: Priority.high,
//               playSound: true,
//             ),
//           ),
//         );
//
//       }
//     });
//   }
// }
// enableIOSNotifications() async {
//   await FirebaseMessaging.instance
//       .setForegroundNotificationPresentationOptions(
//     alert: true, // Required to display a heads up notification
//     badge: true,
//     sound: true,
//   );
// }
// const sound =  "mixkit_melodic_gold_price_2000.wav";
// androidNotificationChannel() => const AndroidNotificationChannel(
//   '123456', // id
//   'High Importance Notifications', // description
//   importance: Importance.max,
//   playSound: true,
//   /*sound:  const UriAndroidNotificationSound("assets/12.mp3")*/
// );
//
// Future<void> myBackgroundMessageHandler(RemoteMessage message) async {
//   print("Handling a background message: ${message.messageId}");
//   // You can perform any required processing here.
//   // For example, show a notification, update local data, etc.
// }



