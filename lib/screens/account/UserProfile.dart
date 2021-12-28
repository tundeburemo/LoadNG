import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loadng/utils/customFunction.dart';
import 'package:loadng/locator.dart';
import 'package:loadng/styles/AppFontSizes.dart';
import 'package:loadng/styles/AppColors.dart';
import 'package:loadng/styles/AppImage.dart';
import 'package:loadng/widgets/loginScreen.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:streaming_shared_preferences/streaming_shared_preferences.dart';
import 'package:loadng/services/appSettings.dart';

var functionfile = locator<CustomFunction>();
class UserProfile extends StatefulWidget {
    static var tag = "/userprofile";
  UserProfile({Key key}) : super(key: key);

  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  var username ="";
  var email= "";
  var mainaccbnk;
  var userlevel=" ";
   var   mainaccname=" ";
   var   mainaccno=" ";
  var    fullname=" ";
   var   phoneno=" ";
  Widget counter(String counter, String counterName) {
    return Column(
      children: <Widget>[
        profile(counter),
        text(counterName,
            textColor: t1TextColorPrimary,
            fontSize: AppFontSize.textSizeMedium,
            fontFamily: AppFontSize.fontMedium)
      ],
    );
  }
  @override
  void initState() { 
    userInfo();
    super.initState();
    
  }
  @override
  Widget build(BuildContext context) {
    functionfile.changeStatusColor(Colors.transparent);
    final profileImg = new Container(
      margin: new EdgeInsets.symmetric(horizontal: 16.0),
      alignment: FractionalOffset.center,
      child: new CircleAvatar(
        child:Image.asset(AppImage.profile),//CahedNetworkImageProvider("https"),
        // backgroundImage: CachedNetworkImageProvider(t1_ic_user1),
        radius: 50,
      ),
    );

    return Scaffold(
      backgroundColor: AppColors.t1_app_background,
      body: Stack(
        children: <Widget>[
          SingleChildScrollView(
            padding: EdgeInsets.only(top: 90, left: 2, right: 2),
            physics: ScrollPhysics(),
            child: Container(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                     Container(
              width: double.infinity,
              decoration:
                  boxDecoration(showShadow: true, radius: AppFontSize.spacing_standard),
              child: Stack(
                alignment: Alignment.topRight,
                children: <Widget>[
                  Container(
                    child: Column(
                      children: <Widget>[
                        Container(
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                    color: AppColors.shadowdarkblack, width: 2)),
                            child: profileImg
                                .paddingAll(3)),
                        text("$username",
                                textColor: AppColors.t12_text_color_primary,
                                fontFamily: AppFontSize.montbold,
                                fontSize: AppFontSize.textSizeNormal)
                            .paddingTop(AppFontSize.spacing_control),
                        text("$userlevel LEVEL", fontSize: AppFontSize.textSizeMedium)
                            .paddingTop(AppFontSize.spacing_control_half),
                             
                      ],
                    ).paddingAll(AppFontSize.spacing_standard_new),
                    width: double.infinity,
                  ),
                  text("Edit",
                          textColor: AppColors.appLightRed, fontFamily: AppFontSize.fontMedium)
                      .paddingAll(AppFontSize.spacing_standard)
                      .onTap(() {
 Navigator.of(context).pushNamed('/usereditprofile');
                      })
                ],
              ),
            ).paddingAll(AppFontSize.spacing_standard_new),
                                  SizedBox(height: 8),
                  Container(
                    margin: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                    decoration: boxDecoration(radius: 10, showShadow: true),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(height: 8),
                          rowHeading("Main Bank Account"),
                            SizedBox(height: 16),
                                 Padding(
                            padding: const EdgeInsets.fromLTRB(16, 0, 0, 0),child:sidetext("$mainaccbnk"),),
                           SizedBox(height: 8),
                            Padding(
                            padding: const EdgeInsets.fromLTRB(16, 10, 16, 10),
                            child: view(),
                          ), 
                          SizedBox(height: 8),
                            Padding(
                            padding: const EdgeInsets.fromLTRB(16, 0, 0, 0),child: sidetext("$mainaccname")),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(16, 10, 16, 10),
                            child: view(),
                          ),
                          SizedBox(height: 8),
                             Padding(
                            padding: const EdgeInsets.fromLTRB(16,  0, 0, 0),child:sidetext("$mainaccno")),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(16, 10, 16, 10),
                            child: view(),
                          ),
                          SizedBox(height: 16),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 8),
                  Container(
                    margin: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                    decoration: boxDecoration(radius: 10, showShadow: true),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                         mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(height: 8),
                          rowHeading("Personal Details"),
                          SizedBox(height: 16),
                            Padding(
                            padding: const EdgeInsets.fromLTRB(16, 0, 0, 0),child: sidetext("$fullname")),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(16, 10, 16, 10),
                            child: view(),
                          ),
                          SizedBox(height: 8),
                            Padding(
                            padding: const EdgeInsets.fromLTRB(16, 0, 0, 0),child: sidetext("$username")),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(16, 10, 16, 10),
                            child: view(),
                          ),
                          SizedBox(height: 16), 
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 8),
                  Container(
                    margin: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                    decoration: boxDecoration(radius: 10, showShadow: true),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                         mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(height: 8),
                          rowHeading("Contact Details"),
                          SizedBox(height: 16),
                            Padding(
                            padding: const EdgeInsets.fromLTRB(16, 0, 0, 0),child: sidetext("$phoneno")),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(16, 10, 16, 10),
                            child: view(),
                          ),
                         SizedBox(height: 8),
                            Padding(
                            padding: const EdgeInsets.fromLTRB(16, 0, 0, 0),child: sidetext("$email")),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(16, 10, 16, 10),
                            child: view(),
                          ),
                          SizedBox(height: 8),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                ],
              ),
            ),
          ),
          TopBar(titleName: "My Profile"),
        ],
      ),
    );
  }


        Future<void> userInfo() async {
        final prefs = await StreamingSharedPreferences.instance;
    var storeddetails = MyAppSettings(prefs);
    
    if(mounted){
    setState(() {
      username= storeddetails.dusername.getValue();
      email= storeddetails.demail.getValue();
      userlevel= storeddetails.duserlevel.getValue();
      mainaccname= storeddetails.dmainaccname.getValue();
      mainaccno= storeddetails.dmainaccno.getValue();
      mainaccbnk= storeddetails.dmainbnkname.getValue();
      fullname= storeddetails.dfullname.getValue();
      phoneno= storeddetails.dphoneno.getValue();
    });
    }
  }
}
