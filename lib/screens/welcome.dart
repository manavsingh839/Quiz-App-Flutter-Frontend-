import 'package:flutter/material.dart';
import 'package:flutter_project/screens/welcome.dart';

class Welcome extends StatefulWidget{
  static String routeName = "/welcome";
  @override
  _welcomeState createState() => _welcomeState();
}

class _welcomeState extends State<Welcome>{
  @override
  Widget build (BuildContext context) {
     return Scaffold( 
         body:SingleChildScrollView(
          scrollDirection:Axis.vertical,
          child:Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration:const BoxDecoration(
                image:const DecorationImage(
                //  image: AssetImage('images/background.image.png'),
                 image:AssetImage('images/welcome.background.png'),
                  fit:BoxFit.cover,
                ),
              ),
              child:Column(
                //  mainAxisAlignment:MainAxisAlignment.start,
                //  crossAxisAlignment:CrossAxisAlignment.start,
                  children: [
                            SizedBox(height:230),
                             Center(child: Image.asset('images/Welcome1.png', height: 400.0, width: 1000.0,)),
                            // Center(child: Text('Already have an account?',
                            // style:TextStyle(
                            //   fontSize:20.0,
                            //   fontFamily:'Abeezee_italic',
                            //   color:Colors.purple[300],
                            //      ),
                            //     ),
                            //    ),
                            SizedBox(height:20),
                              Center(
                                child: Container(
                                   height:50,
                                   width:150,
                                   child: Center(
                                     child: RaisedButton(   
                                        shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                                        onPressed:() => Navigator.pushNamed(context, "/login"),
                                        color:Colors.purple[200],
                                        child:Text('Login',
                                        style: TextStyle(
                                          fontSize:18,
                                          fontWeight:FontWeight.w400,
                                          color:Colors.black,
                                          ),
                                        ),  
                                      ),
                                   ),
                                 ),
                              ),           
                            //  SizedBox(height:20),
                               Center(
                                 child: Container(
                                   height: 50,
                                   width: 150,
                                   child: Center(
                                     child: RaisedButton(   
                                        shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                                        onPressed:() => Navigator.pushNamedAndRemoveUntil(context, "/home", (Route route) => false),
                                        color:Colors.purple[200],
                                        child:Text('Skip',
                                        style: TextStyle(
                                          fontSize:18,
                                          fontWeight:FontWeight.w400,
                                          color:Colors.black,
                                          ),
                                        ),  
                                      ),
                                   ),
                                 ),
                               ),
                            //     Center(child: Text('Create a new account?',
                            // style:TextStyle(
                            //   fontSize:20.0,
                            //   fontFamily:'Abeezee_italic',
                            //   color:Colors.purple[300],
                            //      ),
                            //     ),
                            //    ),
                            //     Center(
                            //      child: RaisedButton(   
                            //         shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                            //         onPressed:() => null,//Navigator.pushNamed(context, "/signup"),
                            //         color:Colors.purple[100],
                            //         child:Text('Signup',
                            //         style: TextStyle(
                            //           color:Colors.white,
                            //           ),
                            //         ),  
                            //       ),
                            //    ),
                          ], 
                         ),       
                       ),
                     ),
                 );
               }
             } 
//   return Scaffold(   
//   body:Padding(
//      padding: EdgeInsets.all(0.0),
//       child:ClipPath(
//         clipper: clip1Clipper(),
//         child:Container(
//           height:200,
//           width:200,
//          // color:Colors.purple[100],
//          decoration:BoxDecoration(
//            gradient: LinearGradient(
//              begin: Alignment.topRight,
//              end: Alignment.bottomLeft,
//              colors:[
//               Color(0xFFe5c1f7),
//               Color(0xFFc5bbf2 ),
//               Color(0xFFc58cc7),
//               Color(0xFFe5c1f7),
//              ]
//             )
//          )
//         )
//       )
//     )
//   );
// class clip1Clipper extends CustomClipper<Path> {

//   @override
//   Path getClip(Size size) {
//     Path path=Path();

    // path.lineTo(0,size.height);  // Full Box
    // path.lineTo(size.width,size.height); 
    // path.lineTo(size.width,0); 
 
    // path.lineTo(0,size.height);  // Triangle
    // path.lineTo(size.width,size.height); 

    //  path.lineTo(0,size.height);  // Inner Curve
    //  path.lineTo(size.width,size.height); 
    //  path.quadraticBezierTo(0,size.height,0,0);

//       path.lineTo(0,size.height);  // Outer Curve
//       path.lineTo(size.width,size.height); 
//       path.quadraticBezierTo(size.width,0,0,0);
//       return path;
//      }
//   @override
//   bool shouldReclip(CustomClipper<Path> oldClipper) => true;
//     }