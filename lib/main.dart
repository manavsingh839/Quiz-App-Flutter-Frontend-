import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_project/screens/Sliders.dart';
import 'package:flutter_project/screens/description.dart';
import 'package:flutter_project/screens/home.dart';
import 'package:flutter_project/screens/quiz-screen.dart';
import 'package:flutter_project/screens/result.dart';
import 'package:flutter_project/screens/update_profile.dart';
import 'package:flutter_project/screens/welcome.dart';
import 'package:flutter_project/screens/login.dart';
import 'package:flutter_project/screens/signup.dart';
import 'package:flutter_project/screens/forgot_pass.dart';

void main() {     
  runApp(MaterialApp(
    initialRoute: "/", 
      routes: {
       '/': (context) =>Quiz(),
       '/welcome':(context) =>Welcome(),
       '/signup':(context) =>Signup(),
        Login.routeName:(context)=>Login(),
        '/home':(context) =>Home(),
      //   Home.routeName:(context)=>Home(),
        // '/quiz-screen':(context) =>Start_Quiz(),
    //     '/description':(context) => descriptions(),
        '/result':(context) => Result(),
        '/forgot_pass':(context) => Password(),
        '/update_profile':(context) => Update(),
      }, 
    debugShowCheckedModeBanner: false,
    ),
  );
} 
class Quiz extends StatefulWidget { 
  static String routeName = "/";
  @override
  _QuizState createState() => _QuizState();
}

class _QuizState extends State<Quiz>{
  @override
  void initState() {
    Timer(const Duration(seconds: 5), ()=> 
    Navigator.pushAndRemoveUntil(context, 
    MaterialPageRoute<dynamic>(
          builder: (BuildContext context) =>sliders(),
        ),
     (route) => false)
    );
    super.initState();
  } 
 Widget build (BuildContext context) {
  return Scaffold( 
         body:SingleChildScrollView(
          scrollDirection:Axis.vertical,
          child:Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration:BoxDecoration(
                color:Colors.white,
                image:DecorationImage(
                  image: AssetImage('images/front.jpg'),
                  fit:BoxFit.cover,
                ),
              ),
              child: Padding(
               padding: const EdgeInsets.fromLTRB(10.0, 110 ,0.0,10.0),
                child: Column(
                //  mainAxisAlignment:MainAxisAlignment.center,
                //  crossAxisAlignment:CrossAxisAlignment.center,m
                  children:[
                    Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                          Image.asset('images/app_logo.png', height: 180.0, width: 180.0,),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Tech',
                                style:TextStyle(
                                  fontSize:40.0,
                                  fontWeight:FontWeight.bold,
                                  fontFamily:'Abeezee_italic',
                                  color: Color.fromARGB(255,94, 37, 99),// rgb(197, 51, 100)
                                ),
                        ),
                        Text('Quiz',
                          // softWrap: true,
                            style:TextStyle(
                              fontSize:35.0,
                              fontWeight:FontWeight.bold,
                              fontFamily:'Abeezee_italic',
                              color: Colors.pink[900],
                            ),
                            // gradient:LinearGradient(colors: 
                            //  Colors.pink[800],
                            //  Colors.purple[800],
                            // )
                           ),
                            ],
                          ),
                    ],    
                  ),
                   Expanded(
                     child: Align(
                     alignment: FractionalOffset.bottomCenter,
                      child:  Padding(
                        padding: EdgeInsets.only(bottom:120.0),
                         child:Text('Welcome!',
                          style: TextStyle(
                            fontSize:30.0, 
                            fontWeight:FontWeight.bold,
                            fontFamily:'Abeezee_italic',
                            color: Color.fromARGB(255,94, 37, 99),
                           ),
                         ),
                       ),
                     ),
                   ),
                ],
               ),
              ),
             ),
            ),
           );
          }
         }