// ignore_for_file: prefer_typing_uninitialized_variables, duplicate_ignore

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
// ignore: depend_on_referenced_packages
import 'package:octo_image/octo_image.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'dart:convert';
import 'package:jiffy/jiffy.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:shared_preferences/shared_preferences.dart';

//screens import
import '../products/products.dart';
import '../cart/cart.dart';
import '../product_details/product_details.dart';
import '../trending_products/trending_products.dart';
import '../promos&offers/promo_offers.dart';

//carusole loader
import '../../widgets/components/carousel_loading.dart';

//models import
import '../../model/items_api_model.dart';
import '../../model/topselling_items.dart';
import '../../model/promooffer.dart';
import '../../model/recent_pruchase_items.dart';
import '../../model/subcategory.dart';
import '../../model/total_outstanding.dart';
import '../../model/overdue_amount.dart';

//extenstion
import '../../widgets/extenstions.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with TickerProviderStateMixin {
  final _controller = PageController();
  List<ServiceData> itemArr = [];
  List<TopSellingitems> topSell = [];
  List<TotalOutstanding> totalOutStanding = [];
  List<OverdueAmount> overdueAmount = [];
  List<OverdueDays> overdueDays = [];
  List<PromoOffers> promoOffers = [];
  List<RecentPurchaseItems> recentitems = [];
  List<SubCategory> subCategory = [];

  late AnimationController _xController;
  late AnimationController _yController;

  bool isHomePageSelected = true;
  bool isProductPageSelected = false;

  @override
  void initState() {
    _xController = AnimationController(
        vsync: this, animationBehavior: AnimationBehavior.preserve);
    _yController = AnimationController(
        vsync: this, animationBehavior: AnimationBehavior.preserve);

    Listenable.merge([_xController, _yController]).addListener(() {
      setState(() {});
    });
    super.initState();
    apiCall();
    totalOutStand();
    promoOffersList();
    recentPurchaseItemsList();
    overDues();
    overDueDays();
    _getPartyNameId();
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  // ignore: prefer_typing_uninitialized_variables
  var partyName;
  var partyId;
  _getPartyNameId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      partyName = prefs.getString('PartyName');
      partyId = prefs.getString('PartyId');
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Supply Port',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: Column(
            children: [
              const Text(
                "Welcome",
                style: TextStyle(
                    color: Color.fromRGBO(147, 187, 213, 1),
                    fontFamily: 'Arboria-Medium',
                    fontSize: 14,
                    letterSpacing:
                        0 /*percentages not used in flutter. defaulting to zero*/,
                    fontWeight: FontWeight.normal,
                    height: 1.5),
              ),
              FutureBuilder(
                  future: _getPartyNameId(),
                  builder: (context, snapshot) {
                    return Text(
                      " @$partyName",
                      style: TextStyle(
                          color: Color.fromRGBO(29, 55, 84, 1),
                          fontFamily: 'Arboria-Medium',
                          fontSize: 15,
                          letterSpacing:
                              0 /*percentages not used in flutter. defaulting to zero*/,
                          fontWeight: FontWeight.normal,
                          height: 1.5),
                    );
                  })
            ],
          ),
          centerTitle: true,
          systemOverlayStyle: SystemUiOverlayStyle.light,
          backgroundColor: const Color.fromRGBO(250, 250, 250, 1),
          elevation: 0,
          leading: Padding(
            padding: const EdgeInsets.only(left: 10, top: 8, bottom: 8),
            child: GestureDetector(
              onTap: () => _scaffoldKey.currentState!.openDrawer(),
              child: Container(
                height: 30,
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
                    Icons.short_text_outlined,
                    color: Color.fromRGBO(
                        29, 55, 84, 1), // Change Custom Drawer Icon Color
                  ),
                  onPressed: () => _scaffoldKey.currentState!.openDrawer(),
                  tooltip:
                      MaterialLocalizations.of(context).openAppDrawerTooltip,
                ),
              ),
              // ),
            ),
          ),
        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: const [
              DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.blue,
                ),
                child: Text('Drawer Header'),
              ),
            ],
          ),
        ),
        // extendBodyBehindAppBar: true,
        bottomNavigationBar: getBottomBar(),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 18),
            child: Column(
              children: [
                //Dashboard
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5),
                  child: _getDashboard(),
                ),

                //Previous bought items
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: _getHeading("Previous Bought Items"),
                ),
                Container(
                  height: 267,
                  // width: 266,
                  decoration: const BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                          color: Color.fromRGBO(211, 209, 216, 0.25),
                          // offset: Offset(15, 15),
                          blurRadius: 30)
                    ],
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: FutureBuilder(
                      future: recentPurchaseItemsList(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return ListView.builder(
                              scrollDirection: Axis.horizontal,
                              // children: <Widget>[
                              itemCount: recentitems[0].data.length,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.only(
                                      left: 2.5, right: 2.5),
                                  child: Card(
                                    elevation: 3,
                                    color: const Color.fromRGBO(
                                        29, 55, 84, 0.10000000149011612),
                                    shape: RoundedRectangleBorder(
                                      side: const BorderSide(
                                          color: Colors.white70, width: 5),
                                      borderRadius: BorderRadius.circular(28.5),
                                    ),
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 10, horizontal: 15),
                                      width: MediaQuery.of(context).size.width /
                                          1.48,
                                      decoration: const BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(15),
                                          topRight: Radius.circular(15),
                                          bottomLeft: Radius.circular(15),
                                          bottomRight: Radius.circular(15),
                                        ),
                                        // boxShadow: [
                                        //   BoxShadow(
                                        //       color: Color.fromRGBO(
                                        //           211, 209, 216, 0.25),
                                        //       offset: Offset(15, 15),
                                        //       blurRadius: 30)
                                        // ],
                                      ),
                                      child: SizedBox(
                                        height: 10,
                                        child: Stack(
                                          children: <Widget>[
                                            InkWell(
                                              onTapDown: (details) {
                                                Navigator.pushReplacement(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (BuildContext
                                                            context) =>
                                                        ProductDetails(
                                                            recentitems[0]
                                                                .data[index]
                                                                .itemId
                                                                .toString()),
                                                  ),
                                                );
                                              },
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: <Widget>[
                                                  Expanded(
                                                    child: Stack(
                                                      alignment:
                                                          Alignment.topLeft,
                                                      children: [
                                                        ClipRRect(
                                                          borderRadius:
                                                              const BorderRadius
                                                                      .only(
                                                                  topLeft: Radius
                                                                      .circular(
                                                                          5),
                                                                  topRight: Radius
                                                                      .circular(
                                                                          5)),
                                                          child: OctoImage(
                                                            image: CachedNetworkImageProvider(
                                                                'http://staging.ireckoner.com:9898/92000067/Images/Item_${recentitems[0].data[index].itemId}.PNG'),
                                                            placeholderBuilder:
                                                                OctoPlaceholder
                                                                    .blurHash(
                                                              'LhL4yx%2x^WV~pkCWCWBR:WVRPof',
                                                            ),
                                                            width: double
                                                                .maxFinite,
                                                            height: 133,
                                                            errorBuilder:
                                                                (context, url,
                                                                        error) =>
                                                                    Image.asset(
                                                              "assets/images/product.png",
                                                              fit: BoxFit
                                                                  .fitHeight,
                                                              // height: 60.0,
                                                              // width: 66.0,
                                                            ),
                                                            fit: BoxFit
                                                                .fitHeight,
                                                          ),
                                                        ),
                                                        Container(
                                                          height: 28,
                                                          decoration:
                                                              const BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            6)),
                                                            boxShadow: [
                                                              BoxShadow(
                                                                  color: Color
                                                                      .fromRGBO(
                                                                          147,
                                                                          187,
                                                                          213,
                                                                          0.20000000298023224),
                                                                  offset: Offset(
                                                                      0,
                                                                      5.847456932067871),
                                                                  blurRadius:
                                                                      23.389827728271484)
                                                            ],
                                                            color:
                                                                Color.fromRGBO(
                                                                    182,
                                                                    226,
                                                                    244,
                                                                    1),
                                                          ),
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    left: 5,
                                                                    right: 5),
                                                            child: Row(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .min,
                                                              children: [
                                                                Text(
                                                                  '₹  ${recentitems[0].data[index].salesPrice!.toString()}/-',
                                                                  style: const TextStyle(
                                                                      color: Color.fromRGBO(
                                                                          29,
                                                                          55,
                                                                          84,
                                                                          1),
                                                                      fontFamily:
                                                                          'Arboria-Medium',
                                                                      fontSize:
                                                                          14,
                                                                      letterSpacing:
                                                                          0.46000000834465027,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .normal,
                                                                      height:
                                                                          1),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            bottom: 1),
                                                    child: Row(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      children: <Widget>[
                                                        Expanded(
                                                          child: Text(
                                                            recentitems[0]
                                                                .data[index]
                                                                .itemName
                                                                .toString()
                                                                .toTitleCase(),
                                                            style: const TextStyle(
                                                                color: Color
                                                                    .fromRGBO(
                                                                        29,
                                                                        55,
                                                                        84,
                                                                        1),
                                                                fontFamily:
                                                                    'Arboria-Medium',
                                                                fontSize: 15,
                                                                letterSpacing:
                                                                    0 /*percentages not used in flutter. defaulting to zero*/,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .normal,
                                                                height: 1),
                                                            maxLines: 1,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 1.0,
                                                            bottom: 55),
                                                    child: SizedBox(
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width /
                                                              1.49,
                                                      child: Row(
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: <Widget>[
                                                          Text(
                                                            recentitems[0]
                                                                .data[index]
                                                                .uom
                                                                .toString(),
                                                            style: const TextStyle(
                                                                color: Color
                                                                    .fromRGBO(
                                                                        125,
                                                                        131,
                                                                        145,
                                                                        1),
                                                                fontFamily:
                                                                    'Arboria-Medium',
                                                                fontSize: 12,
                                                                letterSpacing:
                                                                    0 /*percentages not used in flutter. defaulting to zero*/,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .normal,
                                                                height: 1),
                                                          ),
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            children: [
                                                              const Padding(
                                                                padding: EdgeInsets
                                                                    .only(
                                                                        right:
                                                                            3),
                                                                child: Icon(
                                                                  Icons
                                                                      .calendar_today_outlined,
                                                                  color: Color
                                                                      .fromRGBO(
                                                                          221,
                                                                          86,
                                                                          92,
                                                                          1),
                                                                  size: 15,
                                                                ),
                                                              ),
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .only(
                                                                        right:
                                                                            10),
                                                                child: Text(
                                                                  DateFormat(
                                                                          'd MMMM y')
                                                                      .format(recentitems[
                                                                              0]
                                                                          .data[
                                                                              index]
                                                                          .docDate)
                                                                      .toString(),
                                                                  textAlign:
                                                                      TextAlign
                                                                          .right,
                                                                  style: const TextStyle(
                                                                      color: Color.fromRGBO(
                                                                          125,
                                                                          131,
                                                                          145,
                                                                          1),
                                                                      fontFamily:
                                                                          'Arboria-Medium',
                                                                      fontSize:
                                                                          12,
                                                                      letterSpacing:
                                                                          0 /*percentages not used in flutter. defaulting to zero*/,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .normal,
                                                                      height:
                                                                          1),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          // Text(
                                                          //   CUR_CURRENCY + "",
                                                          //   style: Theme.of(context).textTheme.overline!.copyWith(
                                                          //       decoration: TextDecoration.lineThrough,
                                                          //       letterSpacing: 1),
                                                          // ),
                                                        ],
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                              onTap: () {
                                                // Navigator.of(context).push(
                                                //   PageRouteBuilder(
                                                //     transitionDuration: Duration(milliseconds: 1000),
                                                //     pageBuilder: (BuildContext context, Animation<double> animation,
                                                //         Animation<double> secondaryAnimation) {
                                                //       return HappyShopProductDetail(
                                                //         itemId: widget.itemId,
                                                //         itemName: widget.itemname,
                                                //         salePrice: widget.price,
                                                //         mrp: widget.mrp,
                                                //         imagelisturl: widget.imagelisturl,
                                                //         imgurl: widget.imagurl,
                                                //         tag: widget.tag,
                                                //         localimg: widget.localimg,
                                                //       );
                                                //     },
                                                //     reverseTransitionDuration: Duration(milliseconds: 800),
                                                //   ),
                                                // );
                                              },
                                            ),
                                            Positioned(
                                              bottom: 1,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  1.68,
                                              child: InkWell(
                                                onTap: () {
                                                  //       Navigator.pushReplacement(
                                                  //   context,
                                                  //   MaterialPageRoute(
                                                  //     builder: (BuildContext context) => Home(),
                                                  //   ),
                                                  // );
                                                },
                                                child: Container(
                                                  height: 42.0,
                                                  width: double.maxFinite,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            28.5),
                                                    boxShadow: const [
                                                      BoxShadow(
                                                          color: Color.fromRGBO(
                                                              29,
                                                              55,
                                                              84,
                                                              0.10000000149011612),
                                                          offset: Offset(0, 20),
                                                          blurRadius: 30)
                                                    ],
                                                    color: const Color.fromRGBO(
                                                        221, 86, 92, 1),
                                                  ),
                                                  child: const Center(
                                                    child: Text(
                                                      "REORDER",
                                                      style: TextStyle(
                                                          color: Color.fromRGBO(
                                                              255, 255, 255, 1),
                                                          fontFamily:
                                                              'Arboria-Medium',
                                                          fontSize: 16,
                                                          letterSpacing:
                                                              0 /*percentages not used in flutter. defaulting to zero*/,
                                                          fontWeight:
                                                              FontWeight.normal,
                                                          height: 1),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              }
                              // ],
                              );
                        } else if (snapshot.hasError) {
                          return Text('${snapshot.error}');
                        }
                        // By default, show a loading spinner.
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }),
                ),

                // Promos
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: _getHeading("Promos & Offers Curated for you"),
                ),
                SizedBox(
                  width: double.infinity,
                  // margin: EdgeInsets.only(
                  //     bottom: 0, top: kToolbarHeight, right: 0, left: 0),
                  child: _Carouselsliders(),
                ),

                //Rewards
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: _getRewardsHeading("Chances to earn more rewards"),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Container(
                    height: 200,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(12),
                        topRight: Radius.circular(12),
                        bottomLeft: Radius.circular(12),
                        bottomRight: Radius.circular(12),
                      ),
                      boxShadow: [
                        BoxShadow(
                            color: Color.fromRGBO(0, 0, 0, 0.46000000834465027),
                            offset: Offset(0, 4),
                            blurRadius: 30)
                      ],
                      color: Color.fromRGBO(223, 235, 242, 1),
                    ),
                    child: Row(
                      children: [
                        Column(
                          children: [
                            Container(
                              height: 200,
                              width: MediaQuery.of(context).size.width / 2.1,
                              decoration: const BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(12),
                                  bottomLeft: Radius.circular(12),
                                ),
                                color: Color.fromRGBO(223, 235, 242, 1),
                              ),
                              child: Stack(children: const [
                                Positioned(
                                  top: 60,
                                  left: 50,
                                  child: Align(
                                    alignment: AlignmentDirectional.center,
                                    child: Text(
                                      'Your Points',
                                      textAlign: TextAlign.right,
                                      style: TextStyle(
                                          color: Color.fromRGBO(29, 55, 84, 1),
                                          fontFamily: 'Arboria-Medium',
                                          fontSize: 18,
                                          letterSpacing:
                                              0 /*percentages not used in flutter. defaulting to zero*/,
                                          fontWeight: FontWeight.normal,
                                          height: 1),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  top: 95,
                                  left: 60,
                                  child: Text(
                                    '600',
                                    style: TextStyle(
                                        color: Color.fromRGBO(29, 55, 84, 1),
                                        fontFamily: 'Arboria-Medium',
                                        fontSize: 40,
                                        letterSpacing:
                                            0 /*percentages not used in flutter. defaulting to zero*/,
                                        fontWeight: FontWeight.normal,
                                        height: 1),
                                  ),
                                ),
                              ]),
                            )
                          ],
                        ),
                        Column(
                          children: [
                            Container(
                              height: 200,
                              width: MediaQuery.of(context).size.width / 2.245,
                              decoration: const BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(12),
                                  bottomRight: Radius.circular(12),
                                ),
                                // color: Color.fromARGB(255, 99, 53, 53),
                                image: DecorationImage(
                                    image:
                                        AssetImage('assets/images/Login.png'),
                                    fit: BoxFit.fitWidth),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                    // Positioned(
                    //     top: 0,
                    //     left: 168,
                    //     child: Container(
                    //         width: 182,
                    //         height: 174,
                    //         decoration: BoxDecoration(
                    //           color:
                    //               Color.fromRGBO(0, 0, 0, 0.20000000298023224),
                    //           gradient: LinearGradient(
                    //               begin: Alignment(
                    //                   7.286701730890854e-8, 1.9514729976654053),
                    //               end: Alignment(-1.9514729976654053,
                    //                   1.6437709859928873e-7),
                    //               colors: [
                    //                 Color.fromRGBO(0, 0, 0, 1),
                    //                 Color.fromRGBO(0, 0, 0, 0)
                    //               ]),
                    //           image: DecorationImage(
                    //               image: AssetImage('assets/images/Login.png'),
                    //               fit: BoxFit.fitWidth),
                    //         ))),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );

    // return MaterialApp(
    // home:
    // );
  }

  _getDashboard() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: SizedBox(
        height: 240,
        child: Column(
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  height: 180,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                    boxShadow: [
                      BoxShadow(
                          color:
                              Color.fromRGBO(207, 236, 248, 0.699999988079071),
                          offset: Offset(0, 7),
                          blurRadius: 18)
                    ],
                    color: Color.fromRGBO(255, 255, 255, 1),
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 10, left: 20),
                            child: FutureBuilder(
                                future: totalOutStand(),
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    return SizedBox(
                                      width: 160,
                                      child: Column(
                                        children: [
                                          const Text(
                                            'Total Outstanding',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                color: Color.fromRGBO(
                                                    29, 55, 84, 1),
                                                fontFamily: 'Arboria-Medium',
                                                fontSize: 16,
                                                letterSpacing:
                                                    0.46000000834465027,
                                                fontWeight: FontWeight.normal,
                                                height: 1),
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(top: 15),
                                            child: FittedBox(
                                              fit: BoxFit.fitWidth,
                                              child: Text(
                                                //.truncate() for remove decimal
                                                'Rs. ${totalOutStanding[0].data[0].sumClosing.truncate()}',
                                                textAlign: TextAlign.center,
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 1,
                                                softWrap: false,
                                                style: const TextStyle(
                                                    color: Color.fromRGBO(
                                                        29, 55, 84, 1),
                                                    fontFamily:
                                                        'Arboria-Medium',
                                                    fontSize: 20,
                                                    letterSpacing: 0,
                                                    fontWeight:
                                                        FontWeight.normal,
                                                    height: 0.8571428571428571),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    );
                                  } else if (snapshot.hasError) {
                                    return Text('${snapshot.error}');
                                  }
                                  // By default, show a loading spinner.
                                  return const Center(
                                    child: CircularProgressIndicator(),
                                  );
                                }),
                          ),
                          // repeat order button
                          Padding(
                            padding: const EdgeInsets.only(top: 20, right: 20),
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 20),
                                  child: Container(
                                    height: 60,
                                    width: 130,
                                    decoration: const BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(12),
                                      ),
                                      boxShadow: [
                                        BoxShadow(
                                            color: Color.fromRGBO(207, 236, 248,
                                                0.699999988079071),
                                            offset: Offset(0, 7),
                                            blurRadius: 18)
                                      ],
                                      color: Color.fromRGBO(
                                          221, 86, 92, 0.8999999761581421),
                                    ),
                                    child: const Center(
                                      child: Text(
                                        'REPEAT LAST ORDER',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: Color.fromRGBO(
                                                255, 255, 255, 1),
                                            fontFamily: 'Arboria-Medium',
                                            fontSize: 12,
                                            letterSpacing:
                                                0 /*percentages not used in flutter. defaulting to zero*/,
                                            fontWeight: FontWeight.normal,
                                            height: 1),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Positioned(
                  top: 100,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // overdue amount
                          Padding(
                            padding: const EdgeInsets.only(left: 8),
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 10, top: 20, right: 8),
                                  child: Container(
                                    height: 100,
                                    width:
                                        MediaQuery.of(context).size.width / 2.5,
                                    decoration: const BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(12),
                                      ),
                                      boxShadow: [
                                        BoxShadow(
                                            color: Color.fromRGBO(207, 236, 248,
                                                0.699999988079071),
                                            offset: Offset(0, 7),
                                            blurRadius: 18)
                                      ],
                                      color: Color.fromRGBO(255, 255, 255, 1),
                                    ),
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              top: 20, left: 10, right: 10),
                                          child: FutureBuilder(
                                              future: overDues(),
                                              builder: (context, snapshot) {
                                                if (snapshot.hasData) {
                                                  return Text(
                                                    'Rs. ${overdueAmount[0].data[0].dueAmount.truncate()}',
                                                    textAlign: TextAlign.left,
                                                    style: const TextStyle(
                                                        color: Color.fromRGBO(
                                                            43, 146, 153, 1),
                                                        fontFamily:
                                                            'Arboria-Medium',
                                                        fontSize: 24,
                                                        letterSpacing: 0,
                                                        fontWeight:
                                                            FontWeight.normal,
                                                        height: 1),
                                                  );
                                                } else if (snapshot.hasError) {
                                                  return Text(
                                                      '${snapshot.error}');
                                                }
                                                // By default, show a loading spinner.
                                                return const Center(
                                                  child:
                                                      CircularProgressIndicator(),
                                                );
                                              }),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              top: 10, left: 15),
                                          child: Row(
                                            children: const [
                                              Icon(
                                                Icons.circle,
                                                color: Color.fromRGBO(
                                                    110, 180, 184, 1),
                                                size: 15,
                                              ),
                                              Text(
                                                '  Overdue Amount',
                                                textAlign: TextAlign.left,
                                                style: TextStyle(
                                                    color: Color.fromRGBO(
                                                        121, 136, 163, 1),
                                                    fontFamily:
                                                        'Arboria-Medium',
                                                    fontSize: 12,
                                                    letterSpacing: 0,
                                                    fontWeight:
                                                        FontWeight.normal,
                                                    height: 1),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          // overdue days
                          Padding(
                            padding: const EdgeInsets.only(right: 8, left: 7),
                            child: Column(
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.only(top: 20, right: 10),
                                  child: Container(
                                    height: 100,
                                    width:
                                        MediaQuery.of(context).size.width / 2.5,
                                    decoration: const BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(12),
                                      ),
                                      boxShadow: [
                                        BoxShadow(
                                            color: Color.fromRGBO(207, 236, 248,
                                                0.699999988079071),
                                            offset: Offset(0, 7),
                                            blurRadius: 18)
                                      ],
                                      color: Color.fromRGBO(255, 255, 255, 1),
                                    ),
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              top: 20, left: 10, right: 10),
                                          child: FutureBuilder(
                                              future: overDueDays(),
                                              builder: (context, snapshot) {
                                                if (snapshot.hasData) {
                                                  return Text(
                                                    '${overdueDays[0].data[0].overdueDays} days left',
                                                    textAlign: TextAlign.left,
                                                    style: const TextStyle(
                                                        color: Color.fromRGBO(
                                                            221, 86, 92, 1),
                                                        fontFamily:
                                                            'Arboria-Medium',
                                                        fontSize: 24,
                                                        letterSpacing: 0,
                                                        fontWeight:
                                                            FontWeight.normal,
                                                        height: 1),
                                                  );
                                                } else if (snapshot.hasError) {
                                                  return Text(
                                                      '${snapshot.error}');
                                                }

                                                return const Center(
                                                  child:
                                                      CircularProgressIndicator(),
                                                );
                                              }),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              top: 10, left: 15),
                                          child: Row(
                                            children: const [
                                              Icon(
                                                Icons.circle,
                                                color: Color.fromRGBO(
                                                    221, 86, 92, 1),
                                                size: 15,
                                              ),
                                              Text(
                                                '  Overdue',
                                                textAlign: TextAlign.left,
                                                style: TextStyle(
                                                  color: Color.fromRGBO(
                                                      121, 136, 163, 1),
                                                  fontFamily: 'Arboria-Medium',
                                                  fontSize: 12,
                                                  letterSpacing: 0,
                                                  fontWeight: FontWeight.normal,
                                                  height: 1,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                      InkWell(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          child: Row(
                            children: const [
                              Text(
                                'View transactions',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Color.fromRGBO(29, 55, 84, 1),
                                    fontFamily: 'Arboria-Medium',
                                    fontSize: 16,
                                    letterSpacing: 0.46000000834465027,
                                    fontWeight: FontWeight.normal,
                                    height: 1),
                              ),
                              Icon(
                                Icons.chevron_right_outlined,
                                color: Color.fromRGBO(221, 86, 92, 1),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  _getHeading(
    String title,
  ) {
    return Padding(
      padding: const EdgeInsets.only(top: 15.0, bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                title,
                textAlign: TextAlign.right,
                style: const TextStyle(
                    color: Color.fromRGBO(29, 55, 84, 1),
                    fontFamily: 'Arboria-Medium',
                    fontSize: 18,
                    letterSpacing:
                        0 /*percentages not used in flutter. defaulting to zero*/,
                    fontWeight: FontWeight.normal,
                    height: 1),

                // Theme.of(context).textTheme.headline6,
              ),
              InkWell(
                child: Row(
                  children: const [
                    Text(
                      'ViewAll',
                      textAlign: TextAlign.right,
                      style: TextStyle(
                          color: Color.fromRGBO(221, 86, 92, 1),
                          fontFamily: 'Arboria-Medium',
                          fontSize: 13,
                          letterSpacing:
                              0 /*percentages not used in flutter. defaulting to zero*/,
                          fontWeight: FontWeight.normal,
                          height: 1),
                    ),
                    Icon(
                      Icons.chevron_right_outlined,
                      color: Color.fromRGBO(221, 86, 92, 1),
                    ),
                  ],
                ),
                // color: Color.fromRGBO(221, 86, 92, 1),
                onTap: () {
                  Navigator.push(
                    context,
                    // PageRouteBuilder(
                    //     transitionDuration: Duration(seconds: 1),
                    //     pageBuilder: () => HappyShopStaggeredList()),
                    MaterialPageRoute(
                      builder: (BuildContext context) =>
                          // (title == 'Popular Brands' ||
                          //         title == 'Popular Categories')
                          title.contains('Previous Bought Items')
                              ? TrendingProducts(
                                  title: title,
                                )
                              : PromoOffersList(
                                  title: title,
                                ),
                    ),
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  _getRewardsHeading(
    String title,
  ) {
    return Padding(
      padding: const EdgeInsets.only(top: 15.0, bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                title,
                textAlign: TextAlign.right,
                style: const TextStyle(
                    color: Color.fromRGBO(29, 55, 84, 1),
                    fontFamily: 'Arboria-Medium',
                    fontSize: 18,
                    letterSpacing:
                        0 /*percentages not used in flutter. defaulting to zero*/,
                    fontWeight: FontWeight.normal,
                    height: 1),

                // Theme.of(context).textTheme.headline6,
              ),
            ],
          ),
        ],
      ),
    );
  }

  int _curSelected = 2;

  // ignore: constant_identifier_names
  static const IconData shopping_cart =
      IconData(0xe59c, fontFamily: 'MaterialIcons');
  getBottomBar() {
    return BottomAppBar(
      child: ClipRRect(
        child: BottomNavigationBar(
          showSelectedLabels: true,
          showUnselectedLabels: true,
          currentIndex: _curSelected,
          selectedFontSize: 14,
          selectedIconTheme: const IconThemeData(size: 28),
          type: BottomNavigationBarType.fixed,
          onTap: _bottomIconPressed,
          elevation: 5,
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.text_snippet), label: 'Products'),
            BottomNavigationBarItem(
                icon: Icon(Icons.confirmation_number), label: 'Orders'),
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(icon: Icon(shopping_cart), label: 'Cart'),
            BottomNavigationBarItem(
                icon: Icon(Icons.perm_identity), label: 'Profile'),
          ],
        ),
      ),
    );
  }

  void _bottomIconPressed(int index) {
    if (index == 2) {
      setState(() {
        isHomePageSelected = true;
        isProductPageSelected = false;
        _curSelected = index;
      });
    } else if (index == 0) {
      setState(() {
        isHomePageSelected = false;
        isProductPageSelected = true;
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) => Products(),
          ),
        );
      });
    } else if (index == 3) {
      setState(() {
        isHomePageSelected = false;
        isProductPageSelected = true;
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) => const Cart(),
          ),
        );
      });
    }
  }

  int _current = 0;
  // ignore: non_constant_identifier_names
  _Carouselsliders() {
    return FutureBuilder(
      future: promoOffersList(),
      builder: ((context, snapshot) {
        if (snapshot.hasData) {
          return Column(
            children: [
              CarouselSlider(
                options: CarouselOptions(
                  // autoPlay: true,
                  // pauseAutoPlayOnTouch: Duration(seconds: 5),
                  enlargeCenterPage: false,
                  padEnds: false,
                  // viewportFraction: 1.2,
                  aspectRatio: 1.0,
                  height: 140,
                  onPageChanged: (index, reason) {
                    // setState(() {
                    _current = index;
                    // });
                  },
                ),
                items: <Widget>[
                  for (var i = 0; i < promoOffers[0].data.length; i++)
                    Container(
                      width: MediaQuery.of(context).size.width / 1,
                      margin: const EdgeInsets.only(left: 10.0, right: 10),
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(
                              'http://staging.ireckoner.com:9898/92000067/Images/Offer_${promoOffers[0].data[i].offerId}.PNG'),
                          fit: BoxFit.fitHeight,
                        ),
                        // border:
                        //     Border.all(color: Theme.of(context).accentColor),
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                    ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: promoOffers[0]
                    .data
                    .map(
                      (item) => FutureBuilder(
                          future: promoOffersList(),
                          builder: (context, snapshot) {
                            return Container(
                              width:
                                  _current == promoOffers[0].data.indexOf(item)
                                      ? 30.0
                                      : 10.0,
                              height: 8.0,
                              margin: const EdgeInsets.symmetric(
                                  vertical: 10.0, horizontal: 2.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: _current ==
                                        promoOffers[0].data.indexOf(item)
                                    ? const Color.fromRGBO(29, 55, 84, 1)
                                    : const Color.fromRGBO(147, 187, 213, 1),
                              ),
                            );
                          }),
                    )
                    .toList(),
              ),
            ],
          );
        } else if (snapshot.hasError) {
          return Text('${snapshot.hasError}');
        }

        return const CarouselLoading();
      }),
    );
  }

  Future apiCall() async {
    itemArr.clear();
    const url =
        "http://staging.ireckoner.com:3000/master/getItemsDetails?ProfileId=92000067_Live&UserId=sa&QueryName=getItemsDetails";
    final response = await http.get(Uri.parse(url));

    var data = jsonDecode(response.body.toString());
    print(data);

    if (response.statusCode == 200) {
      for (Map<String, dynamic> index in data) {
        //  for(int i =0; i < datarr.length; i++){
        itemArr.add(ServiceData.fromJson(index));
        // var usersdata = itemArr.fromJson(index);
        // for()
      }
      print(itemArr[0].data.length);
      return itemArr;
    } else {
      return itemArr;
    }
  }

  Future totalOutStand() async {
    totalOutStanding.clear();
    final DateTime now = DateTime.now();
    var lat1Month =
        // var lat1Month =
        // DateTime.now().subtract(Duration(days: 7));
        Jiffy(now, 'yyyy-MM-dd').subtract(months: 1).format('yyyy-MM-dd');
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    final String formatted = formatter.format(now);
    // final String formatted7Day = formatter.format(lat1Month);
    print(formatted);
    print(lat1Month);
    var url =
        "http://staging.ireckoner.com:3000/dashboard/getTotalOutstanding?ProfileId=92000067_Live&PartyId=1034&startDate=2022-01-01 00:00:00&endDate=2022-12-31 23:59:59";
    final response = await http.get(Uri.parse(url));

    var outstandData = jsonDecode(response.body.toString());
    print(outstandData);

    if (response.statusCode == 200) {
      for (Map<String, dynamic> index in outstandData) {
        //  for(int i =0; i < datarr.length; i++){
        totalOutStanding.add(TotalOutstanding.fromJson(index));
        // var usersdata = topSell.fromJson(index);
        // for()
      }
      print(totalOutStanding[0].data.length);
      print(totalOutStanding[0].data);
      return totalOutStanding;
    } else {
      return totalOutStanding;
    }
  }

  Future overDues() async {
    overdueAmount.clear();
    final DateTime now = DateTime.now();
    var last7Days =
        // var last7Days =
        DateTime.now().subtract(Duration(days: 7));
    // Jiffy(now, 'yyyy-MM-dd').subtract(months: 1).format('yyyy-MM-dd');
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    final String formatted = formatter.format(now);
    final String formatted7Day = formatter.format(last7Days);
    print('recent: $formatted');
    print(formatted7Day);
    var url =
        "http://staging.ireckoner.com:3000/dashboard/getOverDueAmount?ProfileId=92000067_Live&CurrentDate=2022-12-27%2023:59:59%20&PartyId=1034";
    final response = await http.get(Uri.parse(url));
    var data = jsonDecode(response.body.toString());

    if (response.statusCode == 200) {
      for (Map<String, dynamic> index in data) {
        overdueAmount.add(OverdueAmount.fromJson(index));
      }
      print(overdueAmount);
      print(overdueAmount[0].data.length);
      return overdueAmount;
    } else {
      return overdueAmount;
    }
  }

  Future overDueDays() async {
    overdueDays.clear();
    // final DateTime now = DateTime.now();
    var url =
        "http://staging.ireckoner.com:3000/dashboard/getOverdueDays?ProfileId=92000067_Live&PartyId=1034";
    final response = await http.get(Uri.parse(url));
    var daysData = jsonDecode(response.body.toString());

    if (response.statusCode == 200) {
      for (Map<String, dynamic> index in daysData) {
        overdueDays.add(OverdueDays.fromJson(index));
      }
      print(overdueDays);
      print(overdueDays[0].data.length);
      return overdueDays;
    } else {
      return overdueDays;
    }
  }

  Future promoOffersList() async {
    promoOffers.clear();
    var url =
        "http://staging.ireckoner.com:3000/transaction/getPromoOffers?ProfileId=92000067_Live";
    final response = await http.get(Uri.parse(url));
    var data = jsonDecode(response.body.toString());
    print(data);
    if (response.statusCode == 200) {
      for (Map<String, dynamic> index in data) {
        promoOffers.add(PromoOffers.fromJson(index));
      }
      print(promoOffers[0].data.length);
      return promoOffers;
    } else {
      return promoOffers;
    }
  }

  Future recentPurchaseItemsList() async {
    recentitems.clear();
    final DateTime now = DateTime.now();
    var last7Days =
        // var last7Days =
        DateTime.now().subtract(const Duration(days: 7));
    // Jiffy(now, 'yyyy-MM-dd').subtract(months: 1).format('yyyy-MM-dd');
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    final String formatted = formatter.format(now);
    final String formatted7Day = formatter.format(last7Days);
    print('recent: $formatted');
    print(formatted7Day);
    var url =
        "http://staging.ireckoner.com:3000/transaction/recentPurchasedProducts?ProfileId=92000067_Live&StartDate=2022-11-16 00:00:00&EndDate=${formatted} 23:59:59&PartyId=1034";
    final response = await http.get(Uri.parse(url));
    var data = jsonDecode(response.body.toString());

    if (response.statusCode == 200) {
      for (Map<String, dynamic> index in data) {
        recentitems.add(RecentPurchaseItems.fromJson(index));
      }
      print(recentitems);
      print(recentitems[0].data.length);
      return recentitems;
    } else {
      return recentitems;
    }
  }

  Future subCategoryList() async {
    subCategory.clear();
    var url =
        "http://staging.ireckoner.com:3000/master/getSubCategory?ProfileId=92000067_Live&QueryName=getSubCategory";
    final response = await http.get(Uri.parse(url));
    var data = jsonDecode(response.body.toString());
    print(data);
    if (response.statusCode == 200) {
      for (Map<String, dynamic> index in data) {
        subCategory.add(SubCategory.fromJson(index));
      }
      print(subCategory[0].data.length);
      return subCategory;
    } else {
      return subCategory;
    }
  }
}
