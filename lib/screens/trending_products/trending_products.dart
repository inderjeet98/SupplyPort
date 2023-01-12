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
import '../../model/topselling_items.dart';
import '../../model/latest_products.dart';
import '../../model/recent_pruchase_items.dart';

//screen import
import '../home/home.dart';
import '../cart/cart.dart';
import '../product_details/product_details.dart';
import '../products/products.dart';

//widgets
import '../../widgets/item_listview.dart';

class TrendingProducts extends StatefulWidget {
  TrendingProducts({required this.title, super.key});
  String? title;

  @override
  State<TrendingProducts> createState() => _TrendingProductsState();
}

class _TrendingProductsState extends State<TrendingProducts> {
  List<TopSellingitems> topSell = [];
  List<LatestProducts> itemArr = [];
  List<RecentPurchaseItems> recentitems = [];

  GlobalKey<ScaffoldState> _scaffoldState = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldState,
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
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: TextField(
                    decoration: InputDecoration(
                        hintText: 'Search Products ',
                        hintStyle: const TextStyle(
                          color: Color.fromRGBO(29, 55, 84, 0.5),
                          fontFamily: 'Arboria-Light',
                          fontSize: 16,
                          letterSpacing:
                              0 /*percentages not used in flutter. defaulting to zero*/,
                          fontWeight: FontWeight.normal,
                          height: 1.5,
                        ),
                        prefixIconConstraints:
                            const BoxConstraints(minWidth: 40, maxHeight: 20),
                        isDense: true,
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 12),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12))),
                    onChanged: (text) {
                      // text = text.toLowerCase();
                      // filter(text);
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20, left: 10, right: 10),
                  child: widget.title == 'Latest Products'
                      ? _latestProductCard()
                      : widget.title == 'Previous Bought Items'
                          ? _recentPurchasedProductCard()
                          : _topSelCard(),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future topsellingItem() async {
    topSell.clear();
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
        "http://staging.ireckoner.com:3000/dashboard/topSellingItems?ProfileId=92000067_Live&StartDate=2022-11-16 00:00:00&EndDate=${formatted} 23:59:59";
    final response = await http.get(Uri.parse(url));

    var data = jsonDecode(response.body.toString());
    print(data);

    if (response.statusCode == 200) {
      for (Map<String, dynamic> index in data) {
        //  for(int i =0; i < datarr.length; i++){
        topSell.add(TopSellingitems.fromJson(index));
        // var usersdata = topSell.fromJson(index);
        // for()
      }
      print(topSell[0].data.length);
      return topSell;
    } else {
      return topSell;
    }
  }

  _topSelCard() {
    return FutureBuilder(
      future: topsellingItem(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return SingleChildScrollView(
            child: ListView.builder(
                shrinkWrap: true,
                physics: ScrollPhysics(),
                // scrollDirection: Axis.vertical,
                itemCount: topSell[0].data.length,
                itemBuilder: (context, i) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Container(
                      width: MediaQuery.of(context).size.width / 1.7,
                      height: 72,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        boxShadow: [
                          BoxShadow(
                              color: Color.fromRGBO(211, 209, 216, 0.25),
                              offset: Offset(15, 15),
                              blurRadius: 30)
                        ],
                        color: Color.fromRGBO(255, 255, 255, 1),
                      ),
                      child: Column(
                        children: <Widget>[
                          ItemListView(
                            imagurl:
                                'http://staging.ireckoner.com:9898/92000067/Images/Item_${topSell[0].data[i].itemId}.PNG',
                            itemId: topSell[0].data[i].itemId,
                            itemname: topSell[0].data[i].itemName,
                            price: topSell[0].data[i].salesPrice,
                            mrp: topSell[0].data[i].mrp,
                            uom: topSell[0].data[i].uom,
                          ),
                        ],
                      ),
                    ),
                  );
                }),
          );
        } else if (snapshot.hasError) {
          return Text('${snapshot.error}');
        }
        // By default, show a loading spinner.
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  Future apiCall() async {
    itemArr.clear();
    const url =
        "http://staging.ireckoner.com:3000/master/getLatestProducts?ProfileId=92000067_Live&QueryName=getLatestProducts";
    final response = await http.get(Uri.parse(url));

    var data = jsonDecode(response.body.toString());
    print(data);

    if (response.statusCode == 200) {
      for (Map<String, dynamic> index in data) {
        //  for(int i =0; i < datarr.length; i++){
        itemArr.add(LatestProducts.fromJson(index));
        // var usersdata = itemArr.fromJson(index);
        // for()
      }
      print(itemArr[0].data.length);
      return itemArr;
    } else {
      return itemArr;
    }
  }

  _latestProductCard() {
    return FutureBuilder(
      future: apiCall(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
              shrinkWrap: true,
              physics: const ScrollPhysics(),
              scrollDirection: Axis.vertical,
              itemCount: itemArr[0].data.length,
              itemBuilder: (context, i) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Container(
                    width: MediaQuery.of(context).size.width / 1.6,
                    height: 72,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                      boxShadow: [
                        BoxShadow(
                            color: Color.fromRGBO(211, 209, 216, 0.25),
                            offset: Offset(15, 15),
                            blurRadius: 30)
                      ],
                      color: Color.fromRGBO(255, 255, 255, 1),
                    ),
                    child: Column(
                      children: <Widget>[
                        ItemListView(
                          imagurl:
                              'http://staging.ireckoner.com:9898/92000067/Images/Item_${itemArr[0].data[i].itemId}.PNG',
                          itemId: itemArr[0].data[i].itemId,
                          itemname: itemArr[0].data[i].itemName,
                          price: itemArr[0].data[i].salesPrice,
                          mrp: itemArr[0].data[i].mrp,
                          uom: itemArr[0].data[i].salesUom,
                        ),
                      ],
                    ),
                  ),
                );
              });
        } else if (snapshot.hasError) {
          return Text('${snapshot.error}');
        }
        // By default, show a loading spinner.
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  Future recentPurchaseItemsList() async {
    recentitems.clear();
    final DateTime now = DateTime.now();
    var last7Days =
        // var last7Days =
        DateTime.now().subtract(Duration(days: 7));
    // Jiffy(now, 'yyyy-MM-dd').subtract(months: 1).format('yyyy-MM-dd');
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    final String formatted = formatter.format(now);
    final String formatted7Day = formatter.format(last7Days);
    print('recent: ' + formatted);
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

  _recentPurchasedProductCard() {
    return FutureBuilder(
      future: recentPurchaseItemsList(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
              shrinkWrap: true,
              physics: const ScrollPhysics(),
              scrollDirection: Axis.vertical,
              itemCount: recentitems[0].data.length,
              itemBuilder: (context, i) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Container(
                    width: MediaQuery.of(context).size.width / 1.6,
                    height: 72,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                      boxShadow: [
                        BoxShadow(
                            color: Color.fromRGBO(211, 209, 216, 0.25),
                            offset: Offset(15, 15),
                            blurRadius: 30)
                      ],
                      color: Color.fromRGBO(255, 255, 255, 1),
                    ),
                    child: Column(
                      children: <Widget>[
                        ItemListView(
                            imagurl:
                                'http://staging.ireckoner.com:9898/92000067/Images/Item_${recentitems[0].data[i].itemId}.PNG',
                            itemId: recentitems[0].data[i].itemId,
                            itemname: recentitems[0].data[i].itemName,
                            price: recentitems[0].data[i].salesPrice,
                            mrp: recentitems[0].data[i].mrp,
                            uom: recentitems[0].data[i].uom),
                      ],
                    ),
                  ),
                );
              });
        } else if (snapshot.hasError) {
          return Text('${snapshot.error}');
        }
        // By default, show a loading spinner.
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
