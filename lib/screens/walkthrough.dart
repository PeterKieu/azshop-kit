import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:azshop/screens/join.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Walkthrough extends StatefulWidget {
  @override
  _WalkthroughState createState() => _WalkthroughState();
}

class _WalkthroughState extends State<Walkthrough> {

  _WalkthroughState(){
    checkSkip();
  }

  bool skip = false; //for first time running app
  bool getSkip(){
    return skip;
  }

  void setSkip(bool value){
    this.skip = value;
    //save in shared preference for future use
    SharedPreferences.getInstance().then((prefs){
      prefs.setBool("WalkthroughState", value);
    });

  }


  Future<bool> checkSkip() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool value = prefs.getBool("WalkthroughState") == null ? false : prefs.getBool("WalkthroughState");
    setSkip(value);
    return value;
  }

  @override
  Widget build(BuildContext context) {
    //
    if(skip){
      //
      return JoinApp();
    }else {
      //build popup pages
      List<PageViewModel> pages = [
        PageViewModel(
          "Fresh Food",
          "The art of cooking comes from fresh food",
          image: Image.asset(
            "assets/on1.png",
            height: 175.0,
          ),
          decoration: PageDecoration(
            titleTextStyle: TextStyle(
              fontSize: 28.0,
              fontWeight: FontWeight.w600,
              color: Theme
                  .of(context)
                  .accentColor,
            ),
            bodyTextStyle: TextStyle(fontSize: 15.0),
            dotsDecorator: DotsDecorator(
              activeColor: Theme
                  .of(context)
                  .accentColor,
              activeSize: Size.fromRadius(8),
            ),
            pageColor: Theme
                .of(context)
                .primaryColor,
          ),
        ),

        PageViewModel(
          "Fast Delivery",
          "Hot and delicous taste go along with the fast delivery service",
          image: Image.asset(
            "assets/on2.png",
            height: 185.0,
          ),
          decoration: PageDecoration(
            titleTextStyle: TextStyle(
              fontSize: 28.0,
              fontWeight: FontWeight.w600,
              color: Theme
                  .of(context)
                  .accentColor,
            ),
            bodyTextStyle: TextStyle(fontSize: 15.0),
            dotsDecorator: DotsDecorator(
              activeColor: Theme
                  .of(context)
                  .accentColor,
              activeSize: Size.fromRadius(8),
            ),
            pageColor: Theme
                .of(context)
                .primaryColor,
          ),
        ),

        PageViewModel(
          "Easy Payment",
          "Customer centric is followed by simple and easy payment medium ",
          image: Image.asset(
            "assets/on3.png",
            height: 175.0,
          ),
          decoration: PageDecoration(
            titleTextStyle: TextStyle(
              fontSize: 28.0,
              fontWeight: FontWeight.w600,
              color: Theme
                  .of(context)
                  .accentColor,
            ),
            bodyTextStyle: TextStyle(fontSize: 15.0),
            dotsDecorator: DotsDecorator(
              activeColor: Theme
                  .of(context)
                  .accentColor,
              activeSize: Size.fromRadius(8),
            ),
            pageColor: Theme
                .of(context)
                .primaryColor,
          ),
        ),
      ];

      return WillPopScope(
        onWillPop: () => Future.value(false),
        child: Scaffold(
          backgroundColor: Theme
              .of(context)
              .primaryColor,
          body: Padding(
            padding: EdgeInsets.all(10.0),
            child: IntroductionScreen(
              pages: pages,
              onDone: () {
                setSkip(true);
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (BuildContext context) {
                      return JoinApp();
                    },
                  ),
                );
              },
              onSkip: () {
                //save to remember this action for next run
                setSkip(true);
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (BuildContext context) {
                      return JoinApp();
                    },
                  ),
                );
              },
              showSkipButton: true,
              skip: Text("Skip"),
              next: Text(
                "Next",
                style: TextStyle(
                  fontWeight: FontWeight.w800,
                  color: Theme
                      .of(context)
                      .accentColor,
                ),
              ),
              done: Text(
                "Done",
                style: TextStyle(
                  fontWeight: FontWeight.w800,
                  color: Theme
                      .of(context)
                      .accentColor,
                ),
              ),
            ),
          ),
        ),
      );
    }
  }
}
