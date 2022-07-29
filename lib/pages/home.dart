
import 'package:fitpro/main.dart';
import 'package:fitpro/pages/onboarding.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitpro/pages/onboarding.dart';
import 'package:fitpro/pages/profile_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
              Navigator.of(context).pushReplacement(
                PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) =>
                      OnboardingPage(),
                  transitionsBuilder:
                      (context, animation, secondaryAnimation, child) =>
                          FadeTransition(
                    opacity: animation,
                    child: child,
                  ),
                ),
              );
            },
          )
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: ((context) => MyHomePage(title: 'nutrifit'))));
            },
            label: const Text('Get Started !'),
            icon: const Icon(Icons.arrow_forward),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
          body: Padding(
            padding: const EdgeInsets.only(left: 40),
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Row(
                children: const [
                  Text(
                    'Welcome To',
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.w200,
                    ),
                  ),
                ],
              ),
              Row(children: [
                const Text(
                  'NutriFit',
                  style: TextStyle(
                      fontFamily: 'open sans',
                      fontSize: 60,
                      fontWeight: FontWeight.bold,
                      // color: Theme.of(context).primaryColor
                      ),
                )
              ]),
            ]),
          ),
        );
  }
}