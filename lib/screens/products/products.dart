import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:octo_image/octo_image.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'dart:convert';
import 'package:jiffy/jiffy.dart';
import 'package:intl/intl.dart';

//models import
import '../../model/latest_products.dart';
import '../../model/topselling_items.dart';
import '../../model/popular_brand.dart';
import '../../model/popular_categories.dart';

//screen import
import '../home/home.dart';
import '../cart/cart.dart';
import '../product_details/product_details.dart';
import '../trending_products/trending_products.dart';
import '../popular_cat_brand/popular_cat_brand.dart';
import '../brandCat_wise_items/brandCat_wise_items.dart';

//extenstions
import '../../widgets/extenstions.dart';

class Products extends StatefulWidget {
  const Products({super.key});

  @override
  State<Products> createState() => _ProductsState();
}

class _ProductsState extends State<Products> {
  List<LatestProducts> itemArr = [];
  List<TopSellingitems> topSell = [];
  List<PopularBrands> pBrands = [];
  List<PopularCategories> popularCat = [];

  @override
  void initState() {
    super.initState();
    popularBrands();
    topsellingItem();
    apiCall();
  }

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
                'Product Listing',
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
                  builder: (BuildContext context) => const Home(),
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
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 25, top: 8, bottom: 8),
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
      bottomNavigationBar: getBottomBar(),
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
                // trending products
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: _getHeading("Trending Products"),
                ),
                getTrendingItemsCard(),

                //latest products
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: _getHeading("Latest Products"),
                ),
                getItemsCard(),

                //popular brands
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: _getHeading("Popular Categories"),
                ),
                Container(
                  child: getCategoriesGrid(),
                ),

                //popular categories
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: _getHeading("Popular Brands"),
                ),
                Container(
                  child: getBrandGrid(),
                ),
              ],
            ),
          ),
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
                    )
                  ],
                ),
                // color: Color.fromRGBO(221, 86, 92, 1),
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) =>
                          // (title == 'Popular Brands' ||
                          //         title == 'Popular Categories')
                          title.contains('Popular')
                              ? PopularCatBrand(
                                  title: title,
                                )
                              : TrendingProducts(
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

  int _curSelected = 0;
  bool isHomePageSelected = false;
  bool isProductPageSelected = true;

  // ignore: constant_identifier_names
  static const IconData shopping_cart =
      IconData(0xe59c, fontFamily: 'MaterialIcons');
  getBottomBar() {
    return BottomAppBar(
      child: Container(
        child: ClipRRect(
          child: BottomNavigationBar(
            showSelectedLabels: true,
            showUnselectedLabels: true,
            selectedIconTheme: const IconThemeData(size: 28),
            selectedFontSize: 14,
            currentIndex: _curSelected,
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
      ),
    );
  }

  void _bottomIconPressed(int index) {
    if (index == 0) {
      setState(() {
        isHomePageSelected = false;
        isProductPageSelected = true;
        _curSelected = index;
      });
    } else if (index == 2) {
      setState(() {
        isHomePageSelected = false;
        isProductPageSelected = true;
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) => Home(),
          ),
        );
      });
    } else if (index == 3) {
      setState(() {
        isHomePageSelected = false;
        isProductPageSelected = false;
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) => Cart(),
          ),
        );
      });
    }
  }

  getTrendingItemsCard() {
    return Container(
      height: 267,
      // width: 266,
      decoration: const BoxDecoration(
        boxShadow: [
          BoxShadow(
              color: Color.fromRGBO(211, 209, 216, 0.25),
              offset: Offset(15, 15),
              blurRadius: 30)
        ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: FutureBuilder(
          future: topsellingItem(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  // children: <Widget>[
                  itemCount: topSell[0].data.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(left: 2.5, right: 2.5),
                      child: Card(
                        elevation: 3,
                        color: const Color.fromRGBO(
                            29, 55, 84, 0.10000000149011612),
                        shape: RoundedRectangleBorder(
                          side:
                              const BorderSide(color: Colors.white70, width: 5),
                          borderRadius: BorderRadius.circular(28.5),
                        ),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 15),
                          width: 266,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(15),
                              topRight: Radius.circular(15),
                              bottomLeft: Radius.circular(15),
                              bottomRight: Radius.circular(15),
                            ),
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
                                        builder: (BuildContext context) =>
                                            ProductDetails(topSell[0]
                                                .data[index]
                                                .itemId
                                                .toString()),
                                      ),
                                    );
                                  },
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      Expanded(
                                        child: Stack(
                                          alignment: Alignment.topLeft,
                                          children: [
                                            ClipRRect(
                                              borderRadius:
                                                  const BorderRadius.only(
                                                      topLeft:
                                                          Radius.circular(5),
                                                      topRight:
                                                          Radius.circular(5)),
                                              child: OctoImage(
                                                image: CachedNetworkImageProvider(
                                                    'http://staging.ireckoner.com:9898/92000067/Images/Item_${topSell[0].data[index].itemId}.PNG'),
                                                placeholderBuilder:
                                                    OctoPlaceholder.blurHash(
                                                  'LhL4yx%2x^WV~pkCWCWBR:WVRPof',
                                                ),
                                                width: double.infinity,
                                                height: 153,
                                                errorBuilder:
                                                    (context, url, error) =>
                                                        Image.asset(
                                                  "assets/images/product.png",
                                                  fit: BoxFit.fitHeight,
                                                  height: 60.0,
                                                  width: 66.0,
                                                ),
                                                fit: BoxFit.fitHeight,
                                              ),
                                            ),
                                            Container(
                                              height: 28,
                                              decoration: const BoxDecoration(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(6)),
                                                boxShadow: [
                                                  BoxShadow(
                                                      color: Color.fromRGBO(
                                                          147,
                                                          187,
                                                          213,
                                                          0.20000000298023224),
                                                      offset: Offset(
                                                          0, 5.847456932067871),
                                                      blurRadius:
                                                          23.389827728271484)
                                                ],
                                                color: Color.fromRGBO(
                                                    182, 226, 244, 1),
                                              ),
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 5, right: 5),
                                                child: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    Text(
                                                      ' ₹ ${topSell[0].data[index].salesPrice!.toStringAsFixed(2)}/-',
                                                      style: const TextStyle(
                                                          color: Color.fromRGBO(
                                                              29, 55, 84, 1),
                                                          fontFamily:
                                                              'Arboria-Medium',
                                                          fontSize: 14,
                                                          letterSpacing:
                                                              0.46000000834465027,
                                                          fontWeight:
                                                              FontWeight.normal,
                                                          height: 1),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      // SizedBox(
                                      //   height: MediaQuery.of(context)
                                      //           .size
                                      //           .width /
                                      //       60,
                                      // ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 1),
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              bottom: 8, top: 5, left: 10),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: <Widget>[
                                              Expanded(
                                                child: Text(
                                                  topSell[0]
                                                      .data[index]
                                                      .itemName
                                                      .toString()
                                                      .toTitleCase(),
                                                  style: const TextStyle(
                                                      color: Color.fromRGBO(
                                                          29, 55, 84, 1),
                                                      fontFamily:
                                                          'Arboria-Medium',
                                                      fontSize: 15,
                                                      letterSpacing: 0),
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Row(
                                        children: <Widget>[
                                          const Padding(
                                            padding: EdgeInsets.only(
                                                bottom: 8, top: 1, left: 10),
                                            child: Icon(
                                              Icons.monitor_weight_outlined,
                                              color: Color.fromRGBO(
                                                  221, 86, 92, 1),
                                              size: 15,
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: 8, top: 1, left: 4),
                                            child: Text(
                                              topSell[0]
                                                  .data[index]
                                                  .uom
                                                  .toString(),
                                              style: const TextStyle(
                                                  color: Color.fromRGBO(
                                                      125, 131, 145, 1),
                                                  fontFamily: 'Arboria-Medium',
                                                  fontSize: 12,
                                                  letterSpacing:
                                                      0 /*percentages not used in flutter. defaulting to zero*/,
                                                  fontWeight: FontWeight.normal,
                                                  height: 1),
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 5.0,
                                          ),
                                          // Text(
                                          //   CUR_CURRENCY + "",
                                          //   style: Theme.of(context).textTheme.overline!.copyWith(
                                          //       decoration: TextDecoration.lineThrough,
                                          //       letterSpacing: 1),
                                          // ),
                                        ],
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
    );
  }

  getItemsCard() {
    return Container(
      height: 267,
      // width: 266,
      decoration: const BoxDecoration(
        boxShadow: [
          BoxShadow(
              color: Color.fromRGBO(211, 209, 216, 0.25),
              offset: Offset(15, 15),
              blurRadius: 30)
        ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: FutureBuilder(
          future: apiCall(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  // children: <Widget>[
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(left: 2.5, right: 2.5),
                      child: Card(
                        elevation: 3,
                        color: const Color.fromRGBO(
                            29, 55, 84, 0.10000000149011612),
                        shape: RoundedRectangleBorder(
                          side:
                              const BorderSide(color: Colors.white70, width: 5),
                          borderRadius: BorderRadius.circular(28.5),
                        ),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 15),
                          width: 266,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(15)),
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
                                        builder: (BuildContext context) =>
                                            ProductDetails(itemArr[0]
                                                .data[index]
                                                .itemId
                                                .toString()),
                                      ),
                                    );
                                  },
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      Expanded(
                                        child: Stack(
                                          alignment: Alignment.topLeft,
                                          children: [
                                            ClipRRect(
                                              borderRadius:
                                                  const BorderRadius.only(
                                                      topLeft:
                                                          Radius.circular(5),
                                                      topRight:
                                                          Radius.circular(5)),
                                              child: OctoImage(
                                                image: CachedNetworkImageProvider(
                                                    'http://staging.ireckoner.com:9898/92000067/Images/Item_${itemArr[0].data[index].itemId}.PNG'),
                                                placeholderBuilder:
                                                    OctoPlaceholder.blurHash(
                                                  'http://staging.ireckoner.com:9898/92000067/Images/Item_${itemArr[0].data[index].itemId}.PNG',
                                                ),
                                                width: double.infinity,
                                                height: 153,
                                                errorBuilder:
                                                    (context, url, error) =>
                                                        Image.asset(
                                                  "assets/images/product.png",
                                                  fit: BoxFit.fitHeight,
                                                  height: 60.0,
                                                  width: 66.0,
                                                ),
                                                fit: BoxFit.fitHeight,
                                              ),
                                            ),
                                            Container(
                                              height: 28,
                                              decoration: const BoxDecoration(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(6)),
                                                boxShadow: [
                                                  BoxShadow(
                                                      color: Color.fromRGBO(
                                                          147,
                                                          187,
                                                          213,
                                                          0.20000000298023224),
                                                      offset: Offset(
                                                          0, 5.847456932067871),
                                                      blurRadius:
                                                          23.389827728271484)
                                                ],
                                                color: Color.fromRGBO(
                                                    182, 226, 244, 1),
                                              ),
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 5, right: 5),
                                                child: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    Text(
                                                      ' ₹ ${itemArr[0].data[index].salesPrice!.toStringAsFixed(2)}/-',
                                                      style: const TextStyle(
                                                          color: Color.fromRGBO(
                                                              29, 55, 84, 1),
                                                          fontFamily:
                                                              'Arboria-Medium',
                                                          fontSize: 14,
                                                          letterSpacing:
                                                              0.46000000834465027,
                                                          fontWeight:
                                                              FontWeight.normal,
                                                          height: 1),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      // SizedBox(
                                      //   height: MediaQuery.of(context)
                                      //           .size
                                      //           .width /
                                      //       60,
                                      // ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            bottom: 8, top: 5, left: 10),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: <Widget>[
                                            Expanded(
                                              child: Text(
                                                itemArr[0]
                                                    .data[index]
                                                    .itemName
                                                    .toString()
                                                    .toTitleCase(),
                                                style: const TextStyle(
                                                    color: Color.fromRGBO(
                                                        29, 55, 84, 1),
                                                    fontFamily:
                                                        'Arboria-Medium',
                                                    fontSize: 15,
                                                    letterSpacing: 0),
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Row(
                                        children: <Widget>[
                                          const Padding(
                                            padding: EdgeInsets.only(
                                                bottom: 8, top: 1, left: 10),
                                            child: Icon(
                                              Icons.monitor_weight_outlined,
                                              color: Color.fromRGBO(
                                                  221, 86, 92, 1),
                                              size: 15,
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: 8, top: 1, left: 4),
                                            child: Text(
                                              itemArr[0]
                                                  .data[index]
                                                  .salesUom
                                                  .toString(),
                                              style: const TextStyle(
                                                  color: Color.fromRGBO(
                                                      125, 131, 145, 1),
                                                  fontFamily: 'Arboria-Medium',
                                                  fontSize: 12,
                                                  letterSpacing:
                                                      0 /*percentages not used in flutter. defaulting to zero*/,
                                                  fontWeight: FontWeight.normal,
                                                  height: 1),
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 5.0,
                                          ),
                                          // Text(
                                          //   CUR_CURRENCY + "",
                                          //   style: Theme.of(context).textTheme.overline!.copyWith(
                                          //       decoration: TextDecoration.lineThrough,
                                          //       letterSpacing: 1),
                                          // ),
                                        ],
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
      print(topSell[0].data.sort);
      return topSell;
    } else {
      return topSell;
    }
  }

  getBrandGrid() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: FutureBuilder(
          future: popularBrands(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                childAspectRatio: 1.5,
                children: List.generate(
                    pBrands[0].data.length >= 6
                        ? 6
                        : pBrands[0].data.length >= 4
                            ? 4
                            : (pBrands[0].data.length >= 2)
                                ? 2
                                : (pBrands[0].data.length == 1)
                                    ? 1
                                    : 0, (index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (BuildContext context) =>
                                BrandCatWiseItems(
                              title: 'Popular Brands',
                              id: pBrands[0].data[index].brand,
                              name: pBrands[0].data[index].brand,
                            ),
                          ),
                        );
                      },
                      child: Container(
                        width: 165,
                        height: 60,
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(15),
                            topRight: Radius.circular(15),
                            bottomLeft: Radius.circular(15),
                            bottomRight: Radius.circular(15),
                          ),
                          boxShadow: [
                            BoxShadow(
                                color: Color.fromRGBO(211, 209, 216, 0.25),
                                offset: Offset(15, 15),
                                blurRadius: 30)
                          ],
                          color: Color.fromRGBO(255, 255, 255, 1),
                        ),
                        child: ClipRRect(
                          borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(5),
                              topRight: Radius.circular(5)),
                          child: Padding(
                            padding: const EdgeInsets.only(
                                top: 10, bottom: 10, left: 15, right: 15),
                            child: OctoImage(
                              image: CachedNetworkImageProvider(
                                  'http://staging.ireckoner.com:9898/92000067/Images/Brand_${pBrands[0].data[index].brand}.PNG'),
                              placeholderBuilder: OctoPlaceholder.blurHash(
                                'LhL4yx%2x^WV~pkCWCWBR:WVRPof',
                              ),
                              width: double.infinity,
                              height: 47,
                              errorBuilder: OctoError.circleAvatar(
                                backgroundColor: Colors.white,
                                text: errText(pBrands[0]
                                    .data[index]
                                    .brand
                                    .substring(1, 2)),
                              ),
                              fit: BoxFit.fitHeight,
                            ),
                          ),
                        ),
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
          }),
    );
  }

  errText(String title) {
    return Text(
      title,
      style: const TextStyle(
          color: Color.fromRGBO(29, 55, 84, 1),
          fontFamily: 'Arboria-Medium',
          fontWeight: FontWeight.bold,
          fontSize: 36,
          height: 1),
    );
  }

  getCategoriesGrid() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: FutureBuilder(
          future: popularCategories(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                childAspectRatio: 1.5,
                children: List.generate(
                    popularCat[0].data.length >= 6
                        ? 6
                        : popularCat[0].data.length >= 4
                            ? 4
                            : (popularCat[0].data.length >= 2)
                                ? 2
                                : (popularCat[0].data.length == 1)
                                    ? 1
                                    : 0, (index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (BuildContext context) =>
                                BrandCatWiseItems(
                              title: 'Popular Category',
                              id: popularCat[0].data[index].category,
                              name: popularCat[0].data[index].categoryName,
                            ),
                          ),
                        );
                      },
                      child: Container(
                        width: 165,
                        height: 60,
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                          boxShadow: [
                            BoxShadow(
                                color: Color.fromRGBO(211, 209, 216, 0.25),
                                offset: Offset(15, 15),
                                blurRadius: 30)
                          ],
                          color: Color.fromRGBO(255, 255, 255, 1),
                        ),
                        child: ClipRRect(
                          borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(5),
                              topRight: Radius.circular(5)),
                          child: Padding(
                            padding: const EdgeInsets.only(
                                top: 10, bottom: 10, left: 15, right: 15),
                            child: OctoImage(
                              image: CachedNetworkImageProvider(
                                  'http://staging.ireckoner.com:9898/92000067/Images/Category_${popularCat[0].data[index].category}.PNG'),
                              placeholderBuilder: OctoPlaceholder.blurHash(
                                'LhL4yx%2x^WV~pkCWCWBR:WVRPof',
                              ),
                              width: double.infinity,
                              height: 47,
                              errorBuilder: OctoError.circleAvatar(
                                  backgroundColor: Colors.white,
                                  text: errText(popularCat[0]
                                      .data[index]
                                      .categoryName
                                      .substring(0, 1))),
                              fit: BoxFit.fitHeight,
                            ),
                          ),
                        ),
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
          }),
    );
  }

  Future popularBrands() async {
    pBrands.clear();
    final DateTime now = DateTime.now();
    var last1Month =
        // var lat1Month =
        // DateTime.now().subtract(Duration(days: 7));
        Jiffy(now, 'yyyy-MM-dd').subtract(months: 1).format('yyyy-MM-dd');
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    final String formatted = formatter.format(now);
    // final String formatted7Day = formatter.format(lat1Month);
    print(formatted);
    print(last1Month);
    var url =
        "http://staging.ireckoner.com:3000/dashboard/getPopularBrands?ProfileId=92000067_Live&startDate=${last1Month} 00:00:00&endDate=${formatted} 23:59:59";
    final response = await http.get(Uri.parse(url));

    var data = jsonDecode(response.body.toString());
    print(data);

    if (response.statusCode == 200) {
      for (Map<String, dynamic> index in data) {
        //  for(int i =0; i < datarr.length; i++){
        pBrands.add(PopularBrands.fromJson(index));
        // var usersdata = topSell.fromJson(index);
        // for()
      }
      print(pBrands[0].data);
      print(pBrands[0].data.length);
      return pBrands;
    } else {
      return pBrands;
    }
  }

  Future popularCategories() async {
    popularCat.clear();
    final DateTime now = DateTime.now();
    var last1Month =
        // var last1Month =
        // DateTime.now().subtract(Duration(days: 7));
        Jiffy(now, 'yyyy-MM-dd').subtract(months: 1).format('yyyy-MM-dd');
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    final String formatted = formatter.format(now);
    // final String formatted7Day = formatter.format(last1Month);
    print(formatted);
    print(last1Month);
    var url =
        "http://staging.ireckoner.com:3000/dashboard/getPopularCategories?ProfileId=92000067_Live&startDate=${last1Month} 00:00:00&endDate=${formatted} 23:59:59";
    final response = await http.get(Uri.parse(url));

    var data = jsonDecode(response.body.toString());
    print(data);

    if (response.statusCode == 200) {
      for (Map<String, dynamic> index in data) {
        //  for(int i =0; i < datarr.length; i++){
        popularCat.add(PopularCategories.fromJson(index));
        // var usersdata = topSell.fromJson(index);
        // for()
      }
      print(popularCat[0].data.length);
      print(popularCat[0].data.sort);
      return popularCat;
    } else {
      return popularCat;
    }
  }
}
