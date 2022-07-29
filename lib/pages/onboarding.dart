import 'package:fitpro/pages/auth/login.dart';
import 'package:fitpro/pages/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_overboard/flutter_overboard.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({Key? key}) : super(key: key);

    @override
    _OnboardingPageState createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> with TickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _globalKey,
      body: OverBoard(
        allowScroll: true,
        pages: pages,
        showBullets: true,
        inactiveBulletColor: Colors.blue,
        // backgroundProvider: NetworkImage('https://picsum.photos/720/1280'),
        skipCallback: () {
          Navigator.of(context).pushReplacement(
            PageRouteBuilder(pageBuilder: (context, animation, secondaryAnimation) => LoginPage(),
            transitionsBuilder: 
            (context, animation, secondaryAnimation, child) => 
            FadeTransition(opacity: animation,
            child: child,),),
          );
        },
        finishCallback: () {
          Navigator.of(context).pushReplacement(
            PageRouteBuilder(pageBuilder: (context, animation, secondaryAnimation) => LoginPage(),
            transitionsBuilder: 
            (context, animation, secondaryAnimation, child) => 
            FadeTransition(opacity: animation,
            child: child,),),
          );
        },
      ),
    );
  }
}

  final pages = [
    PageModel(
        color: Color.fromARGB(255, 4, 69, 51),
        imageAssetPath: 'assets/images/2.jpg',
        title: 'Be Healthy',
        body: 'A healthy outside starts from the inside',
        doAnimateImage: true),
    PageModel(
        color: Color.fromARGB(255, 4, 69, 51),
        imageAssetPath: 'assets/images/10.webp',
        title: 'Be Fit',
        body: 'Nothing will work unless you do',
        doAnimateImage: true),
    PageModel(
        color: Color.fromARGB(255, 4, 69, 51),
        imageAssetPath: 'assets/images/11.webp' ,
        title: 'Be an inspiration',
        body:'',
        doAnimateImage: true),
    PageModel.withChild(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 20.0),
          child: Image.asset('assets/images/1.png', width: 400.0, height: 400.0),
        ),
        color: Color.fromARGB(255, 4, 69, 51),
        doAnimateChild: true)
  ];