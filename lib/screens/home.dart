import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project/screens/description.dart'; 
import 'package:flutter_project/screens/home.dart';
import 'package:flutter_project/screens/login.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:shared_preferences/shared_preferences.dart'; 


class Home extends StatefulWidget{
  static String routeName = "/home";
  @override
  _HomeState createState() => _HomeState();
}
class _HomeState extends State<Home>{
 final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
 String? username;
 String? useremail;
 late final SharedPreferences prefs;
List items = [
"images/pic1.png",
"images/pic2.png",
"images/pic3.png",
"images/pic4.jpg",
"images/pic5.jpg",
];
List quizlist = [
{
  "id": "1",
  "img": "images/C.png",
  "txt": "C is a procedural programming language.It was developed by Dennis Ritchie.It is categorized as a middle level language that was developed to write operating systems and now has wider range of applications in computer science field."
},
{
  "id": "2",
  "img": "images/Cpp.jpg",
  "txt": "C++ is an object oriented language.It was developed by Bjarne Stroustrup.It is categorized as a middle level language.It has wider applications in writing OS,game developement,GUI based applications,developing web browers and much more."
},
{
  "id": "3",
  "img": "images/java.jpg",
  "txt": "Java is an object oriented language.It was developed by James Gosling.It is categorized as a high level language.It is widely used in developing computer applications,data centres,game consols,web apps,web servers,big data technologies and much more."
},
{
  "id": "4",
  "img": "images/python.jpg",
  "txt": "Python is an object oriented language.It was developed by Guido van Rossum"
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
Widget build (BuildContext context) =>WillPopScope(
  onWillPop: onWillPop,
  child: Scaffold( 
            backgroundColor: Colors.white,
              appBar:AppBar(
                backgroundColor:Colors.white,
                elevation: 0.0,
                title:Text('Home'), 
                centerTitle: true,
                flexibleSpace: Container(
                decoration: const BoxDecoration(
                borderRadius:BorderRadius.only(bottomLeft:Radius.circular(30.0),bottomRight:Radius.circular(30.0)),
                 gradient: LinearGradient(
                  begin: Alignment.topRight,
                   end: Alignment.bottomLeft,
                    colors:<Color>[
                          Color(0xFFe5c1f7),Color(0xFFc5bbf2),Color(0xFFc58cc7),Color(0xFFe5c1f7),
                    ]
                    ),
                   ),
                  ),
                    //   image: DecorationImage(
                    //    image:AssetImage('images/Welcome1.png'), 
                    // ),
                   // color:Colors.purple[50],
                        ),
              drawer:Drawer(
                 shape: const RoundedRectangleBorder(
                 borderRadius: BorderRadius.only(
                  topRight: Radius.circular(40),
                  bottomRight: Radius.circular(40)),
                 ),
                backgroundColor:Colors.white,
                child:ListView( 
                  children: [
                    SizedBox(
                      height: 130.0,
                      child: DrawerHeader( 
                         decoration: BoxDecoration(
                          color: Colors.purple[100],
                          // image: DecorationImage(image: AssetImage('assets/dog_image.jpeg'))
                          
                        ),
                         child: 
                            Align(alignment:Alignment.bottomLeft,
                        child:Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment:CrossAxisAlignment.start,
                              children: [
                                Text(username == null ? "" : username!,
                                textAlign:TextAlign.left,   // giving size to drawer header ??
                                style: TextStyle(
                                fontSize: 20.0, 
                                fontWeight:FontWeight.w400,
                                color: Colors.black, 
                                fontFamily:'Abeezee_italic',
                                  ),
                                ),
                                Text(useremail == null ? "" : useremail!,   // giving size to drawer header ??
                                style: TextStyle(
                                fontSize: 15.0, 
                                fontWeight:FontWeight.w200,
                                color: Colors.black, 
                                fontFamily:'Abeezee_italic',
                                  ),
                                ),
                                username == null || username == "" ? Container() : RaisedButton(
                                  onPressed:()=>{
                                    Navigator.popAndPushNamed(context,'/update_profile'),
                                  },
                                  color: Colors.purple[200],
                                  child:Text("Edit profile",
                                  style:TextStyle(
                                    fontSize:15.0,
                                    fontWeight:FontWeight.w400,
                                  ),)
                                ),
                              ],
                            )
                           ),
                        ),
                      ),
                     Divider(height: 1.0,
                    color: Colors.grey,
                    thickness: 1.0,
                    ),
                      username == null || username == "" ? ListTile( 
                        onTap: () => Navigator.pushNamed(context, "/login"),               
                        leading: Icon(Icons.login),    
                        title: const Text('Login'), 
                      ): ListTile( 
                        onTap: () {
                          prefs.remove("useremail");
                          prefs.remove("username");
                          prefs.remove("userid");
                           Navigator.pushAndRemoveUntil(context, 
                        MaterialPageRoute<dynamic>(
                           builder: (BuildContext context) =>Home(),
                         ),
                        (route) => false);
                        },               
                        leading: Icon(Icons.logout),    
                        title: const Text('Logout'), 
                      ),
                      ListTile( 
                        onTap: () =>launch("tel://8699034589"),
                        leading: Icon(Icons.call),
                        title: const Text('Call now'),
                   /*onTap: () {
                        // Update the state of the app.
                       // ...
                           },*/ 
                     ), 
                     ListTile( 
                        onTap: () =>Share.share("My flutter app text"),               
                        leading: Icon(Icons.share),    
                        title: const Text('Share'), 
                      ), 
                    ListTile( 
                      onTap: (){
                          AlertDialog alert= AlertDialog(
                            actions: [
                              TextButton(onPressed: ()=> launch("mailto:ridhemgawri293@gmail.com"), child: Text('Gmail')),
                              TextButton(onPressed: ()=> launch("https://api.whatsapp.com/send?text=My app text&phone=919023084430"), child: Text('Whatsapp')),
                            ],
                         title: Text('Send Via'),
                           );  
                         showDialog(
                               context: context,
                              builder: (BuildContext context) {
                              return alert;
                             },
                           ); 
                         },       
                        leading: Icon(Icons.quiz),    
                        title: const Text('Send Query'), 
                      ),
                    // ListTile( 
                    //     onTap: () => print("Item 5 selected"),               
                    //     leading: Icon(Icons.airplanemode_inactive_sharp),    
                    //     title: const Text('Item 5'), 
                    //   ),
                    // Divider(height: 1.0,
                    // color: Colors.grey,
                    // thickness: 2.0,
                    // ),
                    // ListTile( 
                    //     onTap: () => print("Item 5 selected"),               
                    //     leading: Icon(Icons.share),    
                    //     title: const Text('Share'), 
                    //   ),
                  ],
                ),
              ), 
           body: SingleChildScrollView(
          //scrollDirection: Axis.horizontal,  
           scrollDirection: Axis.vertical, // by default
            child:Column( 
            crossAxisAlignment: CrossAxisAlignment.start, 
           // mainAxisAlignment: MainAxisAlignment.start,
            children: [
            CarouselSlider.builder(
             itemCount: items.length,
             options: CarouselOptions(
            height: 200,
           aspectRatio: 16/9,
           viewportFraction: 0.8,
           initialPage: 0,
            enableInfiniteScroll: true,
            reverse: false,
            autoPlay: true,
            autoPlayInterval: Duration(seconds: 3),
            autoPlayAnimationDuration: Duration(milliseconds: 800),
            autoPlayCurve: Curves.fastOutSlowIn,
            enlargeCenterPage: true,
            scrollDirection: Axis.horizontal,
           ),
             itemBuilder: (BuildContext context, int itemIndex, int pageViewIndex) {
              return Container(
                child: ClipRRect(
               borderRadius: BorderRadius.circular(10.0),
               //  child:Image.network('http://3.bp.blogspot.com/_fU7LdRkUMVM/TJTouRK_dTI/AAAAAAAAChM/O08EDbQJTwA/s1600/cute-baby-dog.jpeg',
               child: Image.asset(items[itemIndex],//??????
               height:500.0, 
               width:500.0,
              scale: 1.0,
               ),
              ),
             );
          }    
           ),
            
          Padding(
              padding: const EdgeInsets.only(left:50.0), 
              child:Text('Start Quiz:',
              style:TextStyle( 
              fontSize:25.0, 
              fontWeight:FontWeight.w800, 
              color:Colors.purple[400],
          //    decoration:TextDecoration.underline,   // can use other styles instead of underline  
           //   decorationColor: Colors.red[200],
              decorationThickness: 2,
           //   decorationStyle: TextDecorationStyle.dashed,  // always works along with the above line 
              fontFamily: 'Abeezee_italic',
             ),    
              ),      
          ),  
          Container(
            height: 220*quizlist.length.toDouble(),
            margin: EdgeInsets.only(bottom: 200.0),
            child: ListView.builder(
              itemCount: quizlist.length,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return  Container(
           margin: EdgeInsets.fromLTRB(10.0,5,10,10),
             height: 200,
             width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
             borderRadius: BorderRadius.all(Radius.circular(50.0)),
             color: Colors.purple[100],
            ),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(150.0)),
                    child: Image.asset(quizlist[index]['img'],
                    fit: BoxFit.cover,
                 height:150.0, 
                 width:150.0,
                scale: 2.0,
                  ),
                 ),
                ),
               Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 200,
                    child: RichText(
                      maxLines:10,
                      overflow: TextOverflow.ellipsis,
                      text: TextSpan(
                        spellOut: false,
                        style: TextStyle(color: Colors.black),
                        text: quizlist[index]['txt']
                      )
                    ),
                  ),
                  RaisedButton(
                    padding:EdgeInsets.symmetric(horizontal:20.0, vertical: 10.0), 
                      shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => descriptions(quizid: quizlist[index]['id'],)
                            ),
                          );
                        // Navigator.pushNamed(context, "/description")
                      }, 
                      color:Colors.purple[200],
                      child: Text(
                       'Take Quiz', 
                       style:(  
                         TextStyle(
                          fontSize: 18.0,
                          color:Colors.black, 
                          )
                        ),
                       ), 
                   ),
                ],
               )
              ],
            )
          );
              }
              ),
          ),
            ] 
           ),
         ),
       ),
      );
Future<bool>onWillPop() async{
   final shouldPop = await showDialog(
    context: context,
    builder: (context) => AlertDialog(
        title:Text('Are you sure?'),
        content:Text('do you want to exit the home screen?'),
        actions: <Widget>[
          FlatButton(
            onPressed: () => Navigator.of(context).pop(false),
            child:Text('No'),
          ),
          FlatButton(
            onPressed: () => Navigator.of(context).pop(true),
            child:Text('Yes'),
          ),
        ],
      ),
     );
     return shouldPop ?? false;
    }
      }
//   }