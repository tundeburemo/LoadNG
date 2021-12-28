
import 'package:flutter/material.dart';
import 'package:loadng/styles/AppFontSizes.dart';
import 'package:loadng/styles/AppColors.dart';
import 'package:loadng/widgets/loginScreen.dart';
import 'package:nb_utils/nb_utils.dart';
import "package:loadng/model/system/route_argument.dart";
import 'package:qr_flutter/qr_flutter.dart';
import 'package:flutter/services.dart';
import 'package:flutter/rendering.dart';
import 'package:loadng/utils/customFunction.dart';
import 'package:loadng/locator.dart';
import 'dart:io';
import 'package:loadng/services/apis/bank.dart';
import 'package:loadng/services/apis/sell.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:convert';
import 'package:loadng/styles/AppText.dart';



var sellapi = locator<SellApi>();
var functionfile = locator<CustomFunction>();
var bankapi = locator<BankApi>();



// ignore: must_be_immutable
class SellNewCoins extends StatefulWidget {
  static var tag = "/SellNewCoins";
String name;
String image;
String rate;
int thecolors;
String thetype; 
String address;
 final RouteArgument routeArgument;

  SellNewCoins({Key key,@required this.routeArgument }) {
    name= this.routeArgument.argumentsList[0] as String;
    image=this.routeArgument.argumentsList[1] as String;
    rate =this.routeArgument.argumentsList[2] as String;
    thecolors =this.routeArgument.argumentsList[3];
    thetype=this.routeArgument.argumentsList[4] as String;
    address=this.routeArgument.argumentsList[5] as String;
  }
  @override
  SellNewCoinsState createState() => SellNewCoinsState();
}


class SellNewCoinsState extends State<SellNewCoins> {
      TextEditingController _usdval,_nairaval,_thash;
 var allbanks=<String>[];
    String dropdownNames;

 File _image;
  Future file;
  final picker = ImagePicker();
  String base64Image="";
  PickedFile tmpFile;
  String errMessage = 'Error Uploading Image';
 
  Future getImage() async {
    file = picker.getImage(source: ImageSource.gallery);
    final pickedFile = await file;

    setState(() {
      _image = File(pickedFile.path);
    });
  }

