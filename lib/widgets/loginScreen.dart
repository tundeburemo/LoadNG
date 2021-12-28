import 'package:flutter/material.dart';
import 'package:loadng/styles/AppFontSizes.dart';
import 'package:loadng/styles/AppColors.dart';
import 'package:loadng/styles/AppText.dart';
import 'package:loadng/styles/AppImage.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:loadng/styles/AppTextStyle.dart';
import "package:loadng/model/system/route_argument.dart";
import 'package:share/share.dart';




Widget text(var text, {var fontSize = AppFontSize.textSizeLargeMedium, textColor = AppColors.primaryDark, var fontFamily = AppFontSize.fontRegular, var isCentered = false, var maxLine = 1, var latterSpacing = 0.25}) {
  return Text(text,
      textAlign: isCentered ? TextAlign.center : TextAlign.start,
      maxLines: maxLine,
      style: TextStyle(fontFamily: fontFamily, fontSize: fontSize, color: textColor, height: 1.5, letterSpacing: latterSpacing));
}

Widget sidetext(var text, {var fontSize = AppFontSize.textSizeLargeMedium, textColor = AppColors.realblack, var fontFamily = AppFontSize.montlight, var isCentered = false, var maxLine = 1, var latterSpacing = 0.25}) {
  return Text(text,
      textAlign: isCentered ? TextAlign.center : TextAlign.start,
      maxLines: maxLine,
      style: TextStyle(fontFamily: fontFamily, fontSize: fontSize, color: textColor, height: 1.5, letterSpacing: latterSpacing));
}

BoxDecoration boxDecoration({double radius = 2, Color color = Colors.transparent, Color bgColor = AppColors.white, var showShadow = false}) {
  return BoxDecoration(
      //gradient: LinearGradient(colors: [bgColor, whiteColor]),
      color: bgColor,
      boxShadow: showShadow ? [BoxShadow(color: AppColors.appShadowColor, blurRadius: 10, spreadRadius: 2)] : [BoxShadow(color: Colors.transparent)],
      border: Border.all(color: color),
      // borderRadius: BorderRadius.all(Radius.circular(radius)) 
      );
}

showToast(BuildContext aContext, String caption) {
  Scaffold.of(aContext).showSnackBar(SnackBar(content: text(caption, textColor: AppColors.appWhite, isCentered: true)));
}

// ignore: must_be_immutable
class EditText extends StatefulWidget {
  var isPassword; 
  var isSecure;
  var fontSize;
  var textColor;
  var fontFamily;
  var text;
  var hint;
  var maxLine;
  var editable;
  TextEditingController mController;

  VoidCallback onPressed;

  EditText(
      {var this.fontSize = AppFontSize.textSizeNormal,
      var this.textColor = AppColors.appTextColorPrimary,
      var this.fontFamily = AppFontSize.montlight,
      var this.isPassword = true,
      var this.hint = "",
      var this.isSecure = false,
      var this.text = "",
      var this.mController,
      var this.maxLine = 1,
      var this.editable=false});

  @override
  State<StatefulWidget> createState() {
    return EditTextState();
  }
}

class EditTextState extends State<EditText> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      readOnly: widget.editable,
      controller: widget.mController,
      obscureText: widget.isPassword,
      style: TextStyle(fontSize: widget.fontSize, fontFamily: AppFontSize.fontRegular,color:widget.textColor,),
      decoration: InputDecoration(
        suffixIcon: widget.isSecure
            ? GestureDetector(
                onTap: () {
                  setState(() {
                    widget.isPassword = !widget.isPassword;
                  });
                },
                child: new Icon(widget.isPassword ? Icons.visibility : Icons.visibility_off),
              )
            : null,
        contentPadding: EdgeInsets.fromLTRB(16, 10, 16, 10),
        hintText: widget.hint,
        hintStyle: TextStyle(color:widget.textColor,fontFamily: AppFontSize.montlight,fontWeight: FontWeight.w600,fontSize:widget.fontSize),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: const BorderSide(color: AppColors.appSecondaryBackgroundColor, width: 0.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: const BorderSide(color: AppColors.appSecondaryBackgroundColor, width: 0.0),
        ),
      ),
    );
  }
  
}


class CustomDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: dialogContent(context),
    );
  }
}

