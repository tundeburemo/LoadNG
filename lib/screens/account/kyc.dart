import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:loadng/styles/AppFontSizes.dart';
import 'package:loadng/styles/AppColors.dart';
import 'package:loadng/widgets/loginScreen.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:loadng/services/apis/account.dart';
import 'package:flutter/rendering.dart';
import 'package:loadng/utils/customFunction.dart';
import 'package:loadng/locator.dart';
import 'dart:io';
import 'package:loadng/services/apis/bank.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:convert';
import 'package:loadng/styles/AppText.dart';


var functionfile = locator<CustomFunction>();
var bankapi = locator<BankApi>();
var accountapi = locator<AccountApi>();

// ignore: must_be_immutable
class KycForm extends StatefulWidget {
  static var tag = "/kycform";
  KycForm({Key key});
  @override
  KycFormState createState() => KycFormState();
}

class KycFormState extends State<KycForm> {
  TextEditingController _bvn,
      _facebook,
      _twitter,
      _insta,
      _telegram,
      _email,
      _address,_fname,_lname,_pno,_accno;
  List<String> listOfCategory = [];
  String bankdropdownNames;
   DateTime _selectedDate;
  var allcountry = <String>["Nigeria", "Ghana"];
  var allstate = <String>[
    "ABUJA FCT",
    "ABIA",
    "ADAMAWA",
    "AKWA IBOM",
    "ANAMBRA",
    "BAUCHI",
    "BAYELSA",
    "BENUE",
    "BORNO",
    "CROSS RIVER",
    "DELTA",
    "EBONYI",
    "EDO",
    "EKITI",
    "ENUGU",
    "GOMBE",
    "IMO",
    "JIGAWA",
    "KADUNA",
    "KANO",
    "KATSINA",
    "KEBBI",
    "KOGI",
    "KWARA",
    "LAGOS",
    "NASSARAWA",
    "NIGER",
    "OGUN",
    "ONDO",
    "OSUN",
    "OYO",
    "PLATEAU",
    "RIVERS",
    "SOKOTO",
    "TARABA",
    "YOBE",
    "ZAMFARA"
  ];
  var allbiztype = <String>["Individual", "Organization"];
  var allregtype = <String>[
    "National ID Card",
    "Driver License",
    "Voters Card",
    "International Passport"
  ];

  var biztype,
      regtype,
      passimgname,
      regimgname,
      hregimgname,
      bizccimgname;
  String statedropdownNames,
      countrydropdownNames,
      bizdropdownNames,
      regdropdownNames;

  File _image;
  File _image2;
  File _image3;
  File _image4;
  Future file;
  Future file2;
  Future file3;
  Future file4;


  final picker = ImagePicker();
  String hregimage = "";
  String passimage = "";
  String regimage = "";
  String bizccimage = "";


  PickedFile tmpFile;
  PickedFile tmpFile2;
  PickedFile tmpFile3;
  PickedFile tmpFile4;


  String errMessage = 'Error Uploading Image';

  Future getImage() async {
    file = picker.getImage(source: ImageSource.gallery);
    final pickedFile = await file;

    setState(() {
      _image = File(pickedFile.path);
    });
  }

    Future getImage2() async {
    file2 = picker.getImage(source: ImageSource.gallery);
    final pickedFile = await file2;

    setState(() {
      _image2 = File(pickedFile.path);
    });
  }

    Future getImage3() async {
    file3 = picker.getImage(source: ImageSource.gallery);
    final pickedFile = await file3;

    setState(() {
      _image3 = File(pickedFile.path);
    });
  }

      Future getImage4() async {
    file4 = picker.getImage(source: ImageSource.gallery);
    final pickedFile = await file4;

    setState(() {
      _image4 = File(pickedFile.path);
    });
  }
 void _presentDatePicker(){
   showDatePicker(
     context: context, 
     initialDate: DateTime.now(), 
     firstDate: DateTime(1570), 
     lastDate: DateTime(2040)
     ).then((pickedDate) {
       if(pickedDate == null){
         return;
       }else{
         setState(() {
           _selectedDate = pickedDate;
         });
       }
     } );
 }

