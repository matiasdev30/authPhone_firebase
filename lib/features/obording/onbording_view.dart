import 'package:authphone_firebase/utils/utils.dart';
import 'package:flutter/material.dart';

import '../../utils/const.dart';

class OnboaringView extends StatefulWidget {
  const OnboaringView({super.key});

  @override
  State<OnboaringView> createState() => _OnboaringViewState();
}

class _OnboaringViewState extends State<OnboaringView> {

  PageController pageController = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SizedBox(
        height: screenHeigth(context),
        width: screenWidth(context),

        child: PageView(
          controller: pageController,
          scrollDirection: Axis.vertical,
          children: [
            Container(
              color: Colors.red,
              child: Center(
                child: Column(
                  children: [
                    Container(
                          width: screenWidth(context) - 20,
                          height:200,
                          decoration: BoxDecoration(
                            gradient: backGroundGradient()
                          ),
                       
              ),
                  ],
                ),
              ),
            ),
            Container(
              color: Colors.yellow,
            ),
            Container(
              color: Colors.green,
              
            )
          ],
        ),
      ),
    );
  }
}