    Widget showImage() {
    return FutureBuilder<PickedFile>(
      future: file,
      builder: (BuildContext context, AsyncSnapshot<PickedFile> snapshot) {
        if (snapshot.connectionState == ConnectionState.done &&
            null != snapshot.data) {
          tmpFile = snapshot.data;
          var d = snapshot.data.readAsBytes();
          d.then((i){
          base64Image = base64Encode(i.cast<int>());
          });
          return  Container(
             width:100,
             height:100,
             child: Image.file(_image));
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
    return Scaffold(
      appBar: appBar(context,"Sell ${widget.name}"), 
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
                 text("Send any amount of ${widget.name} to the wallet address below. Every transaction generates an Hash, so copy the hash and fill it in below, also upload the screenshot of your transaction and submit.",textColor: AppColors.shadowdarkblack2,fontSize: AppFontSize.textSizeSMedium,maxLine: 8,isCentered: true).paddingAll(AppFontSize.spacing_standard_new),
            Container(
              width: double.infinity,
              margin: EdgeInsets.all(AppFontSize.spacing_standard_new),
              decoration: boxDecoration(showShadow: true,bgColor: Color(0xfff1f4fb)),
              child: Column(
                children: <Widget>[
                  Container(
                    decoration: boxDecoration(showShadow: true,bgColor: Color(0xffBBd2fc),radius: AppFontSize.spacing_standard),
                    child: Image.asset(widget.image,width: 24,height: 24,).paddingAll(AppFontSize.spacing_standard_new),
                  ),
                  toolBarTitle("${widget.rate}").paddingTop(AppFontSize.spacing_standard_new),
                  text("${widget.name}",fontFamily: AppFontSize.fontMedium).paddingTop(AppFontSize.spacing_standard),
                ],
              ).paddingAll(AppFontSize.spacing_standard_new),
            ),
       

            text("Wallet Address(Tap To Copy)",textColor: AppColors.shadowdarkblack2,fontSize: AppFontSize.textSizeSMedium),
GestureDetector(
  onTap: () {
                              Clipboard.setData(
                                new ClipboardData(
                                    text: '${widget.address}'),
                              );
                              toast("${widget.address} Address Copied to Clipboard");
                            },
  child: Container(
    color: AppColors.t12_edittext_background,
  child: Text("${widget.address}",style:TextStyle(color: AppColors.shadowdarkblack2,fontSize: 15.0),maxLines: 3,softWrap: true,textAlign: TextAlign.center,).paddingAll(10))),
                Container(
              width: double.infinity,
              margin: EdgeInsets.all(AppFontSize.spacing_standard_new),
              decoration: boxDecoration(showShadow: true,bgColor: Color(0xfff1f4fb)),
              child: Column(
                children: <Widget>[
                  Container(
                        decoration: boxDecoration(showShadow: true,bgColor: Color(0xfff1f4fb),radius: AppFontSize.spacing_standard),
                    child:
                     QrImage(
  data: "${widget.address}",
  version: QrVersions.auto,
  size: 200.0,
),
                  ),
                ],
              ).paddingAll(AppFontSize.spacing_standard_new),
            ),
            Container(
              width: double.infinity,
              decoration: boxDecoration(showShadow: true,radius: AppFontSize.spacing_standard), 
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  text("Transfer Hash",textColor: AppColors.shadowdarkblack2),
                  formField(context,"Transaction hash",controller: _thash,textcolor:AppColors.shadowdarkblack, prefixIcon: Icons.receipt, ontap: (){
                                    if(_usdval.text.isNotEmpty&&_usdval.text!=' '&&_usdval.text!=''){
                                _nairaval.text=(double.parse(widget.rate) * double.parse(_usdval.text)).toString();
                                    }
                                 FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
                                  }).paddingTop(AppFontSize.spacing_standard),
                  text("Amount Sent(USD)",textColor: AppColors.shadowdarkblack2).paddingTop(AppFontSize.spacing_standard),
                  formField(
                                  context,
                                  "USD VALUE",
                                  isPassword: false,
                                  controller: _usdval,
                                  prefixIcon: Icons.attach_money,
                                  textcolor:AppColors.shadowdarkblack,
                                  ontap: (){
                                    if(_usdval.text.isNotEmpty&&_usdval.text!=' '&&_usdval.text!=''){
                                _nairaval.text=(double.parse(widget.rate) * double.parse(_usdval.text)).toString();
                                    }
                                 FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
                                  }
                                  // fontSize: AppFontSize.textSizeNormal,
                                ),
                                SizedBox(height:5),
                                     text("Select Image",
                                    textColor: AppColors.shadowdarkblack2,
                                    fontFamily: AppFontSize.cooperaterunded,fontSize: AppFontSize.textSizeMedium),
                                     Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(bottom:5),
              child: next,
            ),
          showImage()
          ],
        ),
                                SizedBox(height:5),
                                 text("Account to pay",
                                    textColor: AppColors.shadowdarkblack2,
                                    fontFamily: AppFontSize.cooperaterunded,fontSize: AppFontSize.textSizeMedium),
                                 Material(
                                       color:AppColors.t1_view_color,
                  child: DropdownButton(
                    isExpanded: true,
                    // dropdownColor: AppColors.appWhite,
                    value: dropdownNames,
                    style: boldTextStyle(),
                    icon: Icon(
                      Icons.keyboard_arrow_down,
                      color: AppColors.realblack,
                    ),
                    underline: 0.height,
                    onChanged: (newValue) {
                      setState(() {
                        toast(newValue);
                        dropdownNames = newValue;
                                    if(_usdval.text.isNotEmpty&&_usdval.text!=' '&&_usdval.text!=''){
                                _nairaval.text=(double.parse(widget.rate) * double.parse(_usdval.text)).toString();
                                    }

                      });
                    },
                    items: allbanks.map((category) {
                      return DropdownMenuItem(
                        child: Text(category, style: primaryTextStyle()).paddingLeft(8),
                        value: category,
                      );
                    }).toList(),
                  )).paddingTop(AppFontSize.spacing_standard),
                                                
                                                 SizedBox(height:5),         
                                                          Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: <Widget>[   text("Naira Value",
                                    textColor: AppColors.shadowdarkblack2,
                                    fontFamily: AppFontSize.cooperaterunded,fontSize: AppFontSize.textSizeMedium),
                                    text("(₦)",
                                    textColor: AppColors.shadowdarkblack2,fontSize: AppFontSize.textSizeMedium),]),
                               Material(
                                       color:Color(0xfff1f4fb),
                  child:  EditText(
                                  textColor: AppColors.black,
                                  editable:true,
                                  isPassword: false,
                                  mController: _nairaval,
                                  fontSize: AppFontSize.textSizeXXLarge,
                                ),),
                  SizedBox(
                    width: double.infinity,
                    child: MaterialButton(
                      padding: EdgeInsets.only(top: AppFontSize.spacing_standard_new,bottom: AppFontSize.spacing_standard_new),
                      child: text("Place Order",
                          textColor: Colors.white, fontFamily: AppFontSize.fontMedium),
                      shape: RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(AppFontSize.spacing_standard)),
                      color: AppColors.appColorPrimary,
                      onPressed: () => {
                sellcoin(bankacc:dropdownNames,usdval:_usdval.text,hash:_thash.text,image:base64Image,imagename:tmpFile.path.split('/').last,trackid:widget.thetype)
                      }
                    ),
                  ).paddingTop(AppFontSize.spacing_standard_new)
                ],
              ).paddingAll(AppFontSize.spacing_standard_new),
            ).paddingAll(AppFontSize.spacing_standard_new)
          ],
        ),
      ),
    );
  }

      Future<void> userInfo() async {

var getbanks = await bankapi.userbanklist();
var thetotal = getbanks.banks.length;
var i=0;
for(i=0;i<thetotal;i++){
  if(!allbanks.contains(getbanks.banks[i].bankaccno)){
    if(mounted){
      setState(() {
    allbanks.add("${getbanks.banks[i].bankaccno}/${getbanks.banks[i].bankname}");
  });
    }
  }
}

  }

      @override
  void initState() {
    _usdval = TextEditingController();
    _nairaval = TextEditingController();
    _thash =  TextEditingController();
    userInfo();
    super.initState();
  }

  @override
  void dispose() {
    _usdval.clear();
    _nairaval.clear();
    _thash.clear();
    super.dispose();
  }

