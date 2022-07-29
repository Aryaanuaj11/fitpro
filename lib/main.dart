import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:fitpro/pages/diet_page.dart';
import 'package:fitpro/pages/home.dart';
import 'package:fitpro/pages/onboarding.dart';
import 'package:fitpro/pages/profile_page.dart';
import 'package:fitpro/pages/workout_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_overboard/flutter_overboard.dart';

void main() async{
  await dotenv.load(fileName: ".env");
  runApp( MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Nutrifit',
      debugShowCheckedModeBanner: false,
      theme: ThemeData( 
       primarySwatch: Colors.teal,
       brightness: Brightness.light,
       fontFamily: "WorkSans",
      ),
      home: FutureBuilder(
          future: Firebase.initializeApp(),
          builder: (context,snaps) {
                 return const OnboardingPage();
            return StreamBuilder<User?>(
              stream: FirebaseAuth.instance.authStateChanges(),
              builder: (context, snapshot) {
                if(!snapshot.hasData) return const OnboardingPage();
                return const HomePage();
            },
          );
        },
      ),
    );
  }
}
class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 2;

  final List<Widget> _pages = <Widget>[
    const DietPage(),
    const WorkoutPage(),
    const ProfilePage(),
  ];

  void _onItemTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Nutrifit"),
        ),
        body: _pages[_selectedIndex],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: _onItemTap,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.fastfood),
              label: 'Diet',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.fitness_center),
              label: 'Workout',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile',
            ),
          ],
        ));
  }
}


  




  