dialogContent(BuildContext context) {
  var width = MediaQuery.of(context).size.width;

  return Container(
      decoration: new BoxDecoration(
        color: Colors.white,
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 10.0,
            offset: const Offset(0.0, 10.0),
          ),
        ],
      ),
      width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisSize: MainAxisSize.min, // To make the card compact
        children: <Widget>[
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(padding: EdgeInsets.all(16), alignment: Alignment.centerRight, child: Icon(Icons.close, color: AppColors.appColorPrimary)),
          ),
          Container(
            width: 45,
            height: 45,
            decoration: BoxDecoration(shape: BoxShape.circle, color:AppColors.appIconTint_sky_blue),
            child: Icon(
              Icons.done,
              color: AppColors.appWhite
            ),
          ),
          SizedBox(height: 24),
          text(AppTexts.them5_lbl_fingerprint_authentication, textColor: AppColors.appColorPrimary, fontFamily: AppFontSize.fontBold, fontSize: AppFontSize.textSizeNormal),
          Padding(
            padding: const EdgeInsets.only(left: 30, right: 30, bottom: 16, top: 10),
            child: text(AppTexts.t5_note_user_fingerprint, textColor:AppColors.appTextColorSecondary, fontFamily: AppFontSize.fontMedium, fontSize: AppFontSize.textSizeMedium, maxLine: 2, isCentered: true),
          ),
          SizedBox(height: 30),
          GestureDetector(onTap: () {}, child: SvgPicture.asset(AppImage.t5_img_fingerprint, width: width / 4, color: AppColors.appColorPrimary)),
          SizedBox(height: 50),
        ],
      ));
}


// ignore: must_be_immutable
class TopBar extends StatefulWidget {
  var titleName;

  TopBar({var this.titleName = ""});

  @override
  State<StatefulWidget> createState() {
    return TopBarState();
  }
}

class TopBarState extends State<TopBar> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 60,
        child: Stack(
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.keyboard_arrow_left, size: 45),
              onPressed: () {
 finish(context);
              },
            ),
            Center(child: text(widget.titleName, textColor:AppColors.shadowdarkblack,fontSize:  AppFontSize.textSizeNormal, fontFamily:  AppFontSize.montbold))
          ],
        ),
      ),
    );
  }
}


class PinEntryTextField extends StatefulWidget {
  final String lastPin;
  final int fields;
  final onSubmit;
  final fieldWidth;
  final fontSize;
  final isTextObscure;
  final showFieldAsBox;

  PinEntryTextField({this.lastPin, this.fields: 4, this.onSubmit, this.fieldWidth: 40.0, this.fontSize: 20.0, this.isTextObscure: false, this.showFieldAsBox: false}) : assert(fields > 0);

  @override
  State createState() {
    return PinEntryTextFieldState();
  }
}

class PinEntryTextFieldState extends State<PinEntryTextField> {
  List<String> _pin;
  List<FocusNode> _focusNodes;
  List<TextEditingController> _textControllers;

  Widget textfields = Container();

