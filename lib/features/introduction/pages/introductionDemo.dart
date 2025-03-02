import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';

class IntroScreenDemo extends StatefulWidget {
  @override
  State<IntroScreenDemo> createState() => _IntroScreenDemoState();
}

class _IntroScreenDemoState extends State<IntroScreenDemo> {
  final _introKey = GlobalKey<IntroductionScreenState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Add Scaffold to center the IntroductionScreen
      body: Center(
        child: IntroductionScreen(
          key: _introKey,
          onDone: () {
            Navigator.pushReplacementNamed(context, '/login');
          },
          pages: [
            PageViewModel(
              title: 'Stay One Step Ahead',
              body:
                  "Skyguard delivers real-time weather updates and personalized alerts, so you'll always know what to expect. Plan your day with confidence.",
              image: Center(
                child: Image.asset('assets/images/one.jpg'),
              ),
              decoration: PageDecoration(
                titleTextStyle:
                    TextStyle(fontSize: 24, color: Colors.blue[600]),
                bodyTextStyle: TextStyle(fontSize: 18, color: Colors.grey[600]),
                pageColor: Colors.white,
                imagePadding: EdgeInsets.all(20),
              ),
            ),
            PageViewModel(
              title: 'Your Weather Guardian',
              body:
                  "We analyze current conditions and provide clear, actionable advice: is it safe to go out, or best to stay in? Skyguard keeps you protected.",
              image: Center(
                child: Image.asset('assets/images/two.jpg'),
              ),
              decoration: PageDecoration(
                titleTextStyle:
                    TextStyle(fontSize: 24, color: Colors.blue[600]),
                bodyTextStyle: TextStyle(fontSize: 18, color: Colors.grey[600]),
                pageColor: Colors.white,
                imagePadding: EdgeInsets.all(20),
              ),
            ),
            PageViewModel(
              title: 'Ready For Any Sky',
              body:
                  "From sunny days to unexpected storms, Skyguard gives you the information you need, right when you need it. Let's get started!",
              image: Center(
                child: Image.asset('assets/images/three.jpg'),
              ),
              decoration: PageDecoration(
                titleTextStyle:
                    TextStyle(fontSize: 24, color: Colors.blue[600]),
                bodyTextStyle: TextStyle(fontSize: 18, color: Colors.grey[600]),
                pageColor: Colors.white,
                imagePadding: EdgeInsets.all(20),
              ),
            ),
          ],
          next: Icon(Icons.arrow_forward),
          skip: const Text("Skip"),
          done: const Text("Done"),
          back: Icon(Icons.arrow_back),
          dotsDecorator: DotsDecorator(
            size: const Size.square(10.0),
            activeSize: const Size(20.0, 10.0),
            activeColor: Colors.blue[600],
            color: Colors.grey,
            spacing: const EdgeInsets.symmetric(horizontal: 3.0),
            activeShape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25.0)),
          ),
          showNextButton: true,
          showDoneButton: true,
          showSkipButton: true,
          showBackButton: true,
        ),
      ),
    );
  }
}
