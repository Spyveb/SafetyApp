import 'package:distress_app/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'imports.dart';

GlobalKey<NavigatorState> navState = GlobalKey<NavigatorState>();
bool? fromMain;
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await FirebaseMessages().getFCMToken();

  // FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  // FCM in app Terminated State
  RemoteMessage? initialMessage = await FirebaseMessaging.instance.getInitialMessage();

  if (initialMessage != null) {
    fromMain = true;
    FirebaseMessages.notificationOperation(message: initialMessage.data, fromTerminate: true);
    print("initialMessage -- ${initialMessage.data}");
  }

  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool? savedTheme = prefs.getBool(Constants.isDarkThemeSelected);
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => ThemeProvider(initialTheme: savedTheme ?? false),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

// @pragma('vm:entry-point')
// Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
//   // If you're going to use other Firebase services in the background, such as Firestore,
//   // make sure you call `initializeApp` before using other Firebase services.
//
//   print("Handling a background message: ${message.messageId}");
//   print(message.data);
// }

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  static void setLocale(BuildContext context, Locale newLocale) {
    _MyAppState state = context.findAncestorStateOfType<_MyAppState>()!;
    state.setLocale(newLocale);
  }

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    getCurrentLanguage();
    super.initState();
  }

  Locale? _locale;

  void getCurrentLanguage() async {
    String? lang = await StorageService().readSecureData(Constants.language);

    if (lang != null) {
      if (lang == Constants.afLanguage) {
        _locale = Locale(Constants.afLanguage, "NA");
      } else if (lang == Constants.deLanguage) {
        _locale = Locale(Constants.deLanguage, "DE");
      } else if (lang == Constants.enLanguage) {
        _locale = Locale(Constants.enLanguage, "US");
      } else if (lang == Constants.frLanguage) {
        _locale = Locale(Constants.frLanguage, "FR");
      }
    } else {
      _locale = Locale(Constants.enLanguage, "US");
    }

    setState(() {});
  }

  // Sets the locale for the application.
  void setLocale(Locale locale) {
    if (mounted) {
      setState(() {
        _locale = locale;
      });
    }
  }

  List<LocalizationsDelegate<dynamic>> localizationsDelegates = [
    AppLocalizations.delegate,
    CountryLocalizations.delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return Consumer<ThemeProvider>(builder: (context, themeProvider, _) {
      return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        localizationsDelegates: localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        locale: _locale,
        title: 'Distress App',
        theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primaryColor, onBackground: Colors.white),
            useMaterial3: true,
            fontFamily: AppFonts.sansFont400,
            scaffoldBackgroundColor: AppColors.whiteColor,
            appBarTheme: AppBarTheme(
              backgroundColor: AppColors.whiteColor,
            )),
        navigatorKey: navState,
        getPages: AppPages.routes,
        initialRoute: Routes.SPLASH,
        initialBinding: SplashBinding(),
      );
    });
  }
}