sellcoin({bankacc,usdval,hash,image,imagename,trackid}) async {
                      functionfile.onHorizontalLoading1(context);
    var theinternet = await functionfile.isInternet();
    var theinternet2 = await functionfile.checkInternetAccess();

    try {
      if (theinternet && theinternet2) {
        if (usdval.isEmpty) {
          Navigator.of(context).pop();
          toast('Please enter an amount',gravity:ToastGravity.CENTER,bgColor: AppColors.appLightRed);
        }else if (bankacc.isEmpty||bankacc==null||bankacc=='') {
          Navigator.of(context).pop();
          toast('Please choose a bank account',gravity:ToastGravity.CENTER,bgColor: AppColors.appLightRed);
        } else if (hash.isEmpty||hash==null||hash=='') {
          Navigator.of(context).pop();
          toast('Please input the transaction hash',gravity:ToastGravity.CENTER,bgColor: AppColors.appLightRed);
        }else if (image.isEmpty||image==null||image==''||imagename.isEmpty||imagename==null||imagename=='') {
          Navigator.of(context).pop();
          toast('Please Choose the transaction image',gravity:ToastGravity.CENTER,bgColor: AppColors.appLightRed);
        }else if (trackid.isEmpty||trackid==null||trackid=='') {
          Navigator.of(context).pop();
          toast('Oops, sorry,Error Connecting to server,try again later',gravity:ToastGravity.CENTER,bgColor: AppColors.appLightRed);
        }else {
var splitme=bankacc.split('/');
bankacc=splitme[0];
var sendtbnkid=0;
var getbanks = await bankapi.userbanklist();
if(getbanks!=null){
var thetotal = getbanks.banks.length;
var i=0;
for(i=0;i<thetotal;i++){
    if(getbanks.banks[i].bankaccno==bankacc){
    sendtbnkid= getbanks.banks[i].bankid;
    break;
  }
}

          var v = await sellapi.sellnewcoins(amountsent:usdval,bankid:sendtbnkid,hash:hash,image:image,imgname:imagename,cointrackid:trackid).timeout(Duration(seconds: 20), onTimeout: () {
            Navigator.of(context).pop();
         toast(AppTexts.nointerneterr,gravity:ToastGravity.CENTER,bgColor: AppColors.appLightRed);
         return null;
          });

        if(v!=null){
            if (v.status == true) {
             Navigator.of(context).pop();  
             toast("Transaction Initiated Successfully, your account would be credited immidiately the transaction is confirmed. Thank you for using LoadNG",gravity:ToastGravity.CENTER,bgColor: AppColors.appDark_parrot_green);
                  Navigator.of(context).pushNamed('/userhistory'); 
            }  else {
             Navigator.of(context).pop();  
               toast(v.msg,gravity:ToastGravity.CENTER,bgColor: AppColors.appLightRed);
            }
          }else{
             Navigator.of(context).pop();  
             toast("Oops Sorry,Check your Internet Speed and retry",gravity:ToastGravity.CENTER,bgColor: AppColors.appLightRed);
          }
        }
        else {
             Navigator.of(context).pop();  
         toast('Please Check your Internet Speed and retry',gravity:ToastGravity.CENTER,bgColor: AppColors.appLightRed);
      }
        }
      } else {
             Navigator.of(context).pop();  
         toast(AppTexts.nointerneterr,gravity:ToastGravity.CENTER,bgColor: AppColors.appLightRed);
      }
      
    } on SocketException catch (_) {
             Navigator.of(context).pop();  

       toast(AppTexts.nointerneterr,gravity:ToastGravity.CENTER,bgColor: AppColors.appLightRed);
    }
  }
}
