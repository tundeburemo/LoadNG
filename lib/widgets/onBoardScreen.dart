import 'package:flutter/material.dart';
import 'package:loadng/utils/customFunction.dart';
import 'package:loadng/styles/AppTextStyle.dart';
import 'package:loadng/locator.dart';
import 'package:loadng/styles/AppFontSizes.dart';
import 'package:loadng/styles/AppColors.dart';
import 'package:loadng/widgets/loginScreen.dart';



var functionfile = locator<CustomFunction>();

class OnBoardButton extends StatefulWidget {
  final  textContent;
  final VoidCallback onPressed;
  final isStroked;

  OnBoardButton({
    @required this.textContent,
    @required this.onPressed,
    this.isStroked = false,
  });

  @override
  OnBoardButtonState createState() => OnBoardButtonState();
}

class OnBoardButtonState extends State<OnBoardButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onPressed,
      child: Container(
        padding: EdgeInsets.fromLTRB(16, 12, 16, 12),
        alignment: Alignment.center,
        child: AppTextStyle.text(widget.textContent,
            textColor: widget.isStroked ? AppColors.appColorPrimary : AppColors.appWhite,
            isCentered: true, 
            fontFamily: AppFontSize.fontMedium, 
            textAllCaps: true),
        decoration: widget.isStroked
            ? boxDecoration(bgColor: Colors.transparent, color: AppColors.appColorPrimary)
            : boxDecoration(bgColor: AppColors.appColorPrimary),
      ),
    );
  }
}


class WalkThrough extends StatelessWidget {
  final String textContent;
  final String title;
  final String image;


  WalkThrough({Key key, @required this.textContent, @required this.title, @required this.image})
      : super(key: key);
 
  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;

    return Container(
      width: MediaQuery.of(context).size.width,
      alignment: Alignment.topCenter,
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(16.0),
            child:  Image.asset(
         image,
         width: MediaQuery.of(context).size.width,
         height: (MediaQuery.of(context).size.height) / 2.2,
         //fit: BoxFit.cover,
        ), 
          ),
          SizedBox(
            height: h * 0.08,
          ),
          Container(
            margin: EdgeInsets.only(left: 30, right: 30),
            child: Center(
                child: Text(
              title,
              style: TextStyle(
                  fontSize: AppFontSize.textSizeLargeMedium, color: AppColors.appColorPrimary,fontFamily:  AppFontSize.montlight,fontWeight:FontWeight.bold),
              textAlign: TextAlign.center,
            )),
          ),
               Container(
            margin: EdgeInsets.only(left: 30, right: 30),
            child: Center(
                child: Text(
              textContent,
              style: TextStyle(
                  fontSize: AppFontSize.textSizeSMedium, color: AppColors.primaryDark,fontFamily: AppFontSize.montlight),
              textAlign: TextAlign.center,
            )),
          ),
        ],
      ),
    );
  }
}