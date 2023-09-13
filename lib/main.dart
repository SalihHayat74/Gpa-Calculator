import 'package:flutter/material.dart';
import 'package:gpa_calculator_1/screens/homepage.dart';


//→ 1. git init
// → 2. git add .
// → 3. git commit -m "description"
// → 4. git branch -M branchName
// → 5. git remote add origin repoUrl
// → 6. git push -u origin branchName --force
// ->7. git config --global http.proxy ""


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {



    return MaterialApp(
      color: const Color(0xffffffff),


      themeMode: ThemeMode.light,
        theme: ThemeData(
          primarySwatch: Colors.blue,
          scaffoldBackgroundColor: Colors.white

        ),
            debugShowCheckedModeBanner: false,
      title: 'GPA Calculator',

      home: const HomepageScreen()
    );
  }
}
