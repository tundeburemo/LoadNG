//********** THIS FILE CONTAIN TEXT Style*/
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loadng/styles/AppFontSizes.dart';
import 'package:loadng/styles/AppColors.dart';


class AppTextStyle{

static Widget text(String text,
    {var fontSize = AppFontSize.textSizeMedium,
    textColor = AppColors.t6colorPrimary,
    var fontFamily = AppFontSize.fontRegular,
    var isCentered = false,
    var maxLine = 1,
    var latterSpacing = 0.25,
    var textAllCaps = false,
    var isLongText = false}) {  
  return Text(textAllCaps ? text.toUpperCase() : text,
      textAlign: isCentered ? TextAlign.center : TextAlign.start,
      maxLines: isLongText ? null : maxLine,
      style: TextStyle(
          fontFamily: fontFamily,
          fontSize: fontSize,
          color: textColor,
          height: 1.5,
          letterSpacing: latterSpacing));
}

static TextStyle boldTextStyle({
  int size = 16,
  Color color,
  FontWeight weight = FontWeight.bold,
  String fontFamily,
  double letterSpacing,
}) {
  return TextStyle(
    fontSize: size.toDouble(),
    color: color ?? AppColors.appColorPrimary,
    fontWeight: weight,
    fontFamily: fontFamily,
    letterSpacing: letterSpacing,
  );
}

  static TextStyle header1(BuildContext context, Color color) {
    return GoogleFonts.alef(
      fontSize: AppFontSize.textSizeXLarge,
     textStyle: 
    TextStyle(
        color: color));
  }

  static TextStyle header1Bold(BuildContext context, Color color) {
    return GoogleFonts.alef(
      fontSize: AppFontSize.textSizeXLarge,
     textStyle: 
    TextStyle(
        color: color,
        fontWeight: FontWeight.bold));
  }
  static TextStyle header1BoldSmall(BuildContext context, Color color) {
    return GoogleFonts.alef(
      fontSize: AppFontSize.textSizeLarge,
     textStyle: 
    TextStyle(
        color: color,
        fontWeight: FontWeight.bold));
  }
  static TextStyle header2Bold(BuildContext context, Color color) {
    return GoogleFonts.alef(
      fontSize: AppFontSize.textSizeXLarge,
     textStyle: 
    TextStyle(
        color: color,
        fontWeight: FontWeight.bold));
  }

  static TextStyle header2(BuildContext context, Color color) {
    return GoogleFonts.alef(
      fontSize: AppFontSize.textSizeXXLarge,
     textStyle: 
    TextStyle(
        color: color));
  }
        static TextStyle header3(BuildContext context, Color color) {
    return GoogleFonts.alef(
      fontSize: AppFontSize.textSizeLarge,
       fontWeight: FontWeight.bold,
     textStyle: 
    TextStyle(
        color: color));
  }


   static TextStyle header4(BuildContext context, Color color) {
    return GoogleFonts.alef(
      fontSize: AppFontSize.textSizeLarge,
     textStyle: 
    TextStyle(
        color: color));
   }
    static TextStyle header4bold(BuildContext context, Color color) {
    return GoogleFonts.alef(
      fontSize: AppFontSize.textSizeLarge,
     textStyle: 
    TextStyle(
      fontWeight: FontWeight.bold,
        color: color));
   }
   static TextStyle wallectB(BuildContext context, Color color) {
    return GoogleFonts.alef(
      fontSize: AppFontSize.textSizeLarge,
     textStyle: 
    TextStyle(
      fontWeight: FontWeight.bold,
        color: color));
   }

    static TextStyle wallectBSmall(BuildContext context, Color color) {
    return GoogleFonts.alef(
      fontSize: AppFontSize.textSizeSMedium,
     textStyle: 
    TextStyle(
      fontWeight: FontWeight.bold,
        color: color));
   }
   static TextStyle sub(BuildContext context, Color color) {
    // return TextStyle(
    //       fontFamily: "Plak W01 Black Condensed",
    //       fontSize: AppFontSize.textSizeLarge,
    // );
     return GoogleFonts.adamina(//aBeeZee
      fontSize: AppFontSize.textSizeSmall,
     textStyle: 
    TextStyle(
        color: color,));
   }

    static TextStyle tabs(BuildContext context, Color color) {
    // return TextStyle(
    //       fontFamily: "Plak W01 Black Condensed",
    //       fontSize: AppFontSize.textSizeLarge,
    // );
     return GoogleFonts.adamina(//aBeeZee
      fontSize: AppFontSize.textSizeSmall,
     textStyle: 
    TextStyle(
        color: color,));
   }

