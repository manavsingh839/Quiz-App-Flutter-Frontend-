import 'package:flutter/material.dart';
import 'package:flutter_project/screens/description.dart';
import 'package:flutter_project/screens/quiz-screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class descriptions extends StatefulWidget{
  String quizid;
   descriptions({Key? key,  required this.quizid}) : super(key: key);
  static String routeName = "/description";
  @override
  _descriptionState createState() => _descriptionState();
}
class _descriptionState extends State<descriptions>{
 final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
 String? username;
 String? useremail;
 late final SharedPreferences prefs;

List quizlist = [
{
  "id": "1",
  "name": "C",
  "img": "images/C.png",
  "txt": "Instructions:\n 1)All questions are MCQs type.\n2)There are 10 questions in this quiz\n3)you are provided 1 min to solve each question.\n4)Your whole performance will be evaluated at end.\n HAPPY QUIZZING!\nygygugyuy"
},
{
  "id": "2",
  "name": "Cpp",
  "img": "images/Cpp.jpg",
  "txt": "C++ W3Schools offers free online tutorials, references and exercises in all the major languages of the web. Covering popular subjects like HTML, CSS, JavaScript, Python, SQL, Java"
},
{
  "id": "3",
  "name": "java",
  "img": "images/java.jpg",
  "txt": "Java W3Schools offers free online tutorials, references and exercises in all the major languages of the web. Covering popular subjects like HTML, CSS, JavaScript, Python, SQL, Java"
},
{
  "id": "4",
  "name": "python",
  "img": "images/python.jpg",
  "txt": "python W3Schools offers free online tutorials, references and exercises in all the major languages of the web. Covering popular subjects like HTML, CSS, JavaScript, Python, SQL, Java"
}
];

@override
  void initState() {
    _prefs.then((SharedPreferences prefsd) {
      setState(() {
        prefs = prefsd;
      });
      useremail = prefsd.getString("useremail")!;
      username = prefsd.getString("username")!;
    });
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
    //  backgroundColor: Colors.purple[100],
      body:SingleChildScrollView(
            child:Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                    SizedBox(height:20),
                       Center(child: Image.asset(quizlist[int.parse(widget.quizid)-1]['img'],height:150,)),
                      //  Text('C language',
                      //   style:TextStyle(
                      //         fontSize:30.0,
                      //         fontWeight:FontWeight.bold,
                      //         fontFamily:'Abeezee_italic',
                      //         color: Color.fromARGB(255,94, 37, 99),// rgb(197, 51, 100)
                      //        ),
                      //      ),

                  Container(
                    height:500,
                    width: 500,
                     decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(50.0)),
                        color: Colors.purple[100],
                       ),
                    margin: EdgeInsets.all(20.0),
                    child:Padding(
                      padding: const EdgeInsets.all(18.0),
                     child:Text(quizlist[int.parse(widget.quizid)-1]['txt'],
                           style:TextStyle(
                             fontSize: 15.0,
                           ),
                       ),
                    ),
                  ),
               //  Padding(
                     //     padding: const EdgeInsets.only(left:40.0,top:10.0),
                           Center(
                            child: RaisedButton(
                              padding:EdgeInsets.symmetric(horizontal:30.0, vertical: 10.0), 
                      shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)), 
                      onPressed: (){
                         if(username == null || username == "")
                         {
                           ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("Please login first..."))
                           );
                         Navigator.pushNamed(context, '/login');
                         }else{
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Start_Quiz(quizname: quizlist[int.parse(widget.quizid)-1]['name'],)
                            ),
                          );
                         }
                      }, 
                      color:Colors.purple[200],
                      child: Text(
                       'Start Quiz', 
                       style:(  
                             TextStyle(
                              fontSize: 20.0,
                              color:Colors.black, 
                             )
                       ) 
                       ), 
                    ),
                          ),
                     //   ),
                ],
              ), 
          ),
    );
  }
}