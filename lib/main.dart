import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:moviee/screens/main_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          color: const Color(0xFFF2F2F2),
          elevation: 0,
          iconTheme: IconThemeData(
            color: Color(0xFF212121),
          ),
          titleTextStyle: GoogleFonts.montserrat(
            color: Color(0xFF212121),
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: const Color(0xFFF2F2F2),
          selectedItemColor: Color(0xFF5EC570),
          unselectedItemColor: Colors.grey,
        ),
        textTheme:
            GoogleFonts.montserratTextTheme(),
        scaffoldBackgroundColor: const Color(0xFFF2F2F2),
      ),
      home: MainScreen(),
    );
  }
}