  @override
  void initState() {
    super.initState();
    _pin = List<String>(widget.fields);
    _focusNodes = List<FocusNode>(widget.fields);
    _textControllers = List<TextEditingController>(widget.fields);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        if (widget.lastPin != null) {
          for (var i = 0; i < widget.lastPin.length; i++) {
            _pin[i] = widget.lastPin[i];
          }
        }
        textfields = generateTextFields(context);
      });
    });
  }

  @override
  void dispose() {
    _textControllers.forEach((TextEditingController t) => t.dispose());
    super.dispose();
  }

  Widget generateTextFields(BuildContext context) {
    List<Widget> textFields = List.generate(widget.fields, (int i) {
      return buildTextField(i, context);
    });

    if (_pin.first != null) {
      FocusScope.of(context).requestFocus(_focusNodes[0]);
    }

    return Row(mainAxisAlignment: MainAxisAlignment.center, verticalDirection: VerticalDirection.down, children: textFields);
  }

  void clearTextFields() {
    _textControllers.forEach((TextEditingController tEditController) => tEditController.clear());
    _pin.clear();
  }

  Widget buildTextField(int i, BuildContext context) {
    if (_focusNodes[i] == null) {
      _focusNodes[i] = FocusNode();
    }
    if (_textControllers[i] == null) {
      _textControllers[i] = TextEditingController();
      if (widget.lastPin != null) {
        _textControllers[i].text = widget.lastPin[i];
      }
    }

    _focusNodes[i].addListener(() {
      if (_focusNodes[i].hasFocus) {}
    });

    final String lastDigit = _textControllers[i].text;

    return Container(
      width: widget.fieldWidth,
      margin: EdgeInsets.only(right: 10.0),
      child: TextField(
        controller: _textControllers[i],
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        maxLength: 1,
        style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black, fontFamily: AppFontSize.fontMedium, fontSize: widget.fontSize),
        focusNode: _focusNodes[i],
        obscureText: widget.isTextObscure,
        decoration: InputDecoration(counterText: "", border: widget.showFieldAsBox ? OutlineInputBorder(borderSide: BorderSide(width: 2.0)) : null),
        onChanged: (String str) {
          setState(() {
            _pin[i] = str;
          });
          if (i + 1 != widget.fields) {
            _focusNodes[i].unfocus();
            if (lastDigit != null && _pin[i] == '') {
              FocusScope.of(context).requestFocus(_focusNodes[i - 1]);
            } else {
              FocusScope.of(context).requestFocus(_focusNodes[i + 1]);
            }
          } else {
            _focusNodes[i].unfocus();
            if (lastDigit != null && _pin[i] == '') {
              FocusScope.of(context).requestFocus(_focusNodes[i - 1]);
            }
          }
          if (_pin.every((String digit) => digit != null && digit != '')) {
            widget.onSubmit(_pin.join());
          }
        },
        onSubmitted: (String str) {
          if (_pin.every((String digit) => digit != null && digit != '')) {
            widget.onSubmit(_pin.join());
          }
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return textfields;
  }
}


BoxDecoration cardboxDecoration(
    {double radius = 80.0,
    Color backGroundColor = AppColors.appColorPrimary,
    double blurRadius = 8.0,
    double spreadRadius = 8.0,
    shadowColor = Colors.black12}) {
  return BoxDecoration(
    borderRadius: BorderRadius.circular(radius),
    boxShadow: [
      BoxShadow(
        color: shadowColor,
        blurRadius: blurRadius,
        spreadRadius: spreadRadius,
      ),
    ],
    color: backGroundColor,
  );
}


// ignore: non_constant_identifier_names
Widget ReferalCardDetails({
  String username,
  Color color,
  String totalpaid,
  String totalrefered,
  String name, 
}) {
  return Container(
    padding: EdgeInsets.all(20),
    margin: EdgeInsets.only(left: 16.0, right: 16, bottom: 16, top: 16),
    decoration: cardboxDecoration(
        radius: 20,
        backGroundColor: color,
        spreadRadius: 4.0,
        blurRadius: 10.0,
        shadowColor: color.withAlpha(50)),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Image.asset(
                  AppImage.appLogoWhite,
                  height: 40,
                  width: 120,
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    username,
                    style: AppTextStyle.boldTextStyle(size: 22, color: Colors.white),
                  ),
                ),
              ],
            ),
      
            SizedBox(height: 10),
          ],
        ),
        Container(
          margin: EdgeInsets.only(bottom: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  FittedBox(
                    child: Text(
                      'REFERRED',
                      style: secondaryTextStyle(color: Colors.white60),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  FittedBox(
                    child: Text(
                      totalrefered,
                      style: primaryTextStyle(color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  FittedBox(
                    child: Text(
                      'COINS PAID',
                      style: secondaryTextStyle(color: Colors.white60),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  FittedBox(
                    child: Text(
                      totalpaid,
                      style: primaryTextStyle(color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
              SizedBox(),
            ],
          ),
        ),
      ],
    ),
  );
}


// ignore: non_constant_identifier_names
Widget DashboardList({
  String name = "",
  String status = "",
  String amount = "",
  String amountnaira=" ",
  IconData icon = Icons.call_received,
  Color colors = Colors.green,
  Color iconcolor = Colors.green,
  Color color,
}) {
  return Container(
      margin: EdgeInsets.only(left: 16, right: 16),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  CircleAvatar(
                    backgroundColor: colors.withOpacity(0.2),
                    radius: 20,
                    child: Icon(
                      icon,
                      color: iconcolor,
                      size: 20,
                    ),
                  ),
                  SizedBox(
                    width: 7,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        name,
                        style:
                            primaryTextStyle(fontFamily: AppFontSize.spinnaker, size: 13),
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      Text(
                        status,
                        style: secondaryTextStyle(size: 12),
                      ),
                    ],
                  ),
                ],
              ),
              Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      amount,
                      style: boldTextStyle(
                        color: color,
                        size: 12,
                      ),
                    ),
                     Text(
                      amountnaira,
                      style: boldTextStyle(
                        color: Colors.black,
                        size: 12,
                        fontFamily:"Arial"
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
          Divider(
            thickness: 1,
            indent: 6.0,
          ),
        ],
      ),
  );
}

Widget toolBarTitle(var title,{textColor=AppColors.shadowdarkblack}){
  return text(title,fontSize: AppFontSize.textSizeNormal,fontFamily: AppFontSize.cooperaterunded,textColor: textColor,maxLine: 3,isCentered: true);
}

Widget appBar(context,var title,{actions}){
  return AppBar(
    title: toolBarTitle(title),
    leading: Icon(Icons.arrow_back_ios,color: AppColors.shadowdarkblack).onTap((){
      Navigator.pop(context);
    }),
    titleSpacing:0,
    iconTheme: IconThemeData(color: AppColors.shadowdarkblack),
    backgroundColor: Colors.white.withOpacity(0.1),
    elevation: 0,
    actions: actions,
  );

}

Widget appBarwithlink(context,var title,var navlink,{actions}){
  return AppBar(
    title: toolBarTitle(title),
    leading: Icon(Icons.arrow_back_ios,color: AppColors.shadowdarkblack).onTap((){
    Navigator.of(context).pushNamed('$navlink');
    }),
    titleSpacing:0,
    iconTheme: IconThemeData(color: AppColors.shadowdarkblack),
    backgroundColor: Colors.white.withOpacity(0.1),
    elevation: 0,
    actions: actions,
  );
}

Widget formField( context,hint,
    {isEnabled = true,
      isDummy = false,
      controller,
      fontsize=AppFontSize.textSizeMedium,
      isPasswordVisible = false,
      isPassword = false,
      keyboardType = TextInputType.text,
      FormFieldValidator<String> validator,
      onSaved,
      textInputAction = TextInputAction.next,
      FocusNode focusNode,
      FocusNode nextFocus,
      IconData suffixIcon,
      IconData prefixIcon,
      maxLine = 1,
      textcolor=AppColors.appColorPrimary,
      suffixIconSelector,
      ontap}) {
  return TextFormField(
    autofocus: false,
    onTap:ontap,
    onEditingComplete: ontap,
    enabled: isEnabled,
    controller: controller,
    obscureText: isPassword?isPasswordVisible:false,
    cursorColor: AppColors.appColorPrimary,
    maxLines: maxLine,
    keyboardType: keyboardType,
    validator: validator,
    onSaved: onSaved,
    textInputAction: textInputAction,
    focusNode: focusNode,
    onFieldSubmitted: (arg) {
      if (nextFocus != null) {
        FocusScope.of(context).requestFocus(nextFocus);
      }
    },
    decoration: InputDecoration(
      focusedBorder: UnderlineInputBorder(
        borderRadius: BorderRadius.circular(AppFontSize.spacing_standard),
        borderSide: BorderSide(color: Colors.transparent)

      ),
      enabledBorder: UnderlineInputBorder(
        borderRadius: BorderRadius.circular(AppFontSize.spacing_standard),
          borderSide: BorderSide(color: Colors.transparent)

      ),
      filled: true,
      fillColor: AppColors.t12_edittext_background,
      hintText:hint,
      hintStyle: TextStyle(
          fontSize: fontsize, color: AppColors.t12_text_secondary),
      prefixIcon:Icon(
        prefixIcon,
        color: AppColors.t12_text_secondary,
        size: 20,
      ) ,
      suffixIcon: isPassword
          ? GestureDetector(
        onTap: suffixIconSelector,
        child: new Icon(
          suffixIcon,
          color: AppColors.t12_text_secondary,
          size: 20,
        ),
      )
          :null,
    ),
    style: TextStyle(
        fontSize: AppFontSize.textSizeNormal,
        color: isDummy
            ? Colors.transparent
            : textcolor,
        fontFamily: AppFontSize.fontRegular),
  );
}



profileText(var label, {var maxline = 1}) {
  return 
           Padding(
          padding: const EdgeInsets.fromLTRB(5, 3, 0, 0),
          child:text(label,
              fontSize: AppFontSize.textSizeLargeMedium,
              textColor: AppColors.primaryDark, 
              maxLine: maxline,
              fontFamily: AppFontSize.fontRegular)
  );
}

Divider view() {
  return Divider(
    color: AppColors.t1_view_color,
    height: 0.5,
  );
}

Row rowHeading(var label) {
  return Row(
    children: <Widget>[
      Padding(
          padding: const EdgeInsets.fromLTRB(10, 0, 10, 0), 
          child: Text(label,
              style: TextStyle(
                  color: AppColors.t1_textColorPrimary, fontSize: 18, fontFamily:AppFontSize.montbold),
              textAlign: TextAlign.left)),
    ],
  );
}

Text profile(var label) {
  return Text(label,
      style:
          TextStyle(color: AppColors.t1_colorPrimary, fontSize: 18, fontFamily: 'Medium'),
      textAlign: TextAlign.center);
}

// ignore: must_be_immutable
class QIBusAppButton extends StatefulWidget {
  var textContent;
  VoidCallback onPressed;

  QIBusAppButton({@required this.textContent, @required this.onPressed});

  @override
  State<StatefulWidget> createState() {
    return QIBusAppButtonState();
  }
}

class QIBusAppButtonState extends State<QIBusAppButton> {
  @override
  Widget build(BuildContext context) {
    return RaisedButton(
        onPressed: widget.onPressed,
        textColor: AppColors.appWhite, 
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
        padding: const EdgeInsets.all(0.0),
        child: Container(
          decoration: const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(8.0)), color: AppColors.appColorPrimary),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                widget.textContent,
                style: TextStyle(fontSize: 16),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ));
  }
}


