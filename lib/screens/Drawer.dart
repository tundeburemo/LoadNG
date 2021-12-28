import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:loadng/styles/AppColors.dart';
import 'package:loadng/screens/logout.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:loadng/styles/AppImage.dart';
import 'package:loadng/widgets/loginScreen.dart';
import 'package:loadng/utils/customFunction.dart';
import 'package:loadng/locator.dart';
import "package:loadng/model/system/route_argument.dart";
import 'package:loadng/styles/AppFontSizes.dart';
import 'package:streaming_shared_preferences/streaming_shared_preferences.dart';
import 'package:loadng/services/appSettings.dart';
import 'package:loadng/styles/AppText.dart';


var functionfile = locator<CustomFunction>();
class UserDrawer extends StatefulWidget {
  UserDrawer({Key key}) : super(key: key);

  @override
  _UserDrawerState createState() => _UserDrawerState();
}
    final profileImg = new Container(
      margin: new EdgeInsets.symmetric(horizontal: 16.0),
      alignment: FractionalOffset.center,
      child: new CircleAvatar(
        child:Image.asset(AppImage.profile),//CahedNetworkImageProvider("https"),
        // backgroundImage: CachedNetworkImageProvider(t1_ic_user1),
        radius: 50,
      ),
    );
class _UserDrawerState extends State<UserDrawer> {
  var username ="";
  var email= "";
  var mainacc= "";
bool sendme=false;
  @override
  void initState() { 
    userInfo();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return ClipPath(
        clipper: OvalRightBorderClipper(), 
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: Drawer(
          child: Container(
            padding: const EdgeInsets.only(left: 16.0, right: 40),
            decoration: BoxDecoration(
              color: AppColors.appShadowColor,
            ),
            width: 300,
            child: SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Container(
                      alignment: Alignment.centerRight,
                      child: IconButton(
                        icon: Icon(
                          Icons.power_settings_new,
                          color: AppColors.appDarkRed,
                        ),
                        onPressed: () {
                             showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return LogoutDialog();
                        });
                        },
                      ),
                    ),
                    Container(
                      height: 90,
                      width: 90,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(width: 2, color: AppColors.appTextColorSecondary),
                        // image: DecorationImage(
                        //     image: CachedNetworkImageProvider(
                        //         'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcTD8u1Nmrk78DSX0v2i_wTgS6tW5yvHSD7o6g&usqp=CAU')),
                      ),
                      child: profileImg,
                    ),
                    SizedBox(height: 5.0), 
                    Text(
                      "$username",
                      style: TextStyle(
                          color: AppColors.cardBackgroundBlackDark,
                          fontSize: 18.0,
                          fontWeight: FontWeight.w600,
                          fontFamily: AppFontSize.montbold),
                    ),
                    Text("$email",
                        style: TextStyle(
                            color: AppColors.cardBackgroundBlackDark, fontSize: 16.0)),
            (mainacc!=''&&mainacc.isNotEmpty?
            Text("Main Account: $mainacc",
                        style: TextStyle(
                            color: AppColors.cardBackgroundBlackDark, fontSize: 16.0)):Container()),

                    30.height,
                    GestureDetector(
                      onTap:(){
                          Navigator.of(context).pushNamed('/userdashboard');
                      },
                      child:
                    itemList(
                        Icon(Icons.home, color: AppColors.cardBackgroundBlackDark),"Home")),

                    Divider(),
                   15.height,
                      GestureDetector(
                      onTap:(){
                          Navigator.of(context).pushNamed('/userprofile');
                      },
                      child:
                    itemList(Icon(Icons.person_pin, color: AppColors.cardBackgroundBlackDark),
                        "My Profile")),
                        Divider(),
                   15.height, 
                      GestureDetector(
                      onTap:(){
                           if(mainacc!=" "&&mainacc.isNotEmpty&&mainacc!=null){
                                              Navigator.of(context).pushNamed('/coinslist');

              }else{
  showDialog(
          context: context,
          builder: (context) => new AlertDialog(
            title:  Text('UPDATE ACCOUNT',
                style:  TextStyle(color: Colors.black, fontSize: 20.0)),
            content:  Text(
                'Hello LoadNG User, You have to fill in your bank account and profile details before you proceed to sell cryptocurrency on LoadNG. Kindly do that by clicking on the button below.'),
            actions: <Widget>[
           Material(
              color:AppColors.shadowdarkblack2,
              child: FlatButton( 
                onPressed: () =>
                    Navigator.of(context).pushNamed('/usereditprofile'), // this line dismisses the dialog
                child: new Text('GO TO SETTINGS', style: TextStyle(fontSize: 14.0,color: Colors.white)),
              ))
            ],
          ),
        );
              }
                      },
                      child:
                    itemList(Icon(Icons.attach_money, color: AppColors.cardBackgroundBlackDark),
                        "Sell Coins")),
  //                   Divider(),
  //                   15.height,
  //                     GestureDetector(
  //                     onTap:(){
  //                          if(mainacc!=" "&&mainacc.isNotEmpty&&mainacc!=null){
  //                                             Navigator.of(context).pushNamed('/buycoinslist');

  //             }else{
  // showDialog(
  //         context: context,
  //         builder: (context) => new AlertDialog(
  //           title:  Text('UPDATE ACCOUNT',
  //               style:  TextStyle(color: Colors.black, fontSize: 20.0)),
  //           content:  Text(
  //               'Hello LoadNG User, sorry you need to add at least a bank under your bank settings in my account page as well as update your profile in my profile page before you can start using any of our services,sorry for any problem caused.'),
  //           actions: <Widget>[
  //          Material(
  //             color:AppColors.shadowdarkblack2,
  //             child: FlatButton( 
  //               onPressed: () =>
  //                   Navigator.of(context).pushNamed('/userprofile'), // this line dismisses the dialog
  //               child: new Text('GO TO SETTINGS', style: TextStyle(fontSize: 14.0,color: Colors.white)),
  //             ))
  //           ],
  //         ),
  //       );
  //             }
  //                     },
  //                     child:
  //                   itemList(Icon(Icons.attach_money, color: AppColors.cardBackgroundBlackDark),
  //                       "Buy Coins")),
                      Divider(),
                   15.height, 
                     GestureDetector(
                      onTap:(){
                         Navigator.of(context).pushNamed('/usernotification');

                      },
                      child:
                    itemList(
                        Icon(Icons.notifications, color: AppColors.cardBackgroundBlackDark),
                        "Notifications")),
                    Divider(),
                    15.height,
                     GestureDetector(
                      onTap:(){
                          Navigator.of(context).pushNamed('/useraccount');
                      },
                      child:
                    itemList(Icon(Icons.settings, color: AppColors.cardBackgroundBlackDark),
                        "My Account")),
                    Divider(),
                    //     15.height,
                    //  GestureDetector(
                    //   onTap:(){
                    //       // Navigator.of(context).pushNamed('/useraccount');
                    //   },
                    //   child:
                    // itemList(Icon(Icons.settings, color: AppColors.cardBackgroundBlackDark),
                    //     "Share and invite")),
                    // Divider(),
                        15.height,
                     GestureDetector(
                      onTap:(){
                         toast(AppTexts.featurenotavailable);
                      },  
                      child:
                    itemList(Icon(Icons.money, color: AppColors.cardBackgroundBlackDark),
                        "Pay Bills")),
                    Divider(),
                    15.height,
                         GestureDetector(
                      onTap:(){
                        Uri theurl=Uri.parse("https://tawk.to/chat/5d49d339e5ae967ef80ec6b5/default");
             if(sendme){
                             Navigator.of(context).pushNamed('/inappwebview2',arguments: new RouteArgument(argumentsList: ["LoadNG Support",  theurl,"/userdashboard"]));   
                          // functionfile.launchURL("https://tawk.to/chat/5d49d339e5ae967ef80ec6b5/default");

}else{
      functionfile.showerror(context);
}
                      }, 
                      child:
                    itemList(Icon(Icons.chat, color: AppColors.cardBackgroundBlackDark),
                        "Chat Support")),
                    Divider(),
                    15.height,
                     GestureDetector(
                      onTap:(){
                       showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return LogoutDialog();
                        });
                      },
                      child:
                    itemList(
                        Icon(Icons.logout, color: AppColors.cardBackgroundBlackDark),
                        "Log Out")),
                    Divider(),
                    15.height,
                  ],
                ),
              ),
            ),
          ),
        ),
    );
  }

      Future<void> userInfo() async {
        checkmyinternet();
        final prefs = await StreamingSharedPreferences.instance;
    var storeddetails = MyAppSettings(prefs);
    
    if(mounted){
    setState(() {
      username= storeddetails.dusername.getValue();
      email= storeddetails.demail.getValue();
      mainacc= storeddetails.dmainaccno.getValue();
    });
    }
  }

  
  checkmyinternet() {
    functionfile.isInternet().then((value) =>
        functionfile.checkInternetAccess().then((value2) => value && value2
            ? 
            (mounted?
            setState(() {
                sendme = true;
              })
            :sendme = false)
            : (mounted?setState(() {
                sendme = false;
              }) :sendme = false) ));
  }
}




class OvalRightBorderClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, 0);
    path.lineTo(size.width - 50, 0);
    path.quadraticBezierTo(
        size.width, size.height / 4, size.width, size.height / 2);
    path.quadraticBezierTo(size.width, size.height - (size.height / 4),
        size.width - 40, size.height);
    path.lineTo(0, size.height);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }

  
}
