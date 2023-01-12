import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../onbording/onbording.dart';
import '../login/login.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    startTime();
  }

  double? deviceHeight;
  late double deviceWidth;
  @override
  Widget build(BuildContext context) {
    // deviceHeight = MediaQuery.of(context).size.height;
    // deviceWidth = MediaQuery.of(context).size.width;
    // return SafeArea(
    //   child: Scaffold(
    //     backgroundColor: ColorConstant.whiteA700,
    //     body: Column(
    //       mainAxisSize: MainAxisSize.min,
    //       mainAxisAlignment: MainAxisAlignment.start,
    //       children: [
    //         Align(
    //           alignment: Alignment.centerLeft,
    //           child: Container(
    //             height: getVerticalSize(
    //               161.00,
    //             ),
    //             width: getHorizontalSize(
    //               375.00,
    //             ),
    //             child: Stack(
    //               alignment: Alignment.topLeft,
    //               children: [
    //                 Align(
    //                   alignment: Alignment.bottomLeft,
    //                   child: Container(
    //                     height: getVerticalSize(
    //                       153.00,
    //                     ),
    //                     width: getHorizontalSize(
    //                       54.00,
    //                     ),
    //                     margin: getMargin(
    //                       left: 77,
    //                       top: 10,
    //                       right: 77,
    //                     ),
    //                     decoration: BoxDecoration(
    //                       color: ColorConstant.teal201,
    //                     ),
    //                   ),
    //                 ),
    //                 Align(
    //                   alignment: Alignment.topLeft,
    //                   child: Padding(
    //                     padding: getPadding(
    //                       bottom: 10,
    //                     ),
    //                     child: CommonImageView(
    //                       imagePath: ImageConstant.img1lightsplashscreen40x375,
    //                       height: getVerticalSize(
    //                         40.00,
    //                       ),
    //                       width: getHorizontalSize(
    //                         375.00,
    //                       ),
    //                     ),
    //                   ),
    //                 ),
    //               ],
    //             ),
    //           ),
    //         ),
    //         Align(
    //           alignment: Alignment.centerLeft,
    //           child: Padding(
    //             padding: getPadding(
    //               left: 77,
    //               top: 126,
    //               right: 77,
    //             ),
    //             child: Row(
    //               mainAxisAlignment: MainAxisAlignment.start,
    //               crossAxisAlignment: CrossAxisAlignment.center,
    //               mainAxisSize: MainAxisSize.min,
    //               children: [
    //                 CommonImageView(
    //                   svgPath: ImageConstant.imgVector,
    //                   height: getSize(
    //                     54.00,
    //                   ),
    //                   width: getSize(
    //                     54.00,
    //                   ),
    //                 ),
    //                 Padding(
    //                   padding: getPadding(
    //                     left: 78,
    //                   ),
    //                   child: CommonImageView(
    //                     svgPath: ImageConstant.imgClose,
    //                     height: getSize(
    //                       54.00,
    //                     ),
    //                     width: getSize(
    //                       54.00,
    //                     ),
    //                   ),
    //                 ),
    //               ],
    //             ),
    //           ),
    //         ),
    //         Align(
    //           alignment: Alignment.center,
    //           child: Container(
    //             height: getVerticalSize(
    //               172.00,
    //             ),
    //             width: getHorizontalSize(
    //               220.00,
    //             ),
    //             margin: getMargin(
    //               left: 77,
    //               top: 12,
    //               right: 77,
    //             ),
    //             child: Stack(
    //               alignment: Alignment.centerLeft,
    //               children: [
    //                 Align(
    //                   alignment: Alignment.center,
    //                   child: Padding(
    //                     padding: getPadding(
    //                       left: 1,
    //                       bottom: 1,
    //                     ),
    //                     child: CommonImageView(
    //                       svgPath: ImageConstant.imgVectorRed402,
    //                       height: getVerticalSize(
    //                         172.00,
    //                       ),
    //                       width: getHorizontalSize(
    //                         219.00,
    //                       ),
    //                     ),
    //                   ),
    //                 ),
    //                 Align(
    //                   alignment: Alignment.centerLeft,
    //                   child: Padding(
    //                     padding: getPadding(
    //                       top: 1,
    //                       right: 10,
    //                     ),
    //                     child: CommonImageView(
    //                       svgPath: ImageConstant.imgVectorTeal201,
    //                       height: getVerticalSize(
    //                         172.00,
    //                       ),
    //                       width: getHorizontalSize(
    //                         132.00,
    //                       ),
    //                     ),
    //                   ),
    //                 ),
    //               ],
    //             ),
    //           ),
    //         ),
    //         Align(
    //           alignment: Alignment.centerRight,
    //           child: Padding(
    //             padding: getPadding(
    //               left: 78,
    //               top: 132,
    //               right: 78,
    //             ),
    //             child: Row(
    //               mainAxisAlignment: MainAxisAlignment.end,
    //               crossAxisAlignment: CrossAxisAlignment.center,
    //               mainAxisSize: MainAxisSize.min,
    //               children: [
    //                 Padding(
    //                   padding: getPadding(
    //                     top: 44,
    //                     bottom: 45,
    //                   ),
    //                   child: CommonImageView(
    //                     svgPath: ImageConstant.imgMusic,
    //                     height: getVerticalSize(
    //                       64.00,
    //                     ),
    //                     width: getHorizontalSize(
    //                       67.00,
    //                     ),
    //                   ),
    //                 ),
    //                 Container(
    //                   height: getVerticalSize(
    //                     153.00,
    //                   ),
    //                   width: getHorizontalSize(
    //                     54.00,
    //                   ),
    //                   margin: getMargin(
    //                     left: 22,
    //                   ),
    //                   decoration: BoxDecoration(
    //                     color: ColorConstant.red403,
    //                   ),
    //                 ),
    //               ],
    //             ),
    //           ),
    //         ),
    //       ],
    //     ),
    //   ),
    // );

    return Center(
      child: Container(
          // width: 220,
          // height: 804,
          child: Stack(children: <Widget>[
        Positioned(
            top: 0,
            left: 0,
            child: Container(
                width: 54,
                height: 153,
                decoration: const BoxDecoration(
                  color: Color.fromRGBO(136, 189, 216, 1),
                ))),
        Positioned(
            top: 345.18035888671875,
            left: 0.049072265625,
            child: SvgPicture.asset('assets/images/img_vector.svg',
                semanticsLabel: 'vector')),
        // Positioned(
        //     top: 345.19671630859375,
        //     left: 0,
        //     child: SvgPicture.asset('assets/images/vector.svg',
        //         semanticsLabel: 'vector')),
        // Positioned(
        //     top: 279,
        //     left: 0.049072265625,
        //     child: SvgPicture.asset('assets/images/img_vector_teal_201.svg',
        //         semanticsLabel: 'vector')),
        Positioned(
            top: 279,
            left: 132.8580322265625,
            child: SvgPicture.asset('assets/images/img_vector_red_402.svg',
                semanticsLabel: 'vector')),
        Positioned(
            top: 651,
            left: 166,
            child: Container(
                width: 54,
                height: 153,
                decoration: const BoxDecoration(
                  color: Color.fromRGBO(239, 73, 88, 1),
                ))),
      ])),
    );
  }

  startTime() async {
    var _duration = const Duration(milliseconds: 1000);
    return Timer(_duration, navigationPage);
  }

  Future<void> navigationPage() async {
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const Login(),
        ));
  }
}