Widget transactionWidget({transactionimg,transactionname,transactionamt,var categoryWidth}){ 
  return Container(
    decoration: boxDecoration(showShadow: true,radius: AppFontSize.spacing_standard),
    padding: EdgeInsets.all(AppFontSize.spacing_standard),
    margin: EdgeInsets.only(bottom: AppFontSize.spacing_standard),
    child: Row(
      children: <Widget>[
        Image.asset(transactionimg,width:categoryWidth*0.75,height: categoryWidth*0.75,).cornerRadiusWithClipRRect(AppFontSize.spacing_standard).paddingRight(AppFontSize.spacing_standard),
        Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              text(transactionname,fontSize: AppFontSize.textSizeMedium,textColor: AppColors.appColorPrimary,fontFamily: AppFontSize.cooperaterunded,maxLine: 2),
              text(transactionamt,fontSize: AppFontSize.textSizeMedium,textColor: AppColors.appTextColorSecondary,fontFamily: AppFontSize.fontSemibold).paddingTop(AppFontSize.spacing_control_half),
            ],
          ),
        ),
        // Column(
        //   children: <Widget>[
        //     text(transaction.transactionType=="credited"?"+ \$"+ transaction.amount.toString():"- \$"+ transaction.amount.toString(),fontSize: textSizeMedium,textColor:transaction.transactionType=="credited"?t12_success:t12_error ,fontFamily: fontBold),
        //     text(transaction.time,fontSize: AppFontSize.textSizeMedium,textColor: t12_text_secondary).paddingTop(AppFontSize.spacing_control)
        //   ],
        // )
      ],
    ),
  );
}


