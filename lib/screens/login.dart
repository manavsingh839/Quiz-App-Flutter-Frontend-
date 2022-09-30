import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project/config.dart'; 
import 'package:flutter_project/screens/welcome.dart'; 
import 'package:flutter_project/screens/login.dart'; 
import 'package:flutter/gestures.dart';
import 'package:shared_preferences/shared_preferences.dart';

// widget that changes its value,eg:checkbox,radiobutton etc,widget is redrawn in this 
class Login extends StatefulWidget{
  static String routeName = "/login";
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login>{
 final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
 // bool value = false;
 final TextEditingController emailcontroller = TextEditingController();
 final TextEditingController passwordcontroller = TextEditingController();
  @override
  bool valuefirst = false;
  bool pwdshow = true;
  IconData pwdicon = Icons.remove_red_eye as IconData;
  @override
  void initState() {
    _prefs.then((SharedPreferences prefs) {
      if(prefs.getString("useremail") != "" && prefs.getString("useremail") != null)
      {
        Navigator.pushNamed(context,'/home');

      }
      emailcontroller.text = prefs.getString("email")!;
      passwordcontroller.text = prefs.getString("password")!;
    });
    super.initState();
  }
  Widget build(BuildContext context) {
    
    return Scaffold(
   //   backgroundColor: Colors.grey[200], 
  
      body: SingleChildScrollView(       
        child: Column(
                children: [
                  Image.asset('images/app_logo.png',height: 180,width: 180),
                  Stack(
                    alignment: AlignmentDirectional.topCenter,
                children: [
                  ClipPath(
                    clipper: ClipClipper(),
                     child: Container(
                      margin: EdgeInsets.fromLTRB(10.0,0,10,0),
                      height: MediaQuery.of(context).size.height-160,
                      width: MediaQuery.of(context).size.width,
                         decoration: BoxDecoration(
                            //   image: DecorationImage(
                            //    image:AssetImage('images/Welcome1.png'), 
                            // ),
                           // color:Colors.purple[50],
                             gradient: LinearGradient(
                                   begin: Alignment.topRight,
                                   end: Alignment.bottomLeft,
                                   colors:[
                                       Color(0xFFe5c1f7).withOpacity(0.6),
                                       Color(0xFFc5bbf2 ).withOpacity(0.6),
                                       Color(0xFFc58cc7).withOpacity(0.6),
                                       Color(0xFFe5c1f7).withOpacity(0.6),
                                       ]
                                   ),
                            borderRadius: BorderRadius.circular(30.0)
                         ),
                     ),
                   ),
                   Padding(
                     padding: EdgeInsets.all(10.0),
                     child: Container(
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 15.0),
                          child: Text('Welcome Back',
                                              textAlign: TextAlign.center,
                                              style:TextStyle(
                                                fontSize: 30.0,
                                                fontWeight:FontWeight.w400,
                                                fontFamily:'Abeezee_italic',
                                              ),
                                              ),
                        ),
                                            Padding(
                     padding: EdgeInsets.only(top: 10.0, left: 10.0, right: 10.0),
            child: TextFormField(
              controller: emailcontroller,
              keyboardType: TextInputType.emailAddress,
              style: TextStyle(color: Colors.black),
              decoration:InputDecoration(
                focusedBorder: const OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(20.0)),  borderSide: BorderSide(color: Colors.black, width: 1.0, style: BorderStyle.solid),),
                // border: OutlineInputBorder(
                //   borderSide: BorderSide(color: Colors.black), 
               //   borderRadius: BorderRadius.circular(20.0),
            //   prefixIcon: Icon(Icons.email,color:Colors.blueGrey,),
               suffixIcon: Icon(Icons.email,color:Colors.grey,),
                hintText: "Email ID",
                labelText: "Email",
              //  fillColor:Colors.black,
                labelStyle: TextStyle(color: Colors.black),
             //   border:OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
              ),
            ),
          ),
               Padding(
                     padding: EdgeInsets.only(top: 10.0, left: 10.0, right: 10.0),
            child: TextFormField(
              controller: passwordcontroller,
              keyboardType: TextInputType.visiblePassword,
              obscureText:pwdshow,
              style: TextStyle(color: Colors.black), 
              decoration:InputDecoration(
                focusedBorder: const OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(20)),borderSide: BorderSide(color: Colors.black, width: 1.0, style: BorderStyle.solid)),
                // border: OutlineInputBorder(
                //   borderSide: BorderSide(color: Colors.black), 
               //   borderRadius: BorderRadius.circular(20.0),
            //   prefixIcon: Icon(Icons.email,color:Colors.blueGrey,),
               suffixIcon: IconButton(onPressed: () {
                setState(() {
                  if(pwdshow)
                  {
                    pwdicon = Icons.remove_red_eye_outlined as IconData;
                    pwdshow = false;
                  }else{
                    pwdicon = Icons.remove_red_eye as IconData;
                    pwdshow = true;
                  } 
                });
               }, 
               icon: Icon(pwdicon)),
                hintText: "Password",
                labelText: "Password",
             //   fillColor:Colors.black,
                labelStyle: TextStyle(color: Colors.black),
              //  border:OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
              ),
            ),
          ), 
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
               Expanded(
                flex: 1,
                 child: Padding(
                       padding: EdgeInsets.only(top: 10.0, left: 10.0),
                   child: Checkbox(  
                              checkColor: Colors.white,  
                              activeColor: Colors.grey,  
                              value: valuefirst,  
                              onChanged: (value) {  
                                setState(() {  
                                  valuefirst = value!;  
                                });  
                              }
                             ),
                 ),
               ),
              Expanded(
                flex: 3,
                child: Padding(
                       padding: EdgeInsets.only(top: 10.0, right: 10.0),
                 child:Text('Remember Password', textAlign: TextAlign.left,)
                       ),
              ),
                     Expanded(
                      flex: 3,
                       child: Padding(
                        padding: EdgeInsets.only(top: 10.0, left: 30.0),
                    //  child:Text('Forgot Password?', textAlign: TextAlign.end,),
                      child:  RichText(
                            text: TextSpan(
                             //  text: 'Forgot Password?',
                             //   style: TextStyle(fontSize:20, color: Colors.black),
                             children: <TextSpan>[
                                        TextSpan(
                                   text: 'Forgot Password?',
                                   style: TextStyle(color:Colors.black),
                                recognizer: TapGestureRecognizer()
                                 ..onTap = ()=>Navigator.pushNamed(context,'/forgot_pass') //{
                              //  print('The button is clicked!');
                           //    },
                 // style: TextStyle(
                  //  color: Colors.blue,
                 // )
                ),
           //   TextSpan(text: 'text!'),
               ],
              ),
                      ),
                   ),
                 ),
            ],
          ),
          // Checkbox(
          //          value: this.value,
          //          onChanged: (bool value) {
          //          setState(() {
          //                this.value = value;
          //              }); 
          //          },
          //    ),
               Padding(
                 padding: const EdgeInsets.only(right:10.0, top: 20.0),
                 child: Align(
                  alignment: Alignment.centerRight,
                   child: RaisedButton(
                    padding:EdgeInsets.symmetric(horizontal:20.0, vertical: 10.0), 
                      shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      onPressed: () => {
                       if(emailcontroller.text != "" && passwordcontroller.text != "")
                          {
                            _login(emailcontroller.text,passwordcontroller.text),
                         //  Navigator.pushNamed(context,'/home'),
                          }else{
                            ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("Please Fill All Details")),
                            )
                          }
                       //  print("Email-"+emailcontroller.text),
                       //  print("Password-"+passwordcontroller.text),
                      }, 
                      color:Colors.purple[100],
                      child: Text(
                       'Login', 
                       style:(  
                         TextStyle(
                          fontSize: 18.0,
                          color:Colors.black, 
                         )
                       ) 
                       ), 
                     ),
                 ),
               ),
        //         Padding(
        //              padding: EdgeInsets.only(left: 260.0),
        // //   child:Text('Enter your e-mail account: '),
        //     child: RaisedButton( 
        //           shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        //           onPressed: () => {
        //              print("Email-"+emailcontroller.text),
        //              print("Password-"+passwordcontroller.text),
        //           }, 
        //           color:Colors.purple[100],
        //           child: Text(
        //            'Login', 
        //            style:(
        //              TextStyle(
        //               color:Colors.black, 
        //              )
        //            ) 
        //            ), 
        //   ),
        //  ),
         // ignore: prefer_const_constructors
        //  SizedBox(height:100.0,width:100.0),
             Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
               children: [
                 SizedBox(height:200.0,),
                 Align(
                   alignment:Alignment.bottomRight,
                 ),
                 Padding(
                 padding: EdgeInsets.only(bottom:10.0, left: 10.0, right: 20.0),
                 child:Text('Signup',
                 style: TextStyle(fontFamily:'Abeezee_italic',fontSize:20.0),
                  ),
                 ),
                 Padding(
                 padding: EdgeInsets.only(bottom:10, left: 10.0, right: 15.0),
                 child:FloatingActionButton(
                 onPressed:() => Navigator.pushNamed(context,'/signup'),
                 child: Icon(Icons.arrow_forward_rounded,color:Colors.black),
                 backgroundColor: Colors.purple[100],
                   ),
                ),
               ],
             ),
                      ],
                    ),
                   )
                   
                   ),       
            ],
           ),
            ],
           ),
     )
    );
  }
  Future<void> _login(String email,password) async {
    print(email+  password);
    try{
      Response res = await Dio().get("${Config.mainUrl}login?email=$email&password=$password");
    print(res.data);
    if(valuefirst && res.data['success'] == "Login Successfully"){
    final SharedPreferences prefs = await _prefs;
      await prefs.setString('email', email);
      await prefs.setString('password', password);
    }
    if(res.data['success'] == "Login Successfully"){
    final SharedPreferences prefs = await _prefs;
      var userdata = res.data['result'];
      await prefs.setString('userid', userdata[0]['id'].toString());
      await prefs.setString('useremail', userdata[0]['email'].toString());
      await prefs.setString('username', userdata[0]['name'].toString());
      Navigator.pushNamed(context,'/home');
    }

     ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(res.data['success']))
      );
    }catch(e)
    {
      print(e.toString());
    }
  }
}
class ClipClipper extends CustomClipper<Path>{
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0.0, size.height/1.9);

     var firstControlPoint = Offset(size.width / 4, size.height/2);
    var firstPoint = Offset(size.width / 2, size.height/1.3);
    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
        firstPoint.dx, firstPoint.dy);

    var secondControlPoint = Offset(size.width - (size.width / 4), size.height);
    var secondPoint = Offset(size.width, size.height - 30);
    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy,
        secondPoint.dx, secondPoint.dy);

    path.lineTo(size.width, 0.0);
    path.close();
    // path.lineTo(size.width, size.height/2);
    // path.lineTo(size.width, size.height);
    // path.lineTo(size.width, size.height/2);
    // path.lineTo(size.width, size.height/2);
    return path;
  }
  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => true;
}