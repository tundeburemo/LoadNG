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
import 'dart:io';
import 'package:loadng/services/apis/bank.dart';
import 'package:loadng/services/apis/account.dart';
import 'package:loadng/styles/AppText.dart';

var accountapi = locator<AccountApi>();
var functionfile = locator<CustomFunction>();
var bankapi = locator<BankApi>();

class UserEditProfile extends StatefulWidget {
  static String tag = '/usereditprofile';

  @override
  UserEditProfileState createState() => UserEditProfileState();
}

class UserEditProfileState extends State<UserEditProfile> {
  TextEditingController _accno, _accname, _pass;
  TextEditingController _name, _phone;
  String _selectedLocation = '';
  String bankdropdownNames,
      paxbankname,
      withdrawbankname,
      bcbnkname,
      gcbankname,
      unibankname,
      pmbankname;
  List<String> listOfCategory = [];
  var userbankscount = 0;
  var allbanks = <String>[];
  var fullname = " ";
  var phoneno = " ";
  final profileImg = new Container(
      alignment: FractionalOffset.center,
      child: new CircleAvatar(
        child:
            Image.asset(AppImage.profile), //CahedNetworkImageProvider("https"),
        // backgroundImage: CachedNetworkImageProvider(qibus_ic_profile),
        radius: 50,
      ));
  @override
  void initState() {
    _accno = TextEditingController();
    _accname = TextEditingController();
    _pass = TextEditingController();
    userInfo();
    _name = TextEditingController();
    _phone = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _name.clear();
    _phone.clear();
    _accno.clear();
    _accname.clear();
    _pass.clear();
    super.dispose();
  }

