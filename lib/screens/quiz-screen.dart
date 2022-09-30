import 'dart:convert';

import 'package:dio/dio.dart';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_project/config.dart'; 
import 'package:flutter_project/model/question_model.dart';
import 'package:shared_preferences/shared_preferences.dart'; 


class Start_Quiz extends StatefulWidget{
  String quizname;
   Start_Quiz({Key? key,  required this.quizname}) : super(key: key);
  static String routeName = "/quiz-screen";
  @override
  _Start_QuizState createState() => _Start_QuizState();
}

class _Start_QuizState extends State<Start_Quiz>{ 
 String? quiz_name;
 final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  late Ques_Model quesionmdl;
  late List<Ques_Model> questionList;
  int questioncount = -1;
  List<String> useranswer = ["","","","","","","","","",""];


  late Timer? _timer;
    int _start = 10;
    int _maxtime = 10;
    bool loading = true;

    void startTimer() {
      setState(() {
        
                  questioncount++;
                  _start = 10;
      });
      const oneSec = Duration(seconds: 1);
      _timer = Timer.periodic(
            oneSec,
            (Timer timer) {
              if (_start == 0) {
                setState(() {
                  if(questioncount > 9)
                  {
                  timer.cancel();
    _prefs.then((SharedPreferences prefs) {
      prefs.setString("quiz_name", quiz_name!);
      prefs.setString('userinput', json.encode(useranswer).toString());
                Navigator.pushNamedAndRemoveUntil(context, '/result', (Route route) => false);
    });
                  }else{                  
            _timer!.cancel();
            _timer = null;
            startTimer(); 
                  }
                });
              } else {
                // print("user input " +useranswer.toString());
                setState(() {
                  _start--;
                });
              }
            },
          );
        }
    @override
      void initState() {        
    _prefs.then((SharedPreferences prefs) {
      if(prefs.getString("userinput") != null)
      {
        prefs.remove("userinput");
        prefs.remove("quiz_name");
      }
    });
        setState(() {          
        quiz_name = widget.quizname;
        });
        startTimer();
        _questions(widget.quizname, "theory");
        super.initState();
      }

    void dispose() {
      _timer!.cancel();
      super.dispose();
    }
    
