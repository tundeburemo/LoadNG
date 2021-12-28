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
import 'package:flutter_svg/flutter_svg.dart';


var functionfile = locator<CustomFunction>();
class UserDrawer2 extends StatefulWidget {
  UserDrawer2({Key key}) : super(key: key);

  @override
  _UserDrawer2State createState() => _UserDrawer2State();
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
class _UserDrawer2State extends State<UserDrawer2> {
  var username ="";
  var email= "";
  var mainacc= "";
bool sendme=false;
int selectedItem=0;
  @override
  void initState() { 
    userInfo();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.85,
      height: MediaQuery.of(context).size.height,
      child: Drawer(
        elevation: 8,
        child: SingleChildScrollView(
          child: Container(
            width: MediaQuery.of(context).size.width,
            color: AppColors.modernWhite,
            child: Column(
              children: <Widget>[
                Padding(
                    padding: const EdgeInsets.only(top: 70, right: 20),
                    child: Container(
                      padding: EdgeInsets.fromLTRB(20, 40, 20, 40),
                      decoration: new BoxDecoration(
                          color: AppColors.appColorPrimary,
                          borderRadius: new BorderRadius.only(
                              bottomRight: const Radius.circular(24.0),
                              topRight: const Radius.circular(24.0))),
                      /*User Profile*/
                      child: Row(
                        children: <Widget>[
                          CircleAvatar(
                              backgroundImage: NetworkImage("t2_profile"),
                              radius: 40),
                          SizedBox(width: 16),
                          Expanded(
                            child: Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  text("t2_user_name",
                                      textColor: AppColors.modernWhite,
                                      fontFamily: AppFontSize.fontBold,
                                      fontSize: AppFontSize.textSizeNormal),
                                  SizedBox(height: 8),
                                  text("t2_user_email",
                                      textColor: AppColors.modernWhite,
                                      fontSize: AppFontSize.textSizeMedium),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    )),
                SizedBox(height: 30),
                getDrawerItem(AppImage.t5_circle, "t2_lbl_profile", 1),
                getDrawerItem(AppImage.t5_circle, "t2_lbl_message", 2),
                getDrawerItem(AppImage.t5_circle, "t2_lbl_report", 3),
                getDrawerItem(AppImage.t5_circle, "t2_lbl_settings", 4),
                getDrawerItem(AppImage.t5_circle, "t2_lbl_sign_out", 5),
                SizedBox(height: 30),
                Divider(color: AppColors.t2_view_color, height: 1),
                SizedBox(height: 30),
                getDrawerItem(AppImage.t5_circle, "t2_lbl_share_and_invite", 6),
                getDrawerItem(AppImage.t5_circle, "t2_lbl_help_and_feedback", 7),
                SizedBox(height: 30),
              ],
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

    Widget getDrawerItem(String icon, String name, int pos) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedItem = pos;
        });
      },
      child: Container(
        color: selectedItem == pos ? AppColors.appColorPrimaryLight : AppColors.modernWhite,
        padding: EdgeInsets.fromLTRB(20, 16, 20, 16),
        child: Row(
          children: <Widget>[
            SvgPicture.asset(icon, width: 20, height: 20),
            SizedBox(width: 20),
            text(name,
                textColor:
                    selectedItem == pos ? AppColors.appColorPrimaryDark : AppColors.appColorPrimary,
                fontSize: AppFontSize.textSizeLargeMedium,
                fontFamily: AppFontSize.fontMedium)
          ],
        ),
      ),
    );
  }
}


