import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get/get_navigation/src/root/internacionalization.dart';
import 'package:provider/provider.dart';
import 'auth_screen/splase_screen.dart';
import 'common_code/colore_screen.dart';
import 'common_code/language_translate.dart';

Future<void> main() async {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ColorNotifier(),),
      ],
      child: GetMaterialApp(
        // title: "GoFund",
        debugShowCheckedModeBanner: false,
        // translations: AppTranslations(),
        // locale: const Locale('en', 'English'),
        translations: AppTranslations(),
        locale: const Locale('en', 'English'),
        theme: ThemeData(
          fontFamily: 'SofiaRegular',
          useMaterial3: false,
          splashColor: Colors.transparent,
          hoverColor: Colors.transparent,
          highlightColor: Colors.transparent,
          dividerColor: Colors.transparent,
        ),
        home: const Splase_Screen(),
        // home: GradientProgressBar(),
        // home: SliderColorScreen(),
        // home: RideCompletePaymentScreen(),
        // home: RideCompletePaymentScreen(),
        // home: HomeScreen1(),
        // home: TimerScreen(),
        // home: MyHomePage(title: 'done',),
      ),
    );
  }
}



class AppTranslationsapp extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
    'en_US': {
      'enter_mail': 'Enter your email',
    },
    'ur_PK': {
      'enter_mail': 'اپنا ای میل درج کریں۔',
    }
  };
}