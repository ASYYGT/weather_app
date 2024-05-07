import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weaather_app/screens/splash/splash_page.dart';

void main() {
  runApp(const MyApp());
}

const apiKey =
    "********************************"; //openweathermap Sitesinden ApiKey Eklenmesi gerekiyor.

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            appBarTheme: const AppBarTheme(
              iconTheme: IconThemeData(
                color: Colors.black,
              ),
            ),
          ),
          home: const SplashPage(),
        );
      },
    );
  }
}