Widget dashboardtransactionWidget({transactionimg,transactionname,transactionamt,var categoryWidth,rate,liverate,thestatusnum}){ 
  var cardcolor=Colors.black38;
  if(thestatusnum=="0"||thestatusnum==0){
    cardcolor = Colors.orangeAccent;
  }else if(thestatusnum=="1"||thestatusnum==1){
    cardcolor = Colors.green[300];
  }else if(thestatusnum=="2"||thestatusnum==2){
    cardcolor = AppColors.appColorPrimary;
  }else if(thestatusnum=="3"||thestatusnum==3){
    cardcolor = Colors.red[300];
  }else if(thestatusnum=="4"||thestatusnum==4){
    cardcolor = Colors.red[300];
  }else if(thestatusnum=="5"||thestatusnum==5){
    cardcolor = Colors.red[300];
  }else if(thestatusnum=="6"||thestatusnum==6){
    cardcolor = Colors.red[300];
  }

  return Container(
    decoration: boxDecoration(showShadow: true,radius: AppFontSize.spacing_standard),
    padding: EdgeInsets.all(AppFontSize.spacing_standard),
    margin: EdgeInsets.only(bottom: AppFontSize.spacing_standard),
    child: Row(
      children: <Widget>[
        Image.asset(transactionimg,width:categoryWidth*0.75,height: categoryWidth*0.75,).cornerRadiusWithClipRRect(AppFontSize.spacing_standard).paddingRight(AppFontSize.spacing_standard),
        Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              text(transactionname,fontSize: AppFontSize.textSizeSMedium,textColor: AppColors.appColorPrimary,fontFamily: AppFontSize.fontMedium),
              text(transactionamt,fontSize: AppFontSize.textSizeSmall,textColor: cardcolor,fontFamily: AppFontSize.montbold).paddingTop(AppFontSize.spacing_control_half),
            ],
          ),
        ),
        Column(
          children: <Widget>[
            text(liverate.toString(),fontSize: AppFontSize.textSizeSMedium,textColor:Colors.green[300],fontFamily: AppFontSize.montbold),
               Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[ 
                                      text("₦",
                                              textColor: AppColors.appTextColorSecondary,
                                              fontFamily: AppFontSize.fontBold,
                                              fontSize: AppFontSize.textSizeSMedium)
                                          .paddingTop(AppFontSize.spacing_control),
                                  text("$rate",
                                              textColor: AppColors.appTextColorSecondary,
                                              fontFamily: AppFontSize.montbold,
                                              fontSize:AppFontSize.textSizeSMedium)
                                          .paddingTop(AppFontSize.spacing_control),
                                    ]),
          ],
        )
      ],
    ),
  );
}