    Future<void> _questions(String language,type) async {
    try{
      final res = await Dio().get("${Config.mainUrl}questions?language=$language&type=$type");
    // print(res.data);
      Iterable resultdata = json.decode(res.toString())['result'] as Iterable;
    setState(() {
      questionList = resultdata.map((e) => Ques_Model.fromJson(e)).toList();
      loading = false;
    // quesionmdl = Ques_Model.fromJson(res.data['result']);
    });

    // print(questionList.toString());


    //  ScaffoldMessenger.of(context).showSnackBar(
    //                         SnackBar(content: Text(res.data['success'])) 
    //                         );                  
    }catch(e)
    {
      print(e.toString());
    }
   }
  @override
  Widget build(BuildContext context) { 
    return Scaffold(
        // appBar:AppBar(
        //     title:Text("Timing: $_start"),
        //     backgroundColor: Colors.purple,
        //   ),
        body:loading ? Center(child: Text("Wait..."),) :
        Container(
          child:Stack(
             children: [
              Opacity(opacity:0.5,
                child:ClipPath(
                 clipper:WaveClipper(),
                  child:Container(
                   height: 300,
                 color:Colors.purple[100],
                ),
               ),
              ),
              // Center(child: Text('C language ?')),
              ClipPath(
                 clipper:WaveClipper(),
                  child:Container(
                       height: 280,
                       child:Center(child: Text(loading ? "" : questionList[questioncount].question,
                           style:const TextStyle(
                            fontSize: 20.0,
                            fontWeight:FontWeight.w400,
                            color:Colors.black,
                           ),)),
                       decoration:const BoxDecoration(
                       gradient: LinearGradient(
                              begin: Alignment.topRight,
                              end: Alignment.bottomLeft,
                              colors:[
                                 Color(0xFFe5c1f7),//.withOpacity(0.5),
                                 Color(0xFFc5bbf2 ),//.withOpacity(0.5),
                                 Color(0xFFc58cc7),//.withOpacity(0.5),
                                 Color(0xFFe5c1f7),//.withOpacity(0.5),
                              ],
                            ),
                        ),
                ),
               ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height:150),
               SizedBox(
                    height: 100.0,
                    width: 100.0,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50.0),
                        color: Colors.purple[100],
                      ),
                      child: Stack(
                        fit: StackFit.expand,
                        children: [
                          CircularProgressIndicator(
                            value: _start/_maxtime,
                            valueColor: AlwaysStoppedAnimation(Colors.white),
                            strokeWidth: 5,
                            backgroundColor: Colors.purple[400],
                          ),
                          Center(child: Text("$_start", style: TextStyle(
                                  fontSize: 30.0,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.purple[400],
                           ),
                          ),
                         ),
                        ],
                      ),
                    ),
                  ),
              SizedBox(height:50),
              Center(
                 child:SizedBox(
                  height:60.0, 
                  width:320.0,
                  child: RaisedButton(
                  padding: EdgeInsets.all(20.0),
                  shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
                  onPressed: (){
              if(useranswer[questioncount] == "")
              {
              setState(() {              
                if(questionList[questioncount].option_a == questionList[questioncount].correct_answer)
                {  
              useranswer[questioncount] = "correct";
                }else{
              useranswer[questioncount] = "incorrect";
                }
              });
              }else{
                 ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("Already Submit")) 
                   );      
              }
            },
                  color: Colors.purple[200],
                  child:Text(loading ? "" : questionList[questioncount].option_a,
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.w400,
                    color: Colors.black,
                  ),),
                 ),
                 ),
               ),
               SizedBox(height:20.0),
           Center(
           child:SizedBox(
           height: 60.0,
           width: 320.0,
           child:RaisedButton(
            shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
            onPressed:(){
              if(useranswer[questioncount] == "")
              {
              setState(() {              
                if(questionList[questioncount].option_b == questionList[questioncount].correct_answer)
                {  
              useranswer[questioncount] = "correct";
                }else{
              useranswer[questioncount] = "incorrect";
                }
              });
              }else{
                 ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("Already Submit")) 
                            );      
              }
            },
            color: Colors.purple[200],
            child:Text(loading ? "" : questionList[questioncount].option_b,
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.w400,
              color: Colors.black,
            ),),
           ),
         ),
        ),
        SizedBox(height:20.0),
        Center(
           child:SizedBox(
           height: 60.0,
           width: 320.0,
           child:RaisedButton(
              shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
              onPressed:(){
              if(useranswer[questioncount] == "")
              {
              setState(() {              
                if(questionList[questioncount].option_c == questionList[questioncount].correct_answer)
                {  
              useranswer[questioncount] = "correct";
                }else{
              useranswer[questioncount] = "incorrect";
                }
              });
              }else{
                 ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("Already Submit")) 
                            );      
              }
            },
              color: Colors.purple[200],
              child:Text(loading ? "" : questionList[questioncount].option_c,
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.w400,
                color: Colors.black,
              ),),
             ),
         ),
        ),
        SizedBox(height:20.0),
        Center(
           child:SizedBox(
           height: 60.0,
           width: 320.0,
           child:RaisedButton(
              shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
              onPressed:(){
              if(useranswer[questioncount] == "")
              {
              setState(() {              
                if(questionList[questioncount].option_d == questionList[questioncount].correct_answer)
                {  
              useranswer[questioncount] = "correct";
                }else{
              useranswer[questioncount] = "incorrect";
                }
              });
              }else{
                 ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("Already Submit")) 
                            );      
              }
            },
              color: Colors.purple[200],
              child:Text(loading ? "" : questionList[questioncount].option_d,
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.w400,
                color: Colors.black,
              ),),
             ),
         ),
        ),
        SizedBox(height:60.0),
        Center(
           child:SizedBox(
           height: 50.0,
           width: 140.0,
           child:RaisedButton(
              shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
              onPressed:() {
                if(questioncount < 9)
                {
                                    
            _timer!.cancel();
            _timer = null;
            startTimer(); 
                }else{
    _prefs.then((SharedPreferences prefs) {
      prefs.setString("quiz_name", quiz_name!);
      prefs.setString('userinput', json.encode(useranswer).toString());
                Navigator.pushNamedAndRemoveUntil(context, '/result', (Route route) => false);
    });
                }
              },
              color: Colors.purple[300],
              child:Text('Next Question',
              style: TextStyle(
                fontSize: 15.0,
                fontWeight: FontWeight.w400,
                color: Colors.black,
              ),
              ),
             ),
           ),
          ),
            ],
          ),
        
             ],
          ),
        ),
        // floatingActionButton: FloatingActionButton(
        //   onPressed:() => Navigator.pushNamed(context,'/result'),
        //   backgroundColor: Colors.purple[200],
        //   child:Icon(Icons.arrow_forward,color:Colors.black),
        //   ),
      );
     }
  }
 //  }
class WaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
  // debugPrint(size.width.toString());
  var path = new Path(); 
  path.lineTo(0,size.height);
  var firstStart = Offset(size.width/5,size.height);
  // first point of quadratic bezier curve 
  var firstEnd = Offset(size.width/2.25,size.height-50.0);
  // second point of quadratic bezier curve 
  path.quadraticBezierTo(firstStart.dx,firstStart.dy,firstEnd.dx,firstEnd.dy);
  var SecondStart = Offset(size.width-(size.width/3.24),size.height-105);
  // third point of quadratic bezier curve 
  var SecondEnd = Offset(size.width,size.height-10);
  // fourth point of quadratic bezier curve  
  path.quadraticBezierTo(SecondStart.dx, SecondStart.dy,SecondEnd.dx,SecondEnd.dy);
  path.lineTo(size.width,0);
  path.close();
  return path;
  }
   @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => true;
}
 