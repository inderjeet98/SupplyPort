import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:octo_image/octo_image.dart';
import 'package:http/http.dart' as http;
import 'package:carousel_slider/carousel_controller.dart';

import '../login/login.dart';
import '../../widgets/slideanimation.dart';

class Onbording extends StatefulWidget {
  const Onbording({super.key});

  @override
  State<Onbording> createState() => _OnbordingState();
}

class _OnbordingState extends State<Onbording> {
  double? deviceHeight;
  late double deviceWidth;
  AnimationController? _animationController;

  final CarouselController _controller1 = CarouselController();
  final CarouselController _controller2 = CarouselController();
  final CarouselController _controller3 = CarouselController();

  List<String> images = [
    'assets/images/img_jakenebovsets.png',
    'assets/images/img_jakenebovsets_534x375.png',
    'assets/images/img_jakenebovsets_563x375.png'
  ];

  List<Widget> indicators = [];

  Widget _indicator(bool isActive) {
    return AnimatedContainer(
        duration: Duration(milliseconds: 300),
        height: 6,
        width: isActive ? 25 : 5,
        margin: EdgeInsets.only(right: 5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: isActive ? Color(0xFFFB2A59) : Color(0xFF7E152D),
        ));
  }

  @override
  Widget build(BuildContext context) {
    deviceHeight = MediaQuery.of(context).size.height / 1.5;
    deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      // width: 376,
      // height: 921,
      //     body: SingleChildScrollView(
      //   child: Column(
      //     crossAxisAlignment: CrossAxisAlignment.stretch,
      //     children: <Widget>[
      //       Container(
      //           height: deviceHeight,
      //           width: deviceWidth,
      //           decoration: BoxDecoration(
      //             color: Color.fromRGBO(0, 0, 0, 0.20000000298023224),
      //             gradient: LinearGradient(
      //                 begin: Alignment(7.286701730890854e-8, 1.9514729976654053),
      //                 end: Alignment(-1.9514729976654053, 1.6437709859928873e-7),
      //                 colors: [
      //                   Color.fromRGBO(0, 0, 0, 1),
      //                   Color.fromRGBO(0, 0, 0, 0)
      //                 ]),
      //             image: DecorationImage(
      //               image: AssetImage('assets/images/img_jakenebovsets.png'),
      //             ),
      //           )),
      //       // new Positioned(
      //       //   top: 50,
      //       Container(
      //         // shape: RoundedRectangleBorder(
      //         //   borderRadius: BorderRadius.only(
      //         //       topLeft: Radius.circular(20), topRight: Radius.circular(20)),
      //         //   //set border radius more than 50% of height and width to make circle
      //         // ),
      //         height: 580,
      //         decoration: BoxDecoration(
      //           color: Color.fromRGBO(0, 0, 0, 0.20000000298023224),
      //           borderRadius: BorderRadius.only(
      //             topLeft: Radius.circular(30),
      //             topRight: Radius.circular(30),
      //           ),
      //           // ),
      //           boxShadow: [
      //             BoxShadow(
      //                 color: Color.fromRGBO(211, 209, 216, 0.25),
      //                 offset: Offset(18.21428680419922, 18.21428680419922),
      //                 blurRadius: 36.42857360839844)
      //           ],
      //           // color : Color.fromRGBO(255, 255, 255, 1),
      //         ),
      //         // ),
      //         child: Container(
      //           // decoration:
      //           //     BoxDecoration(borderRadius: BorderRadius.circular(50)),
      //           padding: EdgeInsets.all(10),
      //           child: Column(
      //             children: <Widget>[Text('data')],
      //           ),
      //         ),
      //       ),
      //       // ),
      //     ],
      //   ),
      // )
      body: Stack(
        children: [
          PageView(
            onPageChanged: (int page) {
              setState(() {
                currentIndex = page;
              });
            },
            controller: _pageController,
            children: const <Widget>[
              IntroPage(
                localimg:
                    'http://staging.ireckoner.com:9898/92000067/Images/Onbording.PNG',
              ),
              IntroPage(
                localimg:
                    'http://staging.ireckoner.com:9898/92000067/Images/Onbording1.PNG',
              ),
              IntroPage(
                localimg:
                    'http://staging.ireckoner.com:9898/92000067/Images/Onbording2.PNG',
              )
            ],
          ),
          SizedBox(
            height: deviceHeight,
          ),
          Positioned(
            bottom: 1.0,
            width: deviceWidth,
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20), topRight: Radius.circular(20)),
              child: Container(
                height: MediaQuery.of(context).size.height / 3,
                color: Colors.white,
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 10),
                      child: Column(
                        children: [
                          Text(
                            'Choose Your Products\n',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 24,
                                letterSpacing: 0.46000000834465027,
                                color: Colors.black),
                          ),
                          Text(
                            currentIndex == 0
                                ? "Discover New Spring Collection \nEveryday with Happyshop"
                                : currentIndex == 1
                                    ? "We connect you to your favourite online brands \nso let's browse it with Happyshop"
                                    : "We offers best comfort product \nfor you and your family",
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.black),
                          ),
                          Positioned(
                            top: MediaQuery.of(context).size.height / 1.2,
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: List.generate(
                                  3,
                                  (index) => new Container(
                                      width: currentIndex == index ? 30 : 10,
                                      height: 10,
                                      margin: EdgeInsets.only(
                                          left: 3, right: 3, top: 70),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        color: currentIndex == index
                                            ? Color.fromRGBO(29, 55, 84, 1)
                                            : Color.fromRGBO(29, 55, 84, 1)
                                                .withOpacity(0.3),
                                      )),
                                )),
                          ),
                          // ),
                        ],
                      ),
                    ),
                    currentIndex == 0
                        ? Positioned(
                            top: MediaQuery.of(context).size.width / 2.1,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        // if (currentIndex == 0) {
                                        Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                            builder: (BuildContext context) =>
                                                Login(),
                                          ),
                                        );
                                        // }
                                      },
                                      child: Container(
                                        height: 42.0,
                                        width:
                                            MediaQuery.of(context).size.width /
                                                2.7,
                                        child: Center(
                                          child: Text(
                                            "Skip",
                                            style: TextStyle(
                                                fontSize: 22,
                                                // fontWeight: FontWeight.bold,
                                                color: Color.fromRGBO(
                                                    29, 55, 84, 1)),
                                          ),
                                        ),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(30.0),
                                            border: Border.all(
                                              color:
                                                  Color.fromRGBO(29, 55, 84, 1),
                                              width: 2,
                                            ),
                                            gradient: LinearGradient(
                                                begin: Alignment.centerLeft,
                                                end: Alignment.centerRight,
                                                colors: [
                                                  Color.fromARGB(
                                                      255, 233, 234, 236),
                                                  Colors.white,
                                                ])),
                                      ),
                                    )
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    // TextButton(
                                    //   child: Text('Next'),
                                    //   onPressed: () {
                                    //     _controller.nextPage(
                                    //         duration:
                                    //             Duration(milliseconds: 300),
                                    //         curve: Curves.ease);
                                    //   },
                                    // ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 55),
                                      child: InkWell(
                                        onTap: () {
                                          // if (currentIndex == 0) {
                                          //   setState(() {
                                          //     indicators.add(_indicator(true));

                                          currentIndex = 1;
                                          onNextButtonTapped(currentIndex);
                                        },
                                        child: Container(
                                          height: 42.0,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              2.7,
                                          child: Center(
                                            child: Text(
                                              "Next",
                                              style: TextStyle(
                                                  fontSize: 22,
                                                  // fontWeight: FontWeight.bold,
                                                  color: Colors.white),
                                            ),
                                          ),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(30.0),
                                              gradient: LinearGradient(
                                                  begin: Alignment.centerLeft,
                                                  end: Alignment.centerRight,
                                                  colors: [
                                                    Color.fromARGB(
                                                        255, 35, 63, 95),
                                                    Color.fromRGBO(
                                                        29, 55, 84, 1),
                                                  ])),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          )
                        : currentIndex == 1
                            ? InkWell(
                                onTap: () {
                                  if (currentIndex == 0) {
                                    setState(() {
                                      indicators.add(_indicator(true));

                                      currentIndex = 1;
                                      onAddButtonTapped(currentIndex);
                                    });
                                  } else if (currentIndex == 1) {
                                    // setState(() {
                                    //   indicators.add(_indicator(true));
                                    //   currentIndex = 2;
                                    //   onAddButtonTapped(currentIndex);
                                    // });
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                            Login(),
                                      ),
                                    );
                                  } else if (currentIndex == 2) {
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                            Login(),
                                      ),
                                    );
                                  }
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          height: 42.0,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              2.7,
                                          child: Center(
                                            child: Text(
                                              "Skip",
                                              style: TextStyle(
                                                  fontSize: 22,
                                                  // fontWeight: FontWeight.bold,
                                                  color: Color.fromRGBO(
                                                      29, 55, 84, 1)),
                                            ),
                                          ),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(30.0),
                                              border: Border.all(
                                                color: Color.fromRGBO(
                                                    29, 55, 84, 1),
                                                width: 2,
                                              ),
                                              gradient: LinearGradient(
                                                  begin: Alignment.centerLeft,
                                                  end: Alignment.centerRight,
                                                  colors: [
                                                    Color.fromARGB(
                                                        255, 233, 234, 236),
                                                    Colors.white,
                                                  ])),
                                        ),
                                      ],
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 55),
                                          child: Container(
                                            height: 42.0,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                2.7,
                                            child: Center(
                                              child: Text(
                                                "Next",
                                                style: TextStyle(
                                                    fontSize: 22,
                                                    // fontWeight: FontWeight.bold,
                                                    color: Colors.white),
                                              ),
                                            ),
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(30.0),
                                                gradient: LinearGradient(
                                                    begin: Alignment.centerLeft,
                                                    end: Alignment.centerRight,
                                                    colors: [
                                                      Color.fromARGB(
                                                          255, 35, 63, 95),
                                                      Color.fromRGBO(
                                                          29, 55, 84, 1),
                                                    ])),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              )
                            : InkWell(
                                onTap: () {
                                  if (currentIndex == 0) {
                                    setState(() {
                                      indicators.add(_indicator(true));

                                      currentIndex = 1;
                                      onAddButtonTapped(currentIndex);
                                    });
                                  } else if (currentIndex == 1) {
                                    // setState(() {
                                    //   indicators.add(_indicator(true));
                                    //   currentIndex = 2;
                                    //   onAddButtonTapped(currentIndex);
                                    // });
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                            Login(),
                                      ),
                                    );
                                  } else if (currentIndex == 2) {
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                            Login(),
                                      ),
                                    );
                                  }
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          height: 42.0,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              2.7,
                                          child: Center(
                                            child: Text(
                                              "Skip",
                                              style: TextStyle(
                                                  fontSize: 22,
                                                  // fontWeight: FontWeight.bold,
                                                  color: Color.fromRGBO(
                                                      29, 55, 84, 1)),
                                            ),
                                          ),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(30.0),
                                              border: Border.all(
                                                color: Color.fromRGBO(
                                                    29, 55, 84, 1),
                                                width: 2,
                                              ),
                                              gradient: LinearGradient(
                                                  begin: Alignment.centerLeft,
                                                  end: Alignment.centerRight,
                                                  colors: [
                                                    Color.fromARGB(
                                                        255, 233, 234, 236),
                                                    Colors.white,
                                                  ])),
                                        ),
                                      ],
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 55),
                                          child: Container(
                                            height: 42.0,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                2.7,
                                            child: Center(
                                              child: Text(
                                                "Next",
                                                style: TextStyle(
                                                    fontSize: 22,
                                                    // fontWeight: FontWeight.bold,
                                                    color: Colors.white),
                                              ),
                                            ),
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(30.0),
                                                gradient: LinearGradient(
                                                    begin: Alignment.centerLeft,
                                                    end: Alignment.centerRight,
                                                    colors: [
                                                      Color.fromARGB(
                                                          255, 35, 63, 95),
                                                      Color.fromRGBO(
                                                          29, 55, 84, 1),
                                                    ])),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),

                    // : Container(),
                  ],
                ),
              ),
            ),
          ),
          // Container(
          //   height: deviceHeight,
          //   padding: ,
          // )
        ],
      ),
    );
  }

  PageController? _pageController;
  final _controller = new PageController();
  int currentIndex = 0;

  void onAddButtonTapped(int index) {
    // use this to animate to the page
    _pageController!.animateToPage(index,
        duration: Duration(milliseconds: 1000), curve: Curves.elasticInOut);

    // or this to jump to it without animating
    _pageController!.jumpToPage(index);
  }

  void onNextButtonTapped(int index) {
    // use this to animate to the page
    // _pageController!.animateToPage(index,
    //     duration: Duration(milliseconds: 1000), curve: Curves.elasticInOut);

    // or this to jump to it without animating
    // _pageController!.jumpToPage(index);
    _controller.nextPage(
        duration: Duration(milliseconds: 300), curve: Curves.ease);
  }
}

class IntroPage extends StatefulWidget {
  const IntroPage({
    Key? key,
    // required this.imgurl,
    // required this.blurUrl,
    this.localimg,
  }) : super(key: key);

  final String? localimg;
  @override
  _IntroPageState createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> with TickerProviderStateMixin {
  late AnimationController _animationController, animationController;
  bool dragFromLeft = false;

  double opacityLevel = 0.0;
  Animation? animation;

  @override
  void initState() {
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 400));
    animationController = AnimationController(
      duration: Duration(seconds: 1),
      vsync: this,
    );

    animation = Tween(begin: -1.0, end: 0.0).animate(CurvedAnimation(
        parent: animationController, curve: Curves.fastOutSlowIn));
    animationController.forward();
    setState(() {});
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        OctoImage(
          image: CachedNetworkImageProvider(widget.localimg!),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          errorBuilder: OctoError.icon(color: Colors.black),
          fit: BoxFit.fill,
        ),
      ],
    );
  }
}