   static TextStyle test(BuildContext context, Color color) {
    return TextStyle(
          fontFamily: "Lintel",
          fontSize: AppFontSize.textSizeSmall,
          color: color,
    );
     
   }
   static TextStyle header4Bold(BuildContext context, Color color) {
    return GoogleFonts.quintessential( //aBeeZee
      fontSize: AppFontSize.textSizeXLarge,
     textStyle: 
    TextStyle(
        color: color,
        fontWeight: FontWeight.bold));
   }
    static TextStyle header5(BuildContext context, Color color) {
    return GoogleFonts.alef(
      fontSize: AppFontSize.textSizeMedium,
     textStyle: 
    TextStyle(
        color: color));
        
   }
   static TextStyle sty(BuildContext context, Color color) {
    return GoogleFonts.aBeeZee(
      fontSize: AppFontSize.textSizeLarge,
     textStyle: TextStyle(
        color: color));
   }

   static TextStyle balace(BuildContext context, Color color) {
    return GoogleFonts.aBeeZee(
      fontSize: AppFontSize.textSizeXLarge,
     textStyle: 
    TextStyle(
        color: color, fontWeight: FontWeight.bold));
   }

   static TextStyle balaceLarge(BuildContext context, Color color) {
    return GoogleFonts.aBeeZee(
      fontSize: AppFontSize.textSizeLarge,
     textStyle: 
    TextStyle(
        color: color, fontWeight: FontWeight.bold));
   }
        static TextStyle subHeader1(BuildContext context, Color color) {
    return GoogleFonts.notoSans(
      fontSize: AppFontSize.textSizeMedium,
     textStyle: TextStyle(
        color: color));
  }

   static TextStyle inputText(BuildContext context) {
    return GoogleFonts.aBeeZee(
      fontSize: AppFontSize.textSizeSMedium,
     textStyle: TextStyle(
        color: Colors.black));
  }
  
   static TextStyle inputTextWColor(BuildContext context, Color color) {
    return GoogleFonts.aBeeZee(
      fontSize: AppFontSize.textSizeSMedium,
     textStyle: TextStyle(
        color: color));
  }
  static TextStyle inputTextDecreaced(BuildContext context) {
    return GoogleFonts.aBeeZee(
      fontSize: AppFontSize.textSizeSmall,
     textStyle: TextStyle(
        color: Colors.black));
  }
  static TextStyle inputTextIncrease(BuildContext context) {
    return GoogleFonts.aBeeZee(
      fontSize: AppFontSize.textSizeLarge,
     textStyle: TextStyle(
        color: Colors.black));
  }

static TextStyle subHeader2(BuildContext context, Color color) {
    return GoogleFonts.alef(
      fontSize: AppFontSize.textSizeSMedium,
     textStyle: 
    TextStyle(
        color: color));
  }

  static TextStyle sellheader(BuildContext context, Color color) {
    return GoogleFonts.spinnaker(
      fontSize: AppFontSize.textSizeSmall,
     textStyle: 
    TextStyle(
        color: color));
  }

static TextStyle subheader3(BuildContext context, Color color) {
    return GoogleFonts.alef(
      fontSize: AppFontSize.textSizeSmall,
     textStyle: 
    TextStyle(
        color: color));
  }
  static TextStyle lHeader(BuildContext context, Color color) {
   return TextStyle(
          fontFamily: "Helvetica",
          fontSize: AppFontSize.textSizeXLarge,
          fontWeight: FontWeight.bold
    );
  }
  static TextStyle subheader3Bold(BuildContext context, Color color) {
    return GoogleFonts.alef(
      fontSize: AppFontSize.textSizeSmall,
     textStyle: 
    TextStyle(
      fontWeight: FontWeight.bold,
        color: color));
  }

   static TextStyle h(BuildContext context, Color color) {
    return GoogleFonts.quintessential( //aBeeZee
      fontSize: AppFontSize.textSizeLarge,
     textStyle: 
    TextStyle(
        color: color,
        fontWeight: FontWeight.bold));
   }

   static TextStyle copBold(BuildContext context, Color color) {
   return TextStyle(
          fontFamily: "Corporate Rounded Bold Oblique",
          fontSize: AppFontSize.textSizeXLarge,
          fontWeight: FontWeight.bold
    );
   }

    static TextStyle copRound(BuildContext context, Color color) {
   return TextStyle(
          fontFamily: "Corporate Rounded Oblique",
          fontSize: AppFontSize.textSizeSMedium,
    );
  }

  static TextStyle copRregular(BuildContext context, Color color) {
   return TextStyle(
          fontFamily: "Corporate Rounded Regular",
          fontSize: 24//AppFontSize.textSizeXLarge,
    );
  }

  static TextStyle spinkerR(BuildContext context, Color color) {
   return TextStyle(
          fontFamily: "Spinnaker-Regular",
          fontSize: AppFontSize.textSizeXLarge,
          fontWeight: FontWeight.bold
    );
  }






}