Widget headingText(String content) {
  return text(content, textColor: AppColors.t12_text_color_primary, fontFamily: AppFontSize.spinnaker, fontSize: AppFontSize.textSizeNormal);
}

Widget referalCards({walletname,cardHight,index,walletbalance,context,reflink,ontap}) {
  return Container(
                          width: double.infinity,
                          height: cardHight,
                          margin: EdgeInsets.symmetric(horizontal: 5.0),
                          child: Stack(
                            children: <Widget>[
                              Container(
                                decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                        colors: AppColors.t12_gradient_colors[
                                            index % AppColors.t12_gradient_colors.length],
                                        begin: Alignment.topRight,
                                        end:Alignment.bottomLeft),
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(AppFontSize.spacing_large))),
                                width: double.infinity,
                                height: double.infinity,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      text("$walletname",
                                          textColor:
                                              Colors.white.withOpacity(0.7),
                                          fontSize: AppFontSize.textSizeSmall,fontFamily:AppFontSize.spinnaker),
                                      Image.asset(AppImage.appLogoWhite,
                                        width: 90,
                                        height: 40,
                                      )
                                    ],
                                  ),
                        text("$walletbalance",
                                              textColor: Colors.white,
                                              fontFamily: AppFontSize.montbold,
                                              fontSize: 24.0),
            (index==0?
                        ElevatedButton(
                                style: ButtonStyle(backgroundColor:MaterialStateProperty.all( AppColors.appWhite)),
                                onPressed: ontap,
                               child:  text("Withdraw",
                                           textColor: Colors.black87.withOpacity(0.7),
                                          fontSize: AppFontSize.textSizeSmall,fontFamily:AppFontSize.spinnaker),):Container()),
                           
            (index==1?
                        ElevatedButton(
                                style: ButtonStyle(backgroundColor:MaterialStateProperty.all( AppColors.appWhite)),
                                onPressed: (){
Share.share('Sell Bitcoin, Ethereum, Bitcoin Cash, Dogecoin, Litecoin, Dai, Usdc and Usdt with LoadNG. \n\n $reflink', subject: 'LoadNG Referral');
                               },
                               child:  text("Share Referral Link",
                                           textColor: Colors.black87.withOpacity(0.7),
                                          fontSize: AppFontSize.textSizeSmall,fontFamily:AppFontSize.spinnaker),)
:Container()),

            (index==2?
                        ElevatedButton(
                                style: ButtonStyle(backgroundColor:MaterialStateProperty.all( AppColors.appWhite)),
                                onPressed: (){
                                   Navigator.of(context).pushNamed(
                                      '/coinslist');

                              },
                               child:  text("Sell more",
                                          textColor: Colors.black87.withOpacity(0.7),
                                          fontSize: AppFontSize.textSizeSmall,fontFamily:AppFontSize.spinnaker),)
:Container()),




                                ],
                              ).paddingAll(AppFontSize.spacing_standard_new)
                            ],
                          ),
                        );
  
  }