  Widget showImage() {
    return FutureBuilder<PickedFile>(
      future: file,
      builder: (BuildContext context, AsyncSnapshot<PickedFile> snapshot) {
        if (snapshot.connectionState == ConnectionState.done &&
            null != snapshot.data) {
          tmpFile = snapshot.data;
          var d = snapshot.data.readAsBytes();
          d.then((i) {
            passimage = base64Encode(i.cast<int>());
          });
          return Container(width: 100, height: 100, child: Image.file(_image));
        } else if (null != snapshot.error) {
          return const Text(
            'Error Picking Image',
            textAlign: TextAlign.center,
          );
        } else {
          return const Text(
            'No Image Selected',
            textAlign: TextAlign.center,
          );
        }
      },
    );
  }


  Widget showImage2() {
    return FutureBuilder<PickedFile>(
      future: file2,
      builder: (BuildContext context, AsyncSnapshot<PickedFile> snapshot) {
        if (snapshot.connectionState == ConnectionState.done &&
            null != snapshot.data) {
          tmpFile2 = snapshot.data;
          var d = snapshot.data.readAsBytes();
          d.then((i) {
            hregimage = base64Encode(i.cast<int>());
          });
          return Container(width: 100, height: 100, child: Image.file(_image2));
        } else if (null != snapshot.error) {
          return const Text(
            'Error Picking Image',
            textAlign: TextAlign.center,
          );
        } else {
          return const Text(
            'No Image Selected',
            textAlign: TextAlign.center,
          );
        }
      },
    );
  }

    Widget showImage3() {
    return FutureBuilder<PickedFile>(
      future: file3,
      builder: (BuildContext context, AsyncSnapshot<PickedFile> snapshot) {
        if (snapshot.connectionState == ConnectionState.done &&
            null != snapshot.data) {
          tmpFile3 = snapshot.data;
          var d = snapshot.data.readAsBytes();
          d.then((i) {
            regimage = base64Encode(i.cast<int>());
          });
          return Container(width: 100, height: 100, child: Image.file(_image3));
        } else if (null != snapshot.error) {
          return const Text(
            'Error Picking Image',
            textAlign: TextAlign.center,
          );
        } else {
          return const Text(
            'No Image Selected',
            textAlign: TextAlign.center,
          );
        }
      },
    );
  }
  
