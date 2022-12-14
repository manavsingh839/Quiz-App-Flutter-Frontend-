// ONBOARD SCREEN //
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_project/screens/welcome.dart';
import 'package:introduction_screen/introduction_screen.dart';

class sliders extends StatefulWidget{
  static String routeName = "/sliders";
  @override
  _slidersState createState() => _slidersState();
}
class _slidersState extends State<sliders> {
  final introKey = GlobalKey<_slidersState>();
void _onIntroEnd(context) {
  // print("Done");
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => Welcome()),
    );
  }

  // Widget _buildFullscreenImage() {
  //   return Image.asset(
  //     'backgound.image',
  //     fit: BoxFit.cover,
  //     height: double.infinity,
  //     width: double.infinity,
  //     alignment: Alignment.center,
  //   );
  // }

  Widget _buildImage(String assetName, [double width = 350]) {
    return Image.asset('images/$assetName', width: width);
  }
  @override
  Widget build(BuildContext context) {
    const bodyStyle = TextStyle(fontSize: 19.0);

    const pageDecoration = const PageDecoration(
      titleTextStyle: TextStyle(fontSize: 28.0, fontWeight: FontWeight.w700),
      bodyTextStyle: bodyStyle,
      bodyPadding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
      pageColor: Colors.white,
      imagePadding: EdgeInsets.zero,
    );
    return IntroductionScreen(
      key: introKey,
      globalBackgroundColor: Colors.white,
      // globalHeader: Align(
      //   alignment: Alignment.topRight,
      //   child: SafeArea(
      //     child: Padding(
      //       padding: const EdgeInsets.only(top: 16, right: 16),
      //       child: _buildImage('app_logo.png', 100),
      //     ),
      //   ),
      // ),
      // globalFooter: SizedBox(
      //   width: double.infinity,
      //   height: 60,
      //   child: ElevatedButton(
      //     child: const Text(
      //       'Let\'s go right away!',
      //       style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
      //     ),
      //     onPressed: () => _onIntroEnd(context),
      //   ),
      // ), 
      pages: [
          PageViewModel(
            title: "Fast And Secure",
            body:
            "This Application is very fast and secure.",
            image: _buildImage('illustration_page1.png'),
            decoration: pageDecoration,
          ),
          PageViewModel(
            title:"Improves your learning skill",
            body:
            "This Application helps enhance your learning ability that helps in your technical skills development.", 
            image: _buildImage('illustration_page2.png'),
            decoration: pageDecoration,
          ),
          PageViewModel(
            title: "Tracks your performance",
            body:
            "This Application keeps a track of user's performance and ranks him accordingly",
            image: Padding(
              padding: const EdgeInsets.only(top:150.0),
              child: _buildImage('illustration_page3.png'),
            ),  
           decoration: pageDecoration,
          ),
          // PageViewModel(
          //   title: "Full Screen Page",
          //   body:
          //   "Pages can be full screen as well.\n\nLorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc id euismod lectus, non tempor felis. Nam rutrum rhoncus est ac venenatis.",
          //   image: _buildFullscreenImage(),
          //   decoration: pageDecoration.copyWith(
          //     contentMargin: const EdgeInsets.symmetric(horizontal: 16),
          //     fullScreen: true,
          //     bodyFlex: 2,
          //     imageFlex: 3,
          //   ),
          // ),
          // PageViewModel(
          //   title: "Another title page",
          //   body: "Another beautiful body text for this example onboarding",
          //   image: _buildImage('app_logo.png'),
          //   footer: ElevatedButton(
          //     onPressed: () {
          //       // introKey.currentState?.animateScroll(0);
          //     },
          //     child: const Text(
          //       'FooButton',
          //       style: TextStyle(color: Colors.white),
          //     ),
          //     style: ElevatedButton.styleFrom(
          //       primary: Colors.lightBlue,
          //       shape: RoundedRectangleBorder(
          //         borderRadius: BorderRadius.circular(8.0),
          //       ),
          //     ),
          //   ),
          //   decoration: pageDecoration,
          // ),
          // PageViewModel(
          //   title: "Title of last page - reversed",
          //   bodyWidget: Row(
          //     mainAxisAlignment: MainAxisAlignment.center,
          //     children: const [
          //       Text("Click on ", style: bodyStyle),
          //       Icon(Icons.edit),
          //       Text(" to edit a post", style: bodyStyle),
          //     ],
          //   ),
          //   decoration: pageDecoration.copyWith(
          //     bodyFlex: 2,
          //     imageFlex: 4,
      //       bodyAlignment: Alignment.bottomCenter,
      //       imageAlignment: Alignment.topCenter,
      //     ),
      //     image: _buildImage('app_logo.png'),
      //     reverse: true,
      //   ),
         ],
      onDone: () => _onIntroEnd(context),
      onSkip: () => _onIntroEnd(context), // You can override onSkip callback
      showSkipButton: false,
      skipOrBackFlex: 0,
      nextFlex: 0,
      showBackButton: true,
      //rtl: true, // Display as right-to-left
      back: const Icon(Icons.arrow_back),
      skip: const Text('Skip', style: TextStyle(fontWeight: FontWeight.w600)),
      next: const Icon(Icons.arrow_forward),
      done: const Text('Start', style: TextStyle(fontSize:20.0,fontWeight: FontWeight.w600,color:Colors.black)),
      curve: Curves.fastLinearToSlowEaseIn,
      controlsMargin: const EdgeInsets.all(16),
      controlsPadding: const EdgeInsets.fromLTRB(8.0, 4.0, 8.0, 4.0),
      dotsDecorator: const DotsDecorator(
          size: Size(10.0, 10.0),
          color: Color(0xFFBDBDBD),
          activeSize: Size(22.0, 10.0),
          activeShape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(25.0)),
          ),
      ),
      dotsContainerDecorator: const ShapeDecoration(
         // color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(8.0)),
          ),
      ),
    );
  }
} 
