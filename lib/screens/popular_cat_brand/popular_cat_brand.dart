import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
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

//custom widgets
import '../../widgets/brand_cat_list.dart';

class PopularCatBrand extends StatefulWidget {
  PopularCatBrand({required this.title, super.key});
  String? title;

  @override
  State<PopularCatBrand> createState() => _PopularCatBrandState();
}

class _PopularCatBrandState extends State<PopularCatBrand> {
  List<PopularBrands> pBrands = [];
  List<PopularCategories> popularCat = [];
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
                  padding: const EdgeInsets.only(top: 20, left: 15, right: 15),
                  child: widget.title == 'Popular Brands'
                      ? _brandsCard()
                      : _categoryCard(),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future popularCategoryApi() async {
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

  Future popularBrandsApi() async {
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

  _categoryCard() {
    return FutureBuilder(
      future: popularCategoryApi(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return SingleChildScrollView(
            child: ListView.builder(
                shrinkWrap: true,
                physics: ScrollPhysics(),
                // scrollDirection: Axis.vertical,
                itemCount: popularCat[0].data.length,
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
                          BrandCatList(
                            imgUrl:
                                'http://staging.ireckoner.com:9898/92000067/Images/Category_${popularCat[0].data[i].category}.PNG',
                            id: popularCat[0].data[i].category,
                            name: popularCat[0].data[i].categoryName,
                            itemCount:
                                popularCat[0].data[i].itemcount.toString(),
                            title: widget.title,
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

  _brandsCard() {
    return FutureBuilder(
      future: popularBrandsApi(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return SingleChildScrollView(
            child: ListView.builder(
                shrinkWrap: true,
                physics: ScrollPhysics(),
                // scrollDirection: Axis.vertical,
                itemCount: pBrands[0].data.length,
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
                          BrandCatList(
                            title: widget.title,
                            imgUrl:
                                'http://staging.ireckoner.com:9898/92000067/Images/Brand_${pBrands[0].data[i].brand}.PNG',
                            id: pBrands[0].data[i].brand,
                            name: pBrands[0].data[i].brand,
                            itemCount: pBrands[0].data[i].itemcount.toString(),
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
}
