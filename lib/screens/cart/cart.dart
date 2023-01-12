import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:octo_image/octo_image.dart';
import 'package:cached_network_image/cached_network_image.dart';

//screen import
import '../home/home.dart';
import 'checkout.dart';

class Cart extends StatefulWidget {
  const Cart({super.key});

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
          // mainAxisAlignment: MainAxisAlignment.center,
          // crossAxisAlignment: CrossAxisAlignment.center,
          child: Column(
            children: const [
              Text(
                ' Cart',
                textAlign: TextAlign.left,
                style: TextStyle(
                    color: Color.fromRGBO(29, 55, 84, 1),
                    fontFamily: 'Arboria-Medium',
                    fontSize: 20,
                    letterSpacing: 0.46000000834465027,
                    fontWeight: FontWeight.normal,
                    height: 1),
              )
            ],
          ),
        ),
        centerTitle: false,
        systemOverlayStyle: SystemUiOverlayStyle.light,
        backgroundColor: const Color.fromRGBO(250, 250, 250, 1),
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.only(left: 15, top: 8, bottom: 8),
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) => Home(),
                ),
              );
            },
            child: Container(
              height: 25,
              width: 25,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(
                  Radius.circular(12.0),
                ),
                boxShadow: [
                  BoxShadow(
                    offset: Offset(0, 0),
                    blurRadius: 2,
                    spreadRadius: 2,
                    color: Color.fromRGBO(211, 209, 216, 0.25),
                  ),
                ],
              ),
              child: IconButton(
                icon: const Icon(
                  Icons.chevron_left,
                  color: Color.fromRGBO(
                      29, 55, 84, 1), // Change Custom Drawer Icon Color
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) => const Home(),
                    ),
                  );
                },
                tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
              ),
            ),
            // ),
          ),
        ),
      ),
      bottomNavigationBar: getBottomBar(),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        children: [
                          Container(
                            height: 55,
                            width: 55,
                            decoration: BoxDecoration(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(6)),
                              boxShadow: const [
                                BoxShadow(
                                    color: Color.fromRGBO(211, 209, 216, 0.25),
                                    offset: Offset(15, 15),
                                    blurRadius: 30)
                              ],
                              color: const Color.fromRGBO(255, 255, 255, 1),
                              border: Border.all(
                                color: const Color.fromRGBO(221, 86, 92, 1),
                                width: 1,
                              ),
                            ),
                            child: const Icon(
                              Icons.shopping_cart_outlined,
                              size: 32,
                              color: Color.fromRGBO(221, 86, 92, 1),
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 8),
                            child: Text(
                              'Cart',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Color.fromRGBO(221, 86, 92, 1),
                                  fontFamily: 'Arboria-Medium',
                                  fontSize: 16,
                                  letterSpacing: 0.46000000834465027,
                                  fontWeight: FontWeight.normal,
                                  height: 1),
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Container(
                            width: 76,
                            height: 6,
                            decoration: const BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              color: Color.fromRGBO(
                                  147, 187, 213, 0.30000001192092896),
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 8),
                            child: Text(
                              ' ',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Color.fromRGBO(
                                      29, 55, 84, 0.699999988079071),
                                  fontFamily: 'Arboria-Medium',
                                  fontSize: 16,
                                  letterSpacing: 0.46000000834465027,
                                  fontWeight: FontWeight.normal,
                                  height: 1),
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Container(
                            height: 55,
                            width: 55,
                            decoration: const BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(6)),
                              boxShadow: [
                                BoxShadow(
                                    color: Color.fromRGBO(211, 209, 216, 0.25),
                                    offset: Offset(15, 15),
                                    blurRadius: 30)
                              ],
                              color: Color.fromRGBO(255, 255, 255, 1),
                            ),
                            child: const Icon(
                              Icons.credit_card_outlined,
                              size: 32,
                              color:
                                  Color.fromRGBO(29, 55, 84, 0.699999988079071),
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 8),
                            child: Text(
                              'Checkout',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Color.fromRGBO(
                                      29, 55, 84, 0.699999988079071),
                                  fontFamily: 'Arboria-Medium',
                                  fontSize: 16,
                                  letterSpacing: 0.46000000834465027,
                                  fontWeight: FontWeight.normal,
                                  height: 1),
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Container(
                            width: 76,
                            height: 6,
                            decoration: const BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              color: Color.fromRGBO(
                                  147, 187, 213, 0.30000001192092896),
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 8),
                            child: Text(
                              ' ',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Color.fromRGBO(
                                      29, 55, 84, 0.699999988079071),
                                  fontFamily: 'Arboria-Medium',
                                  fontSize: 16,
                                  letterSpacing: 0.46000000834465027,
                                  fontWeight: FontWeight.normal,
                                  height: 1),
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Container(
                            height: 55,
                            width: 55,
                            decoration: const BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(6),
                                topRight: Radius.circular(6),
                                bottomLeft: Radius.circular(6),
                                bottomRight: Radius.circular(6),
                              ),
                              boxShadow: [
                                BoxShadow(
                                    color: Color.fromRGBO(211, 209, 216, 0.25),
                                    offset: Offset(15, 15),
                                    blurRadius: 30)
                              ],
                              color: Color.fromRGBO(255, 255, 255, 1),
                            ),
                            child: const Icon(
                              Icons.task_alt_outlined,
                              size: 32,
                              color:
                                  Color.fromRGBO(29, 55, 84, 0.699999988079071),
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 8),
                            child: Text(
                              'Order \n'
                              'Reserved',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Color.fromRGBO(
                                      29, 55, 84, 0.699999988079071),
                                  fontFamily: 'Arboria-Medium',
                                  fontSize: 16,
                                  letterSpacing: 0.46000000834465027,
                                  fontWeight: FontWeight.normal,
                                  height: 1),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [],
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: Divider(
                      color: Color.fromRGBO(29, 55, 84, 1), thickness: 1),
                ),
                _getHeading('Your Items')
              ],
            ),
          ),
        ),
      ),
    );
  }

  _getHeading(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                title,
                textAlign: TextAlign.left,
                style: const TextStyle(
                  color: Color.fromRGBO(29, 55, 84, 1),
                  fontFamily: 'Arboria-Medium',
                  fontSize: 20,
                  letterSpacing: 0.46000000834465027,
                  fontWeight: FontWeight.normal,
                  height: 1,
                ),

                // Theme.of(context).textTheme.headline6,
              ),
            ],
          ),
        ],
      ),
    );
  }

  double price = 0;
  getBottomBar() {
    return Container(
      height: 70,
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        // mainAxisSize: MainAxisSize.max,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 10, left: 10),
                child: Text(
                  '$itmQty Items',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      color: Color.fromRGBO(29, 55, 84, 1),
                      fontFamily: 'Arboria-Medium',
                      fontSize: 18,
                      letterSpacing: 0.46000000834465027,
                      fontWeight: FontWeight.normal,
                      height: 1),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10, bottom: 6, left: 10),
                child: Text(
                  'Rs. ${(price * itmQty).toStringAsFixed(2)}/-',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      color: Color.fromRGBO(29, 55, 84, 1),
                      fontFamily: 'Arboria-Medium',
                      fontSize: 24,
                      letterSpacing: 0.46000000834465027,
                      fontWeight: FontWeight.normal,
                      height: 1),
                ),
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 10, bottom: 10, right: 20),
                child: Container(
                  width: 150,
                  height: 46,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(28.5)),
                    boxShadow: [
                      BoxShadow(
                          color:
                              Color.fromRGBO(29, 55, 84, 0.10000000149011612),
                          offset: Offset(0, 20),
                          blurRadius: 30)
                    ],
                    color: Color.fromRGBO(221, 86, 92, 1),
                  ),
                  child: InkWell(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text(
                          'CHECKOUT',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Color.fromRGBO(255, 255, 255, 1),
                              fontFamily: 'Arboria-Medium',
                              fontSize: 16,
                              letterSpacing:
                                  0 /*percentages not used in flutter. defaulting to zero*/,
                              fontWeight: FontWeight.normal,
                              height: 1),
                        ),
                        Icon(
                          Icons.chevron_right_outlined,
                          color: Color.fromRGBO(255, 255, 255, 1),
                        ),
                      ],
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) => const Checkout(),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  int itmQty = 0;
  void removeItem() {}
  void addQty() {}
}
