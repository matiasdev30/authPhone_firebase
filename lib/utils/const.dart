import 'package:flutter/material.dart';

LinearGradient backGroundGradient ({bool isButton = false})=>  LinearGradient(colors: const <Color> [
                  Color(0xffDD2EFF),
                  Color(0xffA39FFE),
                ], begin: isButton == true ? Alignment.topRight : Alignment.topCenter, end: isButton == true ? Alignment.bottomRight : Alignment.bottomCenter);

const Color backgroundColor = Color(0xff0A1727);

const Color activeColor = Color(0xff0074EB);