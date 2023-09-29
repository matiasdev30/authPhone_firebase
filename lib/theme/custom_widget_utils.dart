import 'package:flutter/material.dart';
import '../utils/const.dart';

neonButton( {required Function onTap,
   double width = 100,
   double height = 40,
   Color shadowColor = backgroundColor,
  Widget widget = const SizedBox()}){
  return GestureDetector(
    onTap: (){
      onTap();
    },
    child: Container(
            height: height,
            width: width,
            decoration: BoxDecoration(color: activeColor, boxShadow: <BoxShadow>[
              
              
              BoxShadow(
                  color: shadowColor,
                  blurRadius: 6,
                  offset: const Offset(-2, -2)),
                   BoxShadow(
                  color: shadowColor,
                  blurRadius: 6,
                  offset: const Offset(-2, 2)),
            ]),
            child: widget,
          ),
  );
      
}
