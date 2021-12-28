import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';


class ViewHorizontalWidget extends StatelessWidget { 
  const ViewHorizontalWidget({
    Key key,
    @required double marginLeft,
    @required this.index,
    @required this.name,
    @required this.dataimage
  }) : _marginLeft = marginLeft, super(key: key);

  final double _marginLeft;
  final int index;
  final String name;
  final String dataimage;

  @override 
  Widget build(BuildContext context) {
    return Container(  
      margin: EdgeInsets.only(left: _marginLeft, right: 10),
      child: Stack(
        alignment: AlignmentDirectional.topCenter,
        children: <Widget>[
          Hero(
            tag: "$index$name",
            child: Container(
              width: 160,
              height: 200,
              decoration: BoxDecoration( 
                borderRadius: BorderRadius.circular(6),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage("$dataimage"),
                ),
              ), 
            ),
          ),
        ],
      ),
    );
  }
}