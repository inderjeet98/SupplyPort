import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:jiffy/jiffy.dart';
import 'package:intl/intl.dart';

//models import
import '../../model/popular_brand.dart';
import '../../model/popular_categories.dart';

//screen import
import '../home/home.dart';
import '../cart/cart.dart';
import '../product_details/product_details.dart';
import '../products/products.dart';

class PromoOffersList extends StatefulWidget {
  PromoOffersList({required this.title, super.key});
  String? title;

  @override
  State<PromoOffersList> createState() => _PromoOffersListState();
}

class _PromoOffersListState extends State<PromoOffersList> {
  List<PopularBrands> pBrands = [];
  List<PopularCategories> popularCat = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
          // mainAxisAlignment: MainAxisAlignment.center,
          // crossAxisAlignment: CrossAxisAlignment.center,
          child: Column(
            children: [
              Text(
                widget.title.toString(),
                textAlign: TextAlign.left,
                style: const TextStyle(
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
        centerTitle: true,
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
                  builder: (BuildContext context) => Products(),
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
                      builder: (BuildContext context) => const Products(),
                    ),
                  );
                },
                tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
              ),
            ),
            // ),
          ),
        ),
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.only(right: 25, top: 8, bottom: 8),
            child: GestureDetector(
              onTap: () {},
              child: Container(
                height: 25,
                width: 35,
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
                    Icons.shopping_cart_outlined,
                    color: Color.fromARGB(
                        255, 226, 81, 45), // Change Custom Drawer Icon Color
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) => Cart(),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ],
        // actionsIconTheme: IconThemeData(
        //     size: 20.0, color: Color.fromRGBO(255, 255, 255, 1), opacity: 10.0),
      ),
    );
  }
}
