import 'dart:convert';
import 'package:dio/dio.dart';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_project/config.dart'; 
import 'package:flutter_project/screens/result.dart';
import 'package:shared_preferences/shared_preferences.dart'; 


// widget that changes its value,eg:checkbox,radiobutton etc,widget is redrawn in this 
class Result extends StatefulWidget{
  static String routeName = "/result";
  @override
  _resultState createState() => _resultState();
}

class _resultState extends State<Result>{ 
 final _prefs = SharedPreferences.getInstance(); // New Add
  int correctanswers = 0;
  int incorrectanswers = 0;
  int attemptanswers = 0;
  int notattemptanswers = 0;
  String studentname = "";
  String user_id= "";
  String quiz_name = "";
  bool _loading = true;
  
   late Timer _timer;
    int obtain_percentage = 0;
    int total_percentage = 10;

  Future<void> setdata() async {
    _prefs.then((SharedPreferences prefs) {
      // prefs.remove("userinput");
      // prefs.setString("userinput", json.encode(hj).toString());
      print(prefs.getString("quiz_name"));
      if(prefs.getString("quiz_name") != null){
      setState(() {
        quiz_name = prefs.getString("quiz_name")!;
      });
      }

          List useranswer =  json.decode(prefs.getString("userinput")!) as List;
          // final List fixedList = Iterable<int>.generate(useranswer.length).toList();
            print("user "+useranswer.toString());
            
            for (String e in useranswer){
            // print("user "+e.toString());
        setState(() {
          studentname =  prefs.getString("username")!;
          user_id =  prefs.getString("userid")!;
            if(e.toString() == "correct")
            {
              attemptanswers++;
              correctanswers++;
              obtain_percentage++;
            }
             if(e.toString() == "incorrect")
            {
              attemptanswers++;
              incorrectanswers++;
            }
             if(e.toString() == "")
            {
              notattemptanswers++;
            }
        });
        }
        setState(() {          
        _loading = false;
        });
        _result(user_id,quiz_name,studentname,attemptanswers,notattemptanswers,correctanswers);
    }, 
onError: (error) {
  print("SharedPreferences ERROR = $error");   
});
}
    @override
  void initState() {
    setdata();
    super.initState();
  }
  @override
  Widget build(BuildContext context) { 
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushNamed(context, "/home");
        return false;
      },
      child: Scaffold(
            appBar:AppBar(
               elevation: 25,
               backgroundColor:Colors.white,
               leading: const Padding(
                 padding:  EdgeInsets.only(left:40.0),
                 child:Icon(Icons.arrow_back,color:Colors.black),
               ),
               flexibleSpace:ClipRRect(
                     borderRadius:const BorderRadius.only(bottomLeft:Radius.circular(200),bottomRight:Radius.circular(40)),
                     child:Container(
                         decoration:const BoxDecoration(
                              gradient:LinearGradient(colors: [
                                 Color(0xFFe5c1f7),//.withOpacity(0.5),
                                 Color(0xFFc5bbf2 ),//.withOpacity(0.5),
                                 Color(0xFFc58cc7),//.withOpacity(0.5),
                                 Color(0xFFe5c1f7),
                              ],
                            ),
                         ),
                     ),
               ),
            shape:const RoundedRectangleBorder(
                 borderRadius:BorderRadius.only(bottomLeft:Radius.circular(200),bottomRight:Radius.circular(200),),
               ),
               bottom:PreferredSize(
                  preferredSize:Size.fromHeight(50),
                  child: Column(
               //     mainAxisAlignment:MainAxisAlignment.start,
               //     crossAxisAlignment:CrossAxisAlignment.start,
                //     children: [
                  //     Padding(
                  //       padding: const EdgeInsets.only(left:4.0),
                  //       child: Row(
                  //           crossAxisAlignment:CrossAxisAlignment.start,
                  //            mainAxisAlignment:MainAxisAlignment.spaceAround,
                  //          children: [
                  //               Text('hello'),
                  //               CircleAvatar(
                  //                 radius:25,
                  //                 backgroundColor:Colors.amber,
                  //               )
                  //     ], //children
                  //  ), //Row
                  // ),
                children: [
                  Center(
                     child: Padding(
                       padding: const EdgeInsets.only(bottom:50.0,left:50.0),
                       child: Text('Result Time !',
                            style:TextStyle(
                              fontFamily:'Abeezee_italic',
                              fontSize:30.0,
                              fontWeight:FontWeight.w300,
                              color:Colors.black,
                            ),
                          ),
                     ),
                   ),
               //  SizedBox(height:70),
                 ],
                ),
              ),
            ),
          body:Center(
            child: _loading ? Text("Wait...") : Padding(
              padding: const EdgeInsets.only(top:20.0),
              child:Column(
                children: [
                  Stack(
                    alignment: Alignment.topCenter,
                    children: [
                    // SizedBox(height:50),
                     Container(
                      margin: EdgeInsets.only(top: 80.0),
                      padding: EdgeInsets.symmetric(horizontal: 20.0),
                      height:400,
                      width:370,
                  //    color:Colors.purple[100],
                      decoration: BoxDecoration(
                         borderRadius: BorderRadius.circular(80.0),
                        color: Colors.purple[100],
                         border: Border.all(
                            width: 5, 
                            color: Colors.white,
                          ),
                       ),
                       child:Column(
                         mainAxisAlignment:MainAxisAlignment.center,
                         crossAxisAlignment:CrossAxisAlignment.start,
                          children: [
                            SizedBox(height:80),
                            Center(
                              child: Text(studentname,
                                   style:TextStyle(
                                         fontSize:20.0,
                                         fontWeight:FontWeight.w600,
                                         ),  
                                    ),
                            ),
                            SizedBox(height:20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Align(
                                alignment:Alignment.centerLeft,
                                child:Padding(
                                  padding: const EdgeInsets.only(left:8.0),
                                  child: Text('Quiz Name',
                                       style:TextStyle(
                                         fontSize:20.0,
                                         fontWeight:FontWeight.w600,
                                       ),
                                       ),
                                ),
                                ),
                               Align(
                                alignment:Alignment.centerRight,
                                child:Padding(
                                  padding: const EdgeInsets.only(right:40.0),
                                  child: Text(quiz_name,
                                       style:TextStyle(
                                         fontSize:20.0,
                                         fontWeight:FontWeight.w600,
                                       ),
                                       ),
                                ),
                                ),
                              ],
                            ),   
                            SizedBox(height: 20.0,),
                             Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                 Align(
                                alignment:Alignment.centerLeft,
                                child:Padding(
                                  padding: const EdgeInsets.only(left:8.0),
                                  child: Text('Attempted(%)',
                                       style:TextStyle(
                                         fontSize:20.0,
                                         fontWeight:FontWeight.w600,
                                       ),
                                       ),
                                   ),
                                ),       
                               Align(     
                               alignment:Alignment.centerRight, 
                               child:Padding(
                                 padding: const EdgeInsets.only(top:10.0,left:15),
                                 child: SizedBox(
                                  width:100,
                                  height:10,
                                 child:LinearProgressIndicator(
                                    value:attemptanswers/10,
                                    valueColor: AlwaysStoppedAnimation(Colors.green),
                                    backgroundColor: Colors.white,
                                  ),
                                 ),
                               ),
                               ),
                              ],
                            ),   
                            SizedBox(height:20.0,),
                             Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                  Align(
                                alignment:Alignment.centerLeft,
                                child:Padding(
                                  padding: const EdgeInsets.only(left:10.0),
                                  child: Text('Not Attempted(%)',
                                       style:TextStyle(
                                         fontSize:20.0,
                                         fontWeight:FontWeight.w600,
                                       ),
                                       ),
                                   ),
                                ),   
                               Align(
                                   alignment: Alignment.centerRight,
                                  child:Padding(
                                    padding: const EdgeInsets.only(top:10,left:0),
                                    child:SizedBox(
                                      width:100,
                                      height:10,
                                     child:LinearProgressIndicator(
                                    value:(correctanswers/10)*100,
                                    valueColor: AlwaysStoppedAnimation(Colors.green),
                                    backgroundColor: Colors.white,
                                     ),
                                    )
                                  ),
                                  ),
                              ],
                            ),   
                            SizedBox(height: 10.0,),
                             Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                  Align(
                                   alignment: Alignment.centerLeft,
                                  child:Padding(
                                    padding: const EdgeInsets.only(top:10,left:10),
                                    child: Text('Incorrect Answer(%)',
                                     style:TextStyle(
                                       fontSize:20.0,
                                       fontWeight:FontWeight.w600,
                                     ),
                                     ),
                                  ),
                                  ),
                              Align(
                                   alignment: Alignment.centerRight,
                                  child:Padding(
                                    padding: const EdgeInsets.only(top:20,right:0),
                                    child:SizedBox(
                                      width:100,
                                      height:10,
                                     child:LinearProgressIndicator(
                                    value:incorrectanswers/10,
                                    valueColor: AlwaysStoppedAnimation(Colors.green),
                                    backgroundColor: Colors.white,
                                     ),
                                    )
                                  ),
                                  ),
                              ],
                            ),   
                            SizedBox(height: 10.0,),
                             Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                 Align(
                                   alignment: Alignment.centerLeft,
                                  child:Padding(
                                    padding: const EdgeInsets.only(top:10,left:10),
                                    child: Text('Correct Answers(%)',
                                     style:TextStyle(
                                       fontSize:20.0,
                                       fontWeight:FontWeight.w600,
                                     ),
                                     ),
                                  ),
                                  ),
                                  Align(
                                   alignment: Alignment.centerRight,
                                  child:Padding(
                                    padding: const EdgeInsets.only(top:20,left:30),
                                    child:SizedBox(
                                      width:100,
                                      height:10,
                                     child:LinearProgressIndicator(
                                    value:correctanswers/10,
                                    valueColor: AlwaysStoppedAnimation(Colors.green),
                                    backgroundColor: Colors.white,
                                     ),
                                    )
                                  ),
                                  ),
                              ],
                            ),   
                          ],
                        ),
                       ),
                      Align(
                        alignment: Alignment.topCenter,
                        child: Container(
                         //  child: SizedBox(height:150),
                           child:  SizedBox(
                                  height: 150.0,
                                  width: 150.0,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(80.0),
                                    color: Colors.purple[100],
                                    ),
                             child: Stack(
                                  fit: StackFit.expand,
                                  children: [
                                     CircularProgressIndicator(
                                     value: obtain_percentage/total_percentage,
                                     valueColor: AlwaysStoppedAnimation(Colors.white),
                                     strokeWidth: 5,
                                     backgroundColor: Colors.purple[400],
                                      ),
                                  Padding(
                                    padding: const EdgeInsets.only(bottom:50.0),
                                    child: Center(
                                      child: Text("$obtain_percentage %", style: TextStyle(
                                             fontSize: 30.0,
                                             fontWeight: FontWeight.w400,
                                             color: Colors.purple[500],
                                         ),
                                       ),
                                    ),
                                  ),
                                 Center(child: Padding(
                                   padding: const EdgeInsets.only(top:35.0),
                                   child: Text('Your Score', style: TextStyle(
                                           fontSize: 15.0,
                                           fontWeight: FontWeight.w800,
                                           color: Colors.purple[500],
                                       ),
                                     ),
                                   ),
                                 ),
                               ],
                             ),
                          ),
                         ),
                        ),
                      ),
                    ],
                  ), 
                     Row(
                      children: [

                         Padding(
                           padding: const EdgeInsets.only(top:20.0,left:30),
                             child: Container(
                               height:50,
                               width:150,
                               child: RaisedButton(
                                  shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
                                  onPressed:(){                                  
                              _prefs.then((SharedPreferences prefs) {
                                prefs.remove("userinput");
                              });
                              Navigator.pushNamedAndRemoveUntil(context, '/home', (Route route) => false);
                                },
                                  color: Colors.purple[300],
                                 child:Text('Resume Quiz',
                                 style: TextStyle(
                                 fontSize: 18.0,
                                 fontWeight: FontWeight.w500,
                                 color: Colors.black,
                                ),
                               ),
                            ),
                             ),
                           ),
                         Padding(
                           padding: const EdgeInsets.only(top:20.0,left:20),
                             child:Container(
                               height:50,
                               width:100,
                             child: RaisedButton(
                                shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
                                onPressed:(){                                  
                              _prefs.then((SharedPreferences prefs) {
                                prefs.remove("userinput");
                              });
                              Navigator.pushNamedAndRemoveUntil(context, '/home', (Route route) => false);
                                },
                                color: Colors.purple[300],
                               child:Text('Exit',
                               style: TextStyle(
                               fontSize: 18.0,
                               fontWeight: FontWeight.w500,
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
          ),
        ),
       );
  }
    Future<void> _result(String user_id,quiz_name,student_name,attempted,not_attempted,correct_answer) async {
    try{
      Response res = await Dio().get("${Config.mainUrl}result?user=$user_id&quiz_name=$quiz_name&student_name=$student_name&attempted=$attempted&not_attempted=$not_attempted&correct_answers=$correct_answer");
     print(res.data);
     ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(res.data['success']))
                            );
    }catch(e)
    {
      print(e.toString());
    }
   }
 }