  Widget rowHeading(var label, var subLabel, controller) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 10, 0),
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 2,
            child: text(label, textColor: AppColors.qIBus_textChild),
          ),
          Expanded(
            flex: 3,
            child: TextField(
              controller: controller,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.all(0.0),
                isDense: true,
                hintText: subLabel,
                border: InputBorder.none,
              ),
            ),
          )
        ],
      ),
    );
  }

  Row rowHeading1(var label) {
    return Row(
      children: <Widget>[
        Padding(
            padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
            child: text(label,
                fontFamily: AppFontSize.montbold,
                textColor: AppColors.t1_textColorPrimary,
                fontSize: AppFontSize.textSizeMedium)),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.qIBus_app_background,
        body: Column(
          children: <Widget>[
            TopBar(
              titleName: "Edit Profile",
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Stack(
                      children: <Widget>[
                        profileImg,
                      ],
                    ),
                    Container(
                        margin: EdgeInsets.only(
                            left: AppFontSize.spacing_standard_new,
                            right: AppFontSize.spacing_standard_new,
                            top: AppFontSize.spacing_standard_new),
                        decoration: boxDecoration(
                          showShadow: true,
                          bgColor: AppColors.appWhite,
                          radius: AppFontSize.spacing_middle,
                        ),
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(
                              AppFontSize.spacing_standard,
                              AppFontSize.spacing_standard,
                              AppFontSize.spacing_standard,
                              AppFontSize.spacing_standard_new),
                          child: Column(
                            children: <Widget>[
                              rowHeading1("Edit Personal Details"),
                              SizedBox(height: AppFontSize.spacing_standard),
                              rowHeading("Name", "Fullname", _name),
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(16, 10, 16, 10),
                                child: view(),
                              ),
                              SizedBox(height: 8),
                              rowHeading("Phone No", "08000000000", _phone),
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(16, 10, 16, 0),
                                child: view(),
                              ),
                              SizedBox(height: 8),
                              // rowHeading("Password","my password",_pass),
                              // Padding(
                              //   padding:
                              //       const EdgeInsets.fromLTRB(16, 10, 16, 0),
                              //   child: view(),
                              // ),
                            ],
                          ),
                        )),
                       
                        Padding(
                          padding: EdgeInsets.fromLTRB(15,5,15,0),
                       child:  Material(
                                    color: AppColors.shadowdarkblack2,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.center ,
      children: <Widget>[
        Padding(
            padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
            child: FlatButton(
                                      onPressed: () {
                                        showBankAdd(context);
                                      }, // this line dismisses the dialog
                                      child: new Text('Add Bank',
                                          style: TextStyle(
                                              fontSize: 16.0,
                                              color: Colors.white)),
                                    ))]))),
                    Container(
                        margin: EdgeInsets.only(
                            left: AppFontSize.spacing_standard_new,
                            right: AppFontSize.spacing_standard_new,
                            top: AppFontSize.spacing_standard_new,
                            bottom: AppFontSize.spacing_standard_new),
                        decoration: boxDecoration(
                          showShadow: true,
                          bgColor: AppColors.appWhite,
                          radius: AppFontSize.spacing_middle,
                        ),
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(
                              AppFontSize.spacing_standard,
                              AppFontSize.spacing_standard,
                              AppFontSize.spacing_standard,
                              AppFontSize.spacing_standard_new),
                          child: Column(
                            children: <Widget>[
                              rowHeading1("Set Main Bank Account"),
                              SizedBox(height: AppFontSize.spacing_standard),

                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(20, 0, 10, 0),
                                child: Row(
                                  children: <Widget>[
                                    Expanded(
                                      flex: 2,
                                      child: text("Bank Account",
                                          textColor:
                                              AppColors.iconColorPrimaryDark),
                                    ),
                                    Expanded(
                                        flex: 3,
                                        child: DropdownButtonHideUnderline(
                                          child: DropdownButton<String>(
                                            value: _selectedLocation,
                                            items: allbanks.map((String value) {
                                              return new DropdownMenuItem<
                                                  String>(
                                                value: value,
                                                child: text(value,
                                                    fontSize: AppFontSize
                                                        .textSizeMedium,
                                                    textColor:
                                                        AppColors.realblack),
                                              );
                                            }).toList(),
                                            onChanged: (newValue) {
                                              setState(() {
                                                _selectedLocation = newValue;
                                              });
                                            },
                                          ),
                                        )),
                                  ],
                                ),
                              ),


                            ],
                          ),
                        )),
                    Container(
                      margin: EdgeInsets.only(
                          left: AppFontSize.spacing_standard_new,
                          right: AppFontSize.spacing_standard_new),
                      child: QIBusAppButton(
                        textContent: "Save",
                        onPressed: () {
                          updateprofile(
                              phoneno: _phone.text,
                              name: _name.text,
                              bankacc: _selectedLocation);
                        },
                      ),
                    ),
                    SizedBox(
                      height: AppFontSize.spacing_standard_new,
                    )
                  ],
                ),
              ),
            )
          ],
        ));
  }

  Future<void> userInfo() async {
      await Future.delayed(Duration(seconds: 1));
    functionfile.onHorizontalLoading1(context);
    var theinternet = await functionfile.isInternet();
    var theinternet2 = await functionfile.checkInternetAccess();

    if (theinternet && theinternet2) {
      final prefs = await StreamingSharedPreferences.instance;
      var storeddetails = MyAppSettings(prefs);

      if (mounted) {
        setState(() {
          _selectedLocation = storeddetails.dmainaccno.getValue();
          _name.text = storeddetails.dfullname.getValue();
          _phone.text = storeddetails.dphoneno.getValue();
        });
      }
       var thetotal=0;
      var getbanks = await bankapi.userbanklist();
      if(getbanks!=null){
      thetotal = getbanks.banks.length;
      setState(() {
        userbankscount=thetotal;
      });
      var i = 0;
      for (i = 0; i < thetotal; i++) {
        if (!allbanks.contains(getbanks.banks[i].bankaccno)) {
          setState(() {
            allbanks.add(getbanks.banks[i].bankaccno);
            if (_selectedLocation == null ||
                _selectedLocation.isEmpty ||
                _selectedLocation == ''||
                _selectedLocation == ' ') {
              _selectedLocation = getbanks.banks[i].bankaccno;
            }
          });
        }
      }
      }

      // paytscak
      var getbanks2 = await bankapi.psbanklist();
       if(getbanks2!=null){
      var thetotal2 = getbanks2.banks.length;
      var j = 0;
    for (j = 0; j < thetotal2; j++) {
        if (!listOfCategory.contains(getbanks2.banks[j].bankname)) {
          if (mounted) {
            setState(() {
              listOfCategory.add(getbanks2.banks[j].bankname);
            });
          }
        }
      }
       }

  if (allbanks == [] && thetotal != 0) {
        Navigator.of(context).pop();
        showDialog(
          context: context,
          builder: (context) => new AlertDialog(
            title: Text('Reload to get the bank list',
                style: TextStyle(color: Colors.black, fontSize: 20.0)),
            content: Text(
                'Ooops! Kindly check your internet connection as the list of your banks failed to load. Reload page to try again.'),
            actions: <Widget>[
              Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    FlatButton(
                      onPressed: () {
                        Navigator.pop(context);
                        allbanks = [];
                        listOfCategory=[];
                        userInfo();
                      }, // this line dismisses the dialog
                      child:
                          new Text('Reload', style: TextStyle(fontSize: 18.0)),
                    ),
                    FlatButton(
                      onPressed: () => Navigator.pop(
                          context), // this line dismisses the dialog
                      child: new Text('OK', style: TextStyle(fontSize: 18.0)),
                    )
                  ])
            ],
          ),
        );
      } else {
        if(mounted){
        Navigator.of(context).pop();
        }
        if (thetotal == 0) {
          showDialog(
            context: context,
            builder: (context) => new AlertDialog(
              title: Text('Empty Bank List',
                  style: TextStyle(color: Colors.black, fontSize: 20.0)),
              content: Text(
                  'Ooops! You are yet to add your bank account detail. Kindly do so by clicking on the button below. Thanks.'),
              actions: <Widget>[
                Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      FlatButton(
                        onPressed: () {
                          Navigator.pop(context);
                          showBankAdd(context);
                        }, // this line dismisses the dialog
                        child: new Text('Add Bank account',
                            style: TextStyle(fontSize: 18.0)),
                      ),
                    ])
              ],
            ),
          );
        }
      }
    } else {
      Navigator.of(context).pop();
      functionfile.showerror(context);
    }
  } 

  Future showBankAdd(BuildContext context) {

    return showModalBottomSheet(
        backgroundColor: Colors.transparent,
        context: context,
        isScrollControlled: true,
        builder: (BuildContext context) {
          return FractionallySizedBox(
            heightFactor: 0.9,
            child: DraggableScrollableSheet(
              initialChildSize: 0.8,
              maxChildSize: 1,
              minChildSize: 0.25,
              builder:
                  (BuildContext context, ScrollController scrollController) {
                return StatefulBuilder(
                    builder: (BuildContext context, StateSetter setStates) {
                  return SingleChildScrollView(
                      child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topLeft:
                                Radius.circular(AppFontSize.spacing_standard),
                            topRight:
                                Radius.circular(AppFontSize.spacing_standard))),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Container(
                          width: double.infinity,
                          decoration: boxDecoration(
                              showShadow: true,
                              bgColor: Color(0xffBBd2fc).withOpacity(0.3),
                              radius: AppFontSize.spacing_standard),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                decoration: boxDecoration(
                                    showShadow: true,
                                    bgColor: Color(0xffBBd2fc),
                                    radius: AppFontSize.spacing_standard),
                                child: Image.asset(
                                  AppImage.appLogoblack,
                                  width: 40,
                                  height: 40,
                                ).paddingAll(AppFontSize.spacing_standard_new),
                              ).paddingRight(AppFontSize.spacing_standard_new),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    text("Add",
                                        textColor: AppColors.appColorPrimary,
                                        fontFamily: AppFontSize.montbold),
                                    text("New Bank Account",
                                            fontSize:
                                                AppFontSize.textSizeMedium,
                                            textColor:
                                                AppColors.appColorPrimary,
                                            fontFamily: AppFontSize.montbold)
                                        .paddingTop(
                                            AppFontSize.spacing_control_half),
                                  ],
                                ),
                              ),
                              // toolBarTitle("NEW").paddingTop(AppFontSize.spacing_standard_new),
                            ],
                          ).paddingAll(AppFontSize.spacing_standard),
                        ).paddingBottom(AppFontSize.spacing_standard_new),
                        Container(
                          width: double.infinity,
                          decoration: boxDecoration(
                              showShadow: true,
                              radius: AppFontSize.spacing_standard),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              text("Account Number",
                                      textColor: AppColors.appColorPrimary,
                                      fontFamily: AppFontSize.montlight)
                                  .paddingTop(AppFontSize.spacing_standard),
                              formField(context, "Enter your account number",
                                  controller: _accno,
                                  prefixIcon: Icons.attach_money, ontap: () {
                                FocusScopeNode currentFocus =
                                    FocusScope.of(context);
                                if (!currentFocus.hasPrimaryFocus) {
                                  currentFocus.unfocus();
                                }
                              }).paddingTop(AppFontSize.spacing_standard),
                              text("Choose Bank",
                                  textColor: AppColors.appColorPrimary,
                                  fontFamily: AppFontSize.montlight),
                              Card(
                                  color: AppColors.t12_edittext_background,
                                  child: DropdownButton(
                                    isExpanded: true,
                                    // dropdownColor: AppColors.appColorPrimaryDarkLight,
                                    value: bankdropdownNames,
                                    style: boldTextStyle(),
                                    icon: Icon(
                                      Icons.keyboard_arrow_down,
                                      color: AppColors.appColorPrimary,
                                    ),
                                    underline: 0.height,
                                    onChanged: (newValue) {
                                      setStates(() {
                                        toast(newValue);
                                        bankdropdownNames = newValue;
                                      });

                                      getbankaccname(
                                          bankname: newValue,
                                          accno: _accno.text);
                                    },
                                    items: listOfCategory.map((category) {
                                      return DropdownMenuItem(
                                        child: Text(category,
                                                style: primaryTextStyle())
                                            .paddingLeft(8),
                                        value: category,
                                      );
                                    }).toList(),
                                  )).paddingTop(AppFontSize.spacing_standard),
                              text("Account Name",
                                      textColor: AppColors.appColorPrimary,
                                      fontFamily: AppFontSize.montlight)
                                  .paddingTop(AppFontSize.spacing_standard),
                              formField(context, "Account Name",
                                      controller: _accname,
                                      prefixIcon:
                                          Icons.supervised_user_circle_sharp,
                                      isEnabled: false)
                                  .paddingTop(AppFontSize.spacing_standard),
                              SizedBox(
                                width: double.infinity,
                                child: MaterialButton(
                                  padding: EdgeInsets.only(
                                      top: AppFontSize.spacing_standard_new,
                                      bottom: AppFontSize.spacing_standard_new),
                                  child: text("Add Now",
                                      textColor: Colors.white,
                                      fontFamily: AppFontSize.fontMedium),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: new BorderRadius.circular(
                                          AppFontSize.spacing_standard)),
                                  color: AppColors.appColorPrimary,
                                  onPressed: () => {
                                    addbankacc(
                                        bankname: bankdropdownNames,
                                        accno: _accno.text,
                                        accname: _accname.text,
                                        pass: _pass.text)
                                  },
                                ),
                              ).paddingTop(AppFontSize.spacing_standard_new)
                            ],
                          ).paddingAll(AppFontSize.spacing_standard_new),
                        )
                      ],
                    ).paddingAll(AppFontSize.spacing_standard_new),
                  ));
                });
              }));
        });
  }

  getbankaccname({bankname, accno}) async {
    functionfile.onHorizontalLoading1(context);
    var theinternet = await functionfile.isInternet();
    var theinternet2 = await functionfile.checkInternetAccess();

    try {
      if (theinternet && theinternet2) {
        if (bankname.isEmpty) {
          Navigator.of(context).pop();
          toast('Please choose a bank',
              gravity: ToastGravity.CENTER, bgColor: AppColors.appLightRed);
        } else if (accno.isEmpty) {
          Navigator.of(context).pop();
          toast('Please enter account number',
              gravity: ToastGravity.CENTER, bgColor: AppColors.appLightRed);
        } else {
          var sendtbnkid = " ";
          var getbanks = await bankapi.psbanklist();
          var thetotal = getbanks.banks.length;
          var i = 0;
          for (i = 0; i < thetotal; i++) {
            if (getbanks.banks[i].bankname == bankname) {
              sendtbnkid = getbanks.banks[i].bankcode;
              break;
            }
          }

          var v = await bankapi
              .psbankname(bankcode: sendtbnkid, accno: accno)
              .timeout(Duration(seconds: 30), onTimeout: () {
            Navigator.of(context).pop();
            toast(AppTexts.nointerneterr,
                gravity: ToastGravity.CENTER, bgColor: AppColors.appLightRed);
            return null;
          });

          if (v != null) {
            if (v.status == true) {
              Navigator.of(context).pop();
              toast("Bank name fetched Successfully",
                  gravity: ToastGravity.CENTER,
                  bgColor: AppColors.appDark_parrot_green);
              _accname.text = v.msg;
            } else {
              Navigator.of(context).pop();

              toast(v.msg,
                  gravity: ToastGravity.CENTER, bgColor: AppColors.appLightRed);
            }
          } else {
            Navigator.of(context).pop();

            toast(AppTexts.nointerneterr,
                gravity: ToastGravity.CENTER, bgColor: AppColors.appLightRed);
          }
        }
      } else {
        Navigator.of(context).pop();

        toast(AppTexts.nointerneterr,
            gravity: ToastGravity.CENTER, bgColor: AppColors.appLightRed);
      }
    } on SocketException catch (_) {
      Navigator.of(context).pop();

      toast(AppTexts.nointerneterr,
          gravity: ToastGravity.CENTER, bgColor: AppColors.appLightRed);
    }
  }

  updateprofile({phoneno, name, bankacc}) async {
    functionfile.onHorizontalLoading1(context);
    var theinternet = await functionfile.isInternet();
    var theinternet2 = await functionfile.checkInternetAccess();

    try {
      if (theinternet && theinternet2) {
        if (name.isEmpty) {
          Navigator.of(context).pop();
          toast('Please enter a name',
              gravity: ToastGravity.CENTER, bgColor: AppColors.appLightRed);
        } else if (phoneno.isEmpty) {
          Navigator.of(context).pop();
          toast('Please enter a phone number',
              gravity: ToastGravity.CENTER, bgColor: AppColors.appLightRed);
        } else if (bankacc.isEmpty || bankacc == null || bankacc == '') {
          Navigator.of(context).pop();
          toast(
              'Please choose a bank account, if no bank account is listed that means you have not added a bank in your bank settings,kindly do that first',
              gravity: ToastGravity.CENTER,
              bgColor: AppColors.appLightRed);
        } else {
          var sendtbnkid = 0;
          var getbanks = await bankapi.userbanklist();
          var thetotal = getbanks.banks.length;
          var i = 0;
          for (i = 0; i < thetotal; i++) {
            if (getbanks.banks[i].bankaccno == bankacc) {
              sendtbnkid = getbanks.banks[i].bankid;
              break;
            }
          }
          var v = await accountapi
              .userupdateprofile(
                  name: name, phoneno: phoneno, bankid: sendtbnkid)
              .timeout(Duration(seconds: 20), onTimeout: () {
            Navigator.of(context).pop();
            toast(AppTexts.nointerneterr,
                gravity: ToastGravity.CENTER, bgColor: AppColors.appLightRed);
            return null;
          });

          if (v != null) {
            if (v.status == true) {
              Navigator.of(context).pop();
              toast("Great. Account Updated Successfuly!!!",
                  gravity: ToastGravity.CENTER,
                  bgColor: AppColors.appDark_parrot_green);
              var userdata = await accountapi.userfulldetails();
              if (userdata != null) {
                functionfile.storeDetails(
                  uname: userdata.username,
                  id: userdata.id,
                  email: userdata.email,
                  phoneno: userdata.phoneno,
                  mainbal: userdata.walletbal,
                  billbal: userdata.billbal,
                  refillbal: userdata.refillbal,
                  coins: userdata.coins,
                  referby: userdata.referby,
                  usertype: userdata.usertype,
                  userlevel: userdata.userlevel,
                  providusaccno: userdata.providusaccno,
                  mainaccno: userdata.mainaccno,
                  mainaccname: userdata.mainaccname,
                  mainbnkname: userdata.mainaccbankname,
                  activatepin: userdata.activatepin,
                  datejoined: userdata.datejoined,
                  fullnname: userdata.fullname,
                  starcount: userdata.userstarcount,
                  canlogin: 1,
                );
              }

              Navigator.of(context).pushNamed('/userdashboard');
            } else {
              Navigator.of(context).pop();

              toast(v.msg,
                  gravity: ToastGravity.CENTER, bgColor: AppColors.appLightRed);
            }
          } else {
            Navigator.of(context).pop();

            toast(AppTexts.nointerneterr,
                gravity: ToastGravity.CENTER, bgColor: AppColors.appLightRed);
          }
        }
      } else {
        Navigator.of(context).pop();

        toast(AppTexts.nointerneterr,
            gravity: ToastGravity.CENTER, bgColor: AppColors.appLightRed);
      }
    } on SocketException catch (_) {
      Navigator.of(context).pop();

      toast(AppTexts.nointerneterr,
          gravity: ToastGravity.CENTER, bgColor: AppColors.appLightRed);
    }
  }

  addbankacc({bankname, accno, accname, pass}) async {
    pass = " ";
    functionfile.onHorizontalLoading1(context);
    var theinternet = await functionfile.isInternet();
    var theinternet2 = await functionfile.checkInternetAccess();

    try {
      if (theinternet && theinternet2) {
        if (bankname==null || bankname.isEmpty) {
          Navigator.of(context).pop();
          toast('Please choose a bank',
              gravity: ToastGravity.CENTER, bgColor: AppColors.appLightRed);
        } else if (accno==null||accno.isEmpty) {
          Navigator.of(context).pop();
          toast('Please enter account number',
              gravity: ToastGravity.CENTER, bgColor: AppColors.appLightRed);
        } else if (accname==null||accname.isEmpty) {
          Navigator.of(context).pop();
          toast('Please enter account number',
              gravity: ToastGravity.CENTER, bgColor: AppColors.appLightRed);
        }
        //  else if (pass.isEmpty) {
        //   Navigator.of(context).pop();
        //   toast('Please enter password',gravity:ToastGravity.CENTER,bgColor: AppColors.appLightRed);
        // }
        else {
          var sendtbnkid = " ";
          var getbanks = await bankapi.psbanklist();
          var thetotal = getbanks.banks.length;
          var i = 0;
          for (i = 0; i < thetotal; i++) {
            if (getbanks.banks[i].bankname == bankname) {
              sendtbnkid = getbanks.banks[i].bankcode;
              break;
            }
          }

          var v = await bankapi
              .useraddbank(
                  accbank: bankname,
                  accname: accname,
                  accno: accno,
                  bankcode: sendtbnkid,
                  pass: pass)
              .timeout(Duration(seconds: 20), onTimeout: () {
            Navigator.of(context).pop();
            toast(AppTexts.nointerneterr,
                gravity: ToastGravity.CENTER, bgColor: AppColors.appLightRed);
            return null;
          });

          if (v != null) {
            if (v.status == true) {
              Navigator.of(context).pop();
                 Navigator.of(context).pop();
              toast("Bank added Successfully",
                  gravity: ToastGravity.CENTER,
                  bgColor: AppColors.appDark_parrot_green);
                  allbanks = [];
                        listOfCategory=[];
                  userInfo();
            } else {
              Navigator.of(context).pop();

              toast(v.msg,
                  gravity: ToastGravity.CENTER, bgColor: AppColors.appLightRed);
            }
          } else {
            Navigator.of(context).pop();

            toast(AppTexts.nointerneterr,
                gravity: ToastGravity.CENTER, bgColor: AppColors.appLightRed);
          }
        }
      } else {
        Navigator.of(context).pop();

        toast(AppTexts.nointerneterr,
            gravity: ToastGravity.CENTER, bgColor: AppColors.appLightRed);
      }
    } on SocketException catch (_) {
      Navigator.of(context).pop();

      toast(AppTexts.nointerneterr,
          gravity: ToastGravity.CENTER, bgColor: AppColors.appLightRed);
    }
  }
}