      Widget showImage4() {
    return FutureBuilder<PickedFile>(
      future: file4,
      builder: (BuildContext context, AsyncSnapshot<PickedFile> snapshot) {
        if (snapshot.connectionState == ConnectionState.done &&
            null != snapshot.data) {
          tmpFile4 = snapshot.data;
          var d = snapshot.data.readAsBytes();
          d.then((i) {
           bizccimage = base64Encode(i.cast<int>());
          });
          return Container(width: 100, height: 100, child: Image.file(_image4));
        } else if (null != snapshot.error) {
          return const Text(
            'Error Picking Image',
            textAlign: TextAlign.center,
          );
        } else {
          return const Text(
            'No Image Selected',
            textAlign: TextAlign.center,
          );
        }
      },
    );
  }
  @override
  Widget build(BuildContext context) {
    final next = MaterialButton(
      minWidth: MediaQuery.of(context).size.width,
      onPressed: getImage,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Text(
        'Choose',
        style: TextStyle(
          color: Colors.black38,
          fontWeight: FontWeight.w800,
          letterSpacing: 4,
        ),
      ),
      color: Color(0xfff1f4fb),
      height: 45,
    );
        final next2 = MaterialButton(
      minWidth: MediaQuery.of(context).size.width,
      onPressed: getImage2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Text(
        'Choose',
        style: TextStyle(
          color: Colors.black38,
          fontWeight: FontWeight.w800,
          letterSpacing: 4,
        ),
      ),
      color: Color(0xfff1f4fb),
      height: 45,
    );
        final next3 = MaterialButton(
      minWidth: MediaQuery.of(context).size.width,
      onPressed: getImage3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Text(
        'Choose',
        style: TextStyle(
          color: Colors.black38,
          fontWeight: FontWeight.w800,
          letterSpacing: 4,
        ),
      ),
      color: Color(0xfff1f4fb),
      height: 45,
    );
            final next4 = MaterialButton(
      minWidth: MediaQuery.of(context).size.width,
      onPressed: getImage4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Text(
        'Choose',
        style: TextStyle(
          color: Colors.black38,
          fontWeight: FontWeight.w800,
          letterSpacing: 4,
        ),
      ),
      color: Color(0xfff1f4fb),
      height: 45,
    );
    return Scaffold(
      appBar: appBar(context, "KYC form"),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              width: double.infinity,
              decoration: boxDecoration(
                  showShadow: true, radius: AppFontSize.spacing_standard),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  text("Enter your BVN", textColor: AppColors.shadowdarkblack2),
                  formField(context, "BVN number",
                      controller: _bvn,
                      textcolor: AppColors.shadowdarkblack,
                      prefixIcon: Icons.receipt, ontap: () {
                    FocusScopeNode currentFocus = FocusScope.of(context);
                    if (!currentFocus.hasPrimaryFocus) {
                      currentFocus.unfocus();
                    }
                  }).paddingTop(AppFontSize.spacing_standard),

                        text("Enter your first name", textColor: AppColors.shadowdarkblack2),
                  formField(context, "First name",
                      controller: _fname,
                      textcolor: AppColors.shadowdarkblack,
                      prefixIcon: Icons.receipt, ontap: () {
                    FocusScopeNode currentFocus = FocusScope.of(context);
                    if (!currentFocus.hasPrimaryFocus) {
                      currentFocus.unfocus();
                    }
                  }).paddingTop(AppFontSize.spacing_standard),

                  
                        text("Enter your last name", textColor: AppColors.shadowdarkblack2),
                  formField(context, "Last name",
                      controller: _lname,
                      textcolor: AppColors.shadowdarkblack,
                      prefixIcon: Icons.receipt, ontap: () {
                    FocusScopeNode currentFocus = FocusScope.of(context);
                    if (!currentFocus.hasPrimaryFocus) {
                      currentFocus.unfocus();
                    }
                  }).paddingTop(AppFontSize.spacing_standard),

             text("Enter your phone number", textColor: AppColors.shadowdarkblack2),
                  formField(context, "Phone number",
                      controller: _pno,
                      textcolor: AppColors.shadowdarkblack,
                      prefixIcon: Icons.receipt, ontap: () {
                    FocusScopeNode currentFocus = FocusScope.of(context);
                    if (!currentFocus.hasPrimaryFocus) {
                      currentFocus.unfocus();
                    }
                  }).paddingTop(AppFontSize.spacing_standard),
        
           
             text("Choose bank name", textColor: AppColors.shadowdarkblack2),
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
                                      setState(() {
                                        toast(newValue);
                                        bankdropdownNames = newValue;
                                      });

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

                        text("Enter your account number", textColor: AppColors.shadowdarkblack2),
                  formField(context, "Account number",
                      controller: _accno,
                      textcolor: AppColors.shadowdarkblack,
                      prefixIcon: Icons.receipt, ontap: () {
                    FocusScopeNode currentFocus = FocusScope.of(context);
                    if (!currentFocus.hasPrimaryFocus) {
                      currentFocus.unfocus();
                    }
                  }).paddingTop(AppFontSize.spacing_standard),

Container(
              //padding: EdgeInsets.all(5.0),
              child: Card(
                child: Container(
                  padding: EdgeInsets.all(20.0),
                  child: Column(
                    
                    children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                        Text("Date of birth", style: TextStyle(color: Colors.grey, fontSize: 14.0),),
                        Text(_selectedDate == null ? "No date Picked": DateFormat.yMd().format(_selectedDate), style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.bold),)
                      ],),
                      Row(children: <Widget>[
                        Container(
                          decoration: BoxDecoration(color:AppColors.shadowdarkblack, borderRadius: BorderRadius.circular(40.0)),
                          child: FlatButton(onPressed: () => _presentDatePicker(), child: Text("PICK", style: TextStyle(color: Colors.white, fontSize: 14.0),)))
                      ],)
                    ],)
                  ],),
                ),
              ),
            ),
            
                  text("Facebook Link(optional)",
                      textColor: AppColors.shadowdarkblack2),
                  formField(context, "Facebook Profile link",
                      controller: _facebook,
                      textcolor: AppColors.shadowdarkblack,
                      prefixIcon: Icons.receipt, ontap: () {
                    FocusScopeNode currentFocus = FocusScope.of(context);
                    if (!currentFocus.hasPrimaryFocus) {
                      currentFocus.unfocus();
                    }
                  }).paddingTop(AppFontSize.spacing_standard),
                  // text("Twitter Link(optional)",
                  //     textColor: AppColors.shadowdarkblack2),
                  // formField(context, "Twitter Profile link",
                  //     controller: _twitter,
                  //     textcolor: AppColors.shadowdarkblack,
                  //     prefixIcon: Icons.receipt, ontap: () {
                  //   FocusScopeNode currentFocus = FocusScope.of(context);
                  //   if (!currentFocus.hasPrimaryFocus) {
                  //     currentFocus.unfocus();
                  //   }
                  // }).paddingTop(AppFontSize.spacing_standard),
                  // text("Instagram Link(optional)",
                  //     textColor: AppColors.shadowdarkblack2),
                  // formField(context, "Instagram Profile link",
                  //     controller: _insta,
                  //     textcolor: AppColors.shadowdarkblack,
                  //     prefixIcon: Icons.receipt, ontap: () {
                  //   FocusScopeNode currentFocus = FocusScope.of(context);
                  //   if (!currentFocus.hasPrimaryFocus) {
                  //     currentFocus.unfocus();
                  //   }
                  // }).paddingTop(AppFontSize.spacing_standard),
                  // text("Telegram Link(optional)",
                  //     textColor: AppColors.shadowdarkblack2),
                  // formField(context, "Telegram Profile link",
                  //     controller: _telegram,
                  //     textcolor: AppColors.shadowdarkblack,
                  //     prefixIcon: Icons.receipt, ontap: () {
                  //   FocusScopeNode currentFocus = FocusScope.of(context);
                  //   if (!currentFocus.hasPrimaryFocus) {
                  //     currentFocus.unfocus();
                  //   }
                  // }).paddingTop(AppFontSize.spacing_standard),

                  text("Email", textColor: AppColors.shadowdarkblack2),
                  formField(context, "Email",
                      controller: _email,
                      textcolor: AppColors.shadowdarkblack,
                      prefixIcon: Icons.receipt, ontap: () {
                    FocusScopeNode currentFocus = FocusScope.of(context);
                    if (!currentFocus.hasPrimaryFocus) {
                      currentFocus.unfocus();
                    }
                  }).paddingTop(AppFontSize.spacing_standard),
                  text("Residential Address", textColor: AppColors.shadowdarkblack2),
                  formField(context, "Residential Address",
                  maxLine: 4,
                  suffixIcon: null,
                      controller: _address,
                      textcolor: AppColors.shadowdarkblack,
                      prefixIcon: Icons.receipt,
                       ontap: () {
                    FocusScopeNode currentFocus = FocusScope.of(context);
                    if (!currentFocus.hasPrimaryFocus) {
                      currentFocus.unfocus();
                    }
                  }).paddingTop(AppFontSize.spacing_standard),
                  text("State of Origin",
                      textColor: AppColors.shadowdarkblack2,
                      fontFamily: AppFontSize.cooperaterunded,
                      fontSize: AppFontSize.textSizeMedium),
                  Material(
                      color: AppColors.t1_view_color,
                      child: DropdownButton(
                        isExpanded: true,
                        value: statedropdownNames,
                        style: boldTextStyle(),
                        icon: Icon(
                          Icons.keyboard_arrow_down,
                          color: AppColors.realblack,
                        ),
                        underline: 0.height,
                        onChanged: (newValue) {
                          setState(() {
                            toast(newValue);
                            statedropdownNames = newValue;
                          });
                        },
                        items: allstate.map((statelist) {
                          return DropdownMenuItem(
                            child: Text(statelist, style: primaryTextStyle())
                                .paddingLeft(8),
                            value: statelist,
                          );
                        }).toList(),
                      )).paddingTop(AppFontSize.spacing_standard),
                  text("Country",
                      textColor: AppColors.shadowdarkblack2,
                      fontFamily: AppFontSize.cooperaterunded,
                      fontSize: AppFontSize.textSizeMedium),
                  Material(
                      color: AppColors.t1_view_color,
                      child: DropdownButton(
                        isExpanded: true,
                        value: countrydropdownNames,
                        style: boldTextStyle(),
                        icon: Icon(
                          Icons.keyboard_arrow_down,
                          color: AppColors.realblack,
                        ),
                        underline: 0.height,
                        onChanged: (newValue) {
                          setState(() {
                            toast(newValue);
                            countrydropdownNames = newValue;
                          });
                        },
                        items: allcountry.map((countrylist) {
                          return DropdownMenuItem(
                            child: Text(countrylist, style: primaryTextStyle())
                                .paddingLeft(8),
                            value: countrylist,
                          );
                        }).toList(),
                      )).paddingTop(AppFontSize.spacing_standard),
                  text("Usage Type",
                      textColor: AppColors.shadowdarkblack2,
                      fontFamily: AppFontSize.cooperaterunded,
                      fontSize: AppFontSize.textSizeMedium),
                  Material(
                      color: AppColors.t1_view_color,
                      child: DropdownButton(
                        isExpanded: true,
                        value: bizdropdownNames,
                        style: boldTextStyle(),
                        icon: Icon(
                          Icons.keyboard_arrow_down,
                          color: AppColors.realblack,
                        ),
                        underline: 0.height,
                        onChanged: (newValue) {
                          setState(() {
                            toast(newValue);
                            bizdropdownNames = newValue;
                          });
                          if (newValue == "Individual") {
                            // 1
                            setState(() {
                              biztype = 1;
                            });
                          } else {
                            setState(() {
                              biztype = 2;
                            });
                          }
                        },
                        items: allbiztype.map((bizlist) {
                          return DropdownMenuItem(
                            child: Text(bizlist, style: primaryTextStyle())
                                .paddingLeft(8),
                            value: bizlist,
                          );
                        }).toList(),
                      )).paddingTop(AppFontSize.spacing_standard),
                  text("Regulation Type",
                      textColor: AppColors.shadowdarkblack2,
                      fontFamily: AppFontSize.cooperaterunded,
                      fontSize: AppFontSize.textSizeMedium),
                  Material(
                      color: AppColors.t1_view_color,
                      child: DropdownButton(
                        isExpanded: true,
                        value: regdropdownNames,
                        style: boldTextStyle(),
                        icon: Icon(
                          Icons.keyboard_arrow_down,
                          color: AppColors.realblack,
                        ),
                        underline: 0.height,
                        onChanged: (newValue) {
                          setState(() {
                            toast(newValue);
                            regdropdownNames = newValue;
                          });

                          if (newValue == "National ID Card") {
                            setState(() {
                              regtype = 1;
                            });
                          } else if (newValue == "Driver License") {
                            setState(() {
                              regtype = 2;
                            });
                          } else if (newValue == "Voters Card") {
                            setState(() {
                              regtype = 3;
                            });
                          } else if (newValue == "International Passport") {
                            setState(() {
                              regtype = 4;
                            });
                          } else {
                            setState(() {
                              regtype = 0;
                            });
                          }
                        },
                        items: allregtype.map((reglist) {
                          return DropdownMenuItem(
                            child: Text(reglist, style: primaryTextStyle())
                                .paddingLeft(8),
                            value: reglist,
                          );
                        }).toList(),
                      )).paddingTop(AppFontSize.spacing_standard),
                       SizedBox(height: 5),
                  text("Select your passport",
                      textColor: AppColors.shadowdarkblack2,
                      fontFamily: AppFontSize.cooperaterunded,
                      fontSize: AppFontSize.textSizeMedium),
                  Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(bottom: 5),
                        child: next,
                      ),
                      showImage()
                    ],
                  ),
                  SizedBox(height: 5),
                  text("Front of Regulatory ID Card",
                      textColor: AppColors.shadowdarkblack2,
                      fontFamily: AppFontSize.cooperaterunded,
                      fontSize: AppFontSize.textSizeMedium),
                  Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(bottom: 5),
                        child: next2,
                      ),
                      showImage2()
                    ], 
                  ),
                  SizedBox(height: 5), 
                  text("Upload picture of you holding the ID Card",
                      textColor: AppColors.shadowdarkblack2,
                      fontFamily: AppFontSize.cooperaterunded,
                      fontSize: AppFontSize.textSizeMedium,maxLine: 2),
                  Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(bottom: 5),
                        child: next3,
                      ),
                      showImage3()
                    ],
                  ),
                  Offstage(
                      offstage:
                          (biztype == 1 || biztype == 0 || biztype == null),
                      child: Column(children: <Widget>[
                        SizedBox(height: 5),
                        text("Business CC image",
                            textColor: AppColors.shadowdarkblack2,
                            fontFamily: AppFontSize.cooperaterunded,
                            fontSize: AppFontSize.textSizeMedium),
                        Column(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(bottom: 5),
                              child: next4,
                            ),
                            showImage4()
                          ],
                        ),
                      ])),
                  SizedBox(height: 5),
                  SizedBox(
                    width: double.infinity,
                    child: MaterialButton(
                        padding: EdgeInsets.only(
                            top: AppFontSize.spacing_standard_new,
                            bottom: AppFontSize.spacing_standard_new),
                        child: text("Submit Form",
                            textColor: Colors.white,
                            fontFamily: AppFontSize.fontMedium),
                        shape: RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(
                                AppFontSize.spacing_standard)),
                        color: AppColors.appColorPrimary,
                        onPressed: () {
if(tmpFile!=null){
   passimgname=tmpFile.path.split('/').last;
}else{
  passimgname=" ";
}
if(tmpFile3!=null){
  regimgname=tmpFile3.path.split('/').last;
}else{
  regimgname=" ";
}
if(tmpFile2!=null){
    hregimgname=tmpFile2.path.split('/').last;
}else{
  hregimgname=" ";
}
if(tmpFile4!=null){
  bizccimgname=tmpFile4.path.split('/').last;
}else{
  bizccimgname=" ";
}
      
     
    

                              submitkyc(
                                  bvn: _bvn.text,
                                  facebook: _facebook.text,
                                  twitter: _twitter.text,
                                  insta: _insta.text,
                                  telegram: _telegram.text,
                                  email: _email.text,
                                  country: countrydropdownNames,
                                  state: statedropdownNames,
                                  address: _address.text,
                                  biztype: biztype,
                                  regtype: regtype,
                                  passimage: passimage,
                                  passimgname: passimgname,
                                  regimage: regimage,
                                  regimgname: regimgname,
                                  hregimage: hregimage,
                                  hregimgname: hregimgname,
                                  bizccimage: bizccimage,
                                  bizccimgname: bizccimgname,accbank:bankdropdownNames,accno:_accno.text,lname:_lname.text,fname:_fname.text,phoneno:_pno.text,dob:(_selectedDate==null?null :DateFormat.yMd().format(_selectedDate)));
                        
                            },
                  ).paddingTop(AppFontSize.spacing_standard_new)
                  )],
              ).paddingAll(AppFontSize.spacing_standard_new),
            ).paddingAll(AppFontSize.spacing_standard_new)
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    _bvn = TextEditingController();
    _facebook = TextEditingController();
    _twitter = TextEditingController();
    _insta = TextEditingController();
    _telegram = TextEditingController();
    _email = TextEditingController();
    _address = TextEditingController();
    _lname = TextEditingController();
    _pno = TextEditingController();
    _fname = TextEditingController();
    _accno = TextEditingController();