Widget dashboardCards({walletname,cardHight,index,walletbalance,type,mainacc,username}) {
  return Container(
                          width: double.infinity,
                          height: cardHight,
                          margin: EdgeInsets.symmetric(horizontal: 5.0),
                          child: Stack(
                            children: <Widget>[
                              Container(
                                decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                        colors: AppColors.t12_gradient_colors[
                                            index % AppColors.t12_gradient_colors.length],
                                        begin: Alignment.bottomRight,
                                        end:Alignment.topRight),
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(AppFontSize.spacing_standard))),
                                width: double.infinity,
                                height: double.infinity,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      text("$walletname Wallet",
                                          textColor:
                                              Colors.white.withOpacity(0.7),
                                          fontSize: AppFontSize.textSizeSmall,fontFamily:AppFontSize.spinnaker),
                                      Image.asset(AppImage.appLogoWhite,
                                        width: 100,
                                        height: 40,
                                      )
                                    ],
                                  ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[ 
                                      text("₦",
                                              textColor: Colors.white,
                                              fontFamily: AppFontSize.fontBold,
                                              fontSize: 29.0).paddingTop(AppFontSize.spacing_standard),
                                           FittedBox(
                                             fit:BoxFit.contain,
                    child: text("$walletbalance",
                                              textColor: Colors.white,
                                              fontFamily: AppFontSize.montbold,
                                              fontSize: 30.0),
                  ).paddingTop(AppFontSize.spacing_standard),
                                    ]),
                                  Row( 
                                    children: <Widget>[
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            text("USERNAME",
                                                textColor: Colors.white
                                                    .withOpacity(0.7),
                                                fontSize: AppFontSize.textSizeMedium,fontFamily: AppFontSize.cooperaterunded),
                                            text("$username",
                                                textColor: Colors.white,
                                                fontSize: AppFontSize.textSizeMedium,
                                                fontFamily: AppFontSize.fontMedium),
                                          ],
                                        ),
                                      ), Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            text("MAIN ACCOUNT",
                                                textColor: Colors.white.withOpacity(0.7),
                                                fontSize: AppFontSize.textSizeMedium,fontFamily: AppFontSize.cooperaterunded),
                                            text("$mainacc",
                                                textColor: Colors.white,
                                                fontSize: AppFontSize.textSizeMedium,
                                                fontFamily: AppFontSize.fontMedium),
                                          ],
                                        
                                      ),
                                    ],
                                  )
                                ],
                              ).paddingAll(AppFontSize.spacing_standard_new)
                            ],
                          ),
                        );
  
  }

    Widget itemList(Widget icon, String title) {
    return Row(
      children: [
        icon,
        10.width,
        Text(title, style: TextStyle(color: AppColors.cardBackgroundBlackDark)),
      ],
    );
  }



class HistoryDialog extends StatelessWidget {
  final name;
  final rate;
  final usdval;
  final nairaval;
  final status;
  final orderid;
  HistoryDialog ({this.name,this.rate,this.usdval,this.nairaval,this.status,this.orderid});
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: historydialogContent(context,name,rate,usdval,nairaval,status,orderid),
    );
  }
}

historydialogContent(BuildContext context,name,rate,usdval,nairaval,status,orderid) {

  return Container(
    decoration: new BoxDecoration(
      color: Colors.white,
      shape: BoxShape.rectangle,
      borderRadius: BorderRadius.circular(10),
      boxShadow: [
        BoxShadow(
          color: Colors.black26,
          blurRadius: 10.0,
          offset: const Offset(0.0, 10.0),
        ),
      ],
    ),
    width: MediaQuery.of(context).size.width,
    //height: MediaQuery.of(context).size.height * 0.8,
    padding: EdgeInsets.all(AppFontSize.spacing_standard_new),
    child: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min, // To make the card compact
        children: <Widget>[
          Align(
            alignment: Alignment.center,child: SvgPicture.asset(
            AppImage.t5_wallet,
            width:  25,
            height: 24,
            fit: BoxFit.fill,
          )),
          SizedBox(
            height: AppFontSize.spacing_standard_new,
          ),
          Align(
            alignment: Alignment.center,
            child:text("Transaction details",fontSize: AppFontSize.textSizeLarge, textColor:AppColors.t10_textColorSecondary, isCentered: true)),
          SizedBox(
            height: AppFontSize.spacing_standard_new,
          ),
        text("Name: $name", textColor:AppColors.primaryDark,fontSize: AppFontSize.textSizeMedium,fontFamily: AppFontSize.spinnaker),
        text("Rate: $rate", textColor:AppColors.primaryDark,fontSize: AppFontSize.textSizeMedium,fontFamily: AppFontSize.spinnaker),
        text("Amount USD: $usdval", textColor:AppColors.primaryDark,fontSize: AppFontSize.textSizeMedium,fontFamily: AppFontSize.spinnaker),
        text("Amount Naira: $nairaval", textColor:AppColors.primaryDark,fontSize: AppFontSize.textSizeMedium,fontFamily: AppFontSize.spinnaker),
        text("Status: $status", textColor:AppColors.primaryDark,fontSize: AppFontSize.textSizeMedium,fontFamily: AppFontSize.spinnaker),
        Container(
    width: MediaQuery.of(context).size.width,
          child:text("OrderID: $orderid", textColor:AppColors.primaryDark,fontSize: AppFontSize.textSizeSmall,fontFamily: AppFontSize.spinnaker,maxLine: 4)),

          SizedBox(
            height: AppFontSize.spacing_standard,
          ),
          // text("theme10_lbl_sms_send", fontSize: AppFontSize.textSizeSMedium),
        ],
      ),
    ),
  );
}


