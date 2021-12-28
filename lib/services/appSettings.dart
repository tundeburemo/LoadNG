import 'package:streaming_shared_preferences/streaming_shared_preferences.dart';

class MyAppSettings {  MyAppSettings(StreamingSharedPreferences preferences)
      : did = preferences.getInt('userid', defaultValue: 0),
        demail = preferences.getString('email', defaultValue: ''),
        dwalletbal = preferences.getInt('mainbal', defaultValue: 0),
        drefillbal = preferences.getString('refillbal', defaultValue:"0"),
        dbillbal = preferences.getString('billbal', defaultValue: "0"),
        dusername = preferences.getString('usernname', defaultValue: ''),
        dcoins = preferences.getString('usercoins', defaultValue: '0'),
        dphoneno = preferences.getString('userphoneno', defaultValue: ''),
        dreferby = preferences.getString('referby', defaultValue: ''),
        dusertype = preferences.getString('usertype', defaultValue: ''),
        duserlevel = preferences.getString('userlevel', defaultValue: ''),
        dprovidusaccno = preferences.getInt('providusaccno', defaultValue: 0),
        dmainaccno = preferences.getString('mainaccno', defaultValue: ''),
        dmainaccname = preferences.getString('mainaccname', defaultValue: ''),
        dmainbnkname = preferences.getString('mainbnkname', defaultValue: ''),
        dactivatepin = preferences.getInt('activatepin', defaultValue: 0),
        djoineddate = preferences.getString('datejoined', defaultValue: ''),
        dfullname = preferences.getString('fullnname', defaultValue: ''),
        dresetpass = preferences.getInt('resetpass', defaultValue: 0),
        currentversion = preferences.getString('myversion', defaultValue: " "),
        canlogin = preferences.getInt('canlogin', defaultValue: 0),
        resetpass = preferences.getInt('resetpass', defaultValue: 0),
        activepax = preferences.getInt('activepax', defaultValue: 0),
        kycfilled = preferences.getInt('kycfilled', defaultValue: 0),
        kycapproved = preferences.getInt('kycapproved', defaultValue: 0),
        dstarcount= preferences.getInt('starcount', defaultValue: 0);
                        

  final Preference<int> did;
  final Preference<String> demail;
  final Preference<String> dphoneno;
  final Preference<int> dwalletbal;
  final Preference<String> drefillbal;
  final Preference<String> dbillbal;
  final Preference<String> dcoins;
  final Preference<String> dusername;
  final Preference<String> dusertype;
  final Preference<String> duserlevel;
  final Preference<int> dprovidusaccno;
  final Preference<String> dmainaccno;
  final Preference<String> dmainaccname;
  final Preference<String> dmainbnkname;
  final Preference<int> dactivatepin;
  final Preference<String> djoineddate;
  final Preference<String> dfullname;
  final Preference<int> dstarcount;
  final Preference<int> dresetpass;
  final Preference<int> canlogin;
  final Preference<int> resetpass;
  final Preference<int> activepax;
  final Preference<int> kycfilled;
  final Preference<int> kycapproved;
  final Preference<String> dreferby;
  final Preference<String> currentversion;

   
}