userInfo();
    super.initState();
  }

    Future<void> userInfo() async {
    // paytscak
var getbanks = await bankapi.psbanklist();
var thetotal = getbanks.banks.length;
var i=0;
for(i=0;i<thetotal;i++){
  if(!listOfCategory.contains(getbanks.banks[i].bankname)){
if(mounted){
      setState(() {
    listOfCategory.add(getbanks.banks[i].bankname);
  });
}
  }
}

    }

  @override
  void dispose() {
    _bvn.clear();
    _facebook.clear();
    _twitter.clear();
    _insta.clear();
    _telegram.clear();
    _email.clear();
    _address.clear();
    super.dispose();
  }

  submitkyc(
      {bvn,
      facebook,
      twitter,
      insta,
      telegram,
      email,
      country,
      state,
      address,
      biztype,
      regtype,
      passimage,
      passimgname,
      regimage,
      regimgname,
      hregimage,
      hregimgname,
      bizccimage,
      bizccimgname,accbank,accno,lname,fname,phoneno,dob}) async {
telegram=" ";
insta=" ";
twitter=" ";

    functionfile.onHorizontalLoading1(context);
    var theinternet = await functionfile.isInternet();
    var theinternet2 = await functionfile.checkInternetAccess();

    try {
      if (theinternet && theinternet2) {
        if (bvn.isEmpty) {
          Navigator.of(context).pop();
          toast('Please input your BVN',
              gravity: ToastGravity.CENTER, bgColor: AppColors.appLightRed);
        } else if (email.isEmpty) {
          Navigator.of(context).pop();
          toast('Please input an email address',
              gravity: ToastGravity.CENTER, bgColor: AppColors.appLightRed);
        } else if (accbank.isEmpty) {
          Navigator.of(context).pop();
          toast('Please select a bank name',
              gravity: ToastGravity.CENTER, bgColor: AppColors.appLightRed);
        } else if (accno.isEmpty) {
          Navigator.of(context).pop();
          toast('Please input account number',
              gravity: ToastGravity.CENTER, bgColor: AppColors.appLightRed);
        } else if (lname.isEmpty) {
          Navigator.of(context).pop();
          toast('Please input last name',
              gravity: ToastGravity.CENTER, bgColor: AppColors.appLightRed);
        } else if (fname.isEmpty) {
          Navigator.of(context).pop();
          toast('Please input first name',
              gravity: ToastGravity.CENTER, bgColor: AppColors.appLightRed);
        } else if (dob.isEmpty) {
          Navigator.of(context).pop();
          toast('Please input date of birth',
              gravity: ToastGravity.CENTER, bgColor: AppColors.appLightRed);
        } else if (country.isEmpty) {
          Navigator.of(context).pop();
          toast('Please select your country',
              gravity: ToastGravity.CENTER, bgColor: AppColors.appLightRed);
        } else if (state.isEmpty) {
          Navigator.of(context).pop();
          toast('Please select your state',
              gravity: ToastGravity.CENTER, bgColor: AppColors.appLightRed);
        } else if (address.isEmpty) {
          Navigator.of(context).pop();
          toast('Input your address please',
              gravity: ToastGravity.CENTER, bgColor: AppColors.appLightRed);
        } else if (biztype==null||biztype==0) {
          Navigator.of(context).pop();
          toast('Please choose usage type',
              gravity: ToastGravity.CENTER, bgColor: AppColors.appLightRed);
        } else if (regtype==null||regtype==0) {
          Navigator.of(context).pop();
          toast('Please select regulatory type',
              gravity: ToastGravity.CENTER, bgColor: AppColors.appLightRed);
        } else if (passimage.isEmpty) {
          Navigator.of(context).pop();
          toast('Passport can not be empty',
              gravity: ToastGravity.CENTER, bgColor: AppColors.appLightRed);
        } else if (passimgname.isEmpty) {
          Navigator.of(context).pop();
          toast('Passport can not be empty',
              gravity: ToastGravity.CENTER, bgColor: AppColors.appLightRed);
        } else if (regimage.isEmpty) {
          Navigator.of(context).pop();
          toast('Regulatory image can not be empty',
              gravity: ToastGravity.CENTER, bgColor: AppColors.appLightRed);
        } else if (regimgname.isEmpty) {
          Navigator.of(context).pop();
          toast('Regulatory image can not be empty',
              gravity: ToastGravity.CENTER, bgColor: AppColors.appLightRed);
        } else if (hregimage.isEmpty) {
          Navigator.of(context).pop();
          toast('Image of you holding the regulatory image is needed',
              gravity: ToastGravity.CENTER, bgColor: AppColors.appLightRed);
        } else if (hregimgname.isEmpty) {
          Navigator.of(context).pop();
          toast('Image of you holding the regulatory image is needed',
              gravity: ToastGravity.CENTER, bgColor: AppColors.appLightRed);
        } else if (biztype == 2 && bizccimage.isEmpty) {
          Navigator.of(context).pop();
          toast('Business CAC Image is needed',
              gravity: ToastGravity.CENTER, bgColor: AppColors.appLightRed);
        } else if (biztype == 2 && bizccimgname.isEmpty) {
          Navigator.of(context).pop();
          toast('Business CAC Image is needed',
              gravity: ToastGravity.CENTER, bgColor: AppColors.appLightRed);
        } else {
                    var sendtbnkid=" ";
var getbanks = await bankapi.psbanklist();
var thetotal = getbanks.banks.length;
var i=0;
for(i=0;i<thetotal;i++){
    if(getbanks.banks[i].bankname==accbank){
    sendtbnkid= getbanks.banks[i].bankcode;
    break;
  }
}
var accbankjoin="$sendtbnkid^$accbank";
          var v = await accountapi
              .useraddkyc(
                  bvn: bvn,
                  facebook: facebook,
                  twitter: twitter,
                  insta: insta,
                  telegram: telegram,
                  email: email,
                  country: country,
                  state: state,
                  address: address,
                  biztype: biztype,
                  regtype: regtype,
                  passimage: passimage,
                  passimgname: passimgname,
                  regimage: regimage,
                  regimgname: regimgname,
                  hregimage: hregimage,
                  hregimgname: hregimgname,
                  bizccimage: bizccimage,
                  bizccimgname: bizccimgname,accbank:accbankjoin,accno:accno,lname:lname,fname:fname,phoneno:phoneno,dob:dob)
              .timeout(Duration(seconds: 40), onTimeout: () {
            Navigator.of(context).pop();
            toast(AppTexts.nointerneterr,
                gravity: ToastGravity.CENTER, bgColor: AppColors.appLightRed);
            return null;
          });

          if (v != null) {
            if (v.status == true) {
              Navigator.of(context).pop();
              toast(
                  "Form Submitted Successfully, kindly wait for it to be processed by the system",
                  gravity: ToastGravity.CENTER,
                  bgColor: AppColors.appDark_parrot_green);
              Navigator.of(context).pushNamed('/userdashboard');
            } else { 
              Navigator.of(context).pop();
              toast(v.msg,
                  gravity: ToastGravity.CENTER, bgColor: AppColors.appLightRed);
            }
          } else {
            Navigator.of(context).pop();
            toast(AppTexts.errorinporcess,
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