class CustomInfo extends StatelessWidget {
  final sentimgtype;
  final sentimg;
  final senttxt;
  final senttxttype;
  final thename;
  final therate;
  final thehexcode;
  final thenavlink;
  final thetype;
  final theaddress;
  final thebnkaccno;
  final thebankname;
  final thecoinname;
  final thecolorcode;


  CustomInfo({this.sentimg,this.senttxt,this.thename,this.therate,this.thehexcode,this.thenavlink,this.thetype,this.theaddress,this.sentimgtype,this.senttxttype,
  this.thebnkaccno,
  this.thebankname,
  this.thecoinname,
  this.thecolorcode,
  });
  
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: SingleChildScrollView(child: Container(
        decoration: new BoxDecoration(
          color: AppColors.appWhite,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(color: Colors.black26, blurRadius: 10.0, offset: const Offset(0.0, 10.0)),
          ],
        ),
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            sentimgtype==5?Container():
         Container(
                color:Color(thehexcode),
           child:  ClipRRect(
              borderRadius: BorderRadius.only(topLeft: Radius.circular(8), topRight: Radius.circular(8)),


              child:
              sentimgtype==1||  sentimgtype=="1"?
               Image.network(
          sentimg,
            width: MediaQuery.of(context).size.width,
            height: 120,  
            fit: BoxFit.contain,
          ):  Image.asset(
          sentimg,
            width: MediaQuery.of(context).size.width,
            height: 120,  
            fit: BoxFit.contain,
          ),


              // Image(width: MediaQuery.of(context).size.width, image: sentimg, height: 120, fit: BoxFit.cover),
            )),
            24.height,
            Text('Notice',textAlign:TextAlign.justify,style: boldTextStyle(color: AppColors.appColorPrimary, size: 18,fontFamily: AppFontSize.montbold)),
            16.height,
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16),
              child:senttxttype==1? senttxt :
              
              Text(senttxt, style: secondaryTextStyle(color: AppColors.appTextColorSecondary)),
            ),
            16.height,
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(8),
                      decoration: boxDecoration(color: AppColors.t12_error, radius: 8, bgColor: AppColors.t12_error),
                      child: Center(
                        child: RichText(
                          text: TextSpan(
                            children: [
                              WidgetSpan(child: Padding(padding: EdgeInsets.only(right: 8.0), child: Icon(Icons.close, color: Colors.white, size: 18))),
                              TextSpan(text: "Cancel", style: TextStyle(fontSize: 16.0, color: Colors.white, fontFamily: AppFontSize.fontRegular)),
                            ],
                          ),
                        ),
                      ),
                    ).onTap((){
                      Navigator.pop(context);
                    }),
                  ),
                  9.width,
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(8),
                      decoration: boxDecoration(bgColor: Colors.green, radius: 8),
                      child: Center(
                        child: RichText(
                          text: TextSpan(
                            children: [
                              WidgetSpan(child: Padding(padding: EdgeInsets.only(right: 4.0), child: Icon(Icons.check, color: Colors.white, size: 18))),
                              TextSpan(text: "Proceed", style: TextStyle(fontSize: 16.0, color: Colors.white, fontFamily:  AppFontSize.fontRegular)),
                            ],
                          ),
                        ),
                      ),
                    ).onTap((){
                      Navigator.pop(context);
                       if(thenavlink=="/userreferals"){
                Navigator.of(context).pushNamed('/userreferals',arguments: new RouteArgument(argumentsList: [0]));
                       }else{
                      Navigator.of(context).pushNamed('$thenavlink',
                                  arguments: new RouteArgument(argumentsList: [
                                    "$thename",
                                    "$sentimg",
                                    "$therate",
                                    thehexcode,
                                    thetype,
                                    theaddress,
                                    thebnkaccno,
                                    thebankname,
                                    thecoinname,
                                    thecolorcode,
                                  ]));
                       }
                    }),
                  )
                ],
              ),
            ),
            16.height,
          ],
        ),
      )),
    );
  }
}
