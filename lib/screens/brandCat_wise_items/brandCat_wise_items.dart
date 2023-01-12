// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

//screen import
import '../cart/cart.dart';
import '../popular_cat_brand/popular_cat_brand.dart';

//widgets
import '../../widgets/brandcat_item_list.dart';

//models
import '../../model/items_api_model.dart';

class BrandCatWiseItems extends StatefulWidget {
  const BrandCatWiseItems({required this.title, this.id, this.name, super.key});
  final String? title, id, name;

  @override
  State<BrandCatWiseItems> createState() => _BrandCatWiseItemsState();
}

class _BrandCatWiseItemsState extends State<BrandCatWiseItems> {
  List<ServiceData> popularCat = [];
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
                widget.name.toString(),
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
                  builder: (BuildContext context) => PopularCatBrand(
                    title: widget.title,
                  ),
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
                      builder: (BuildContext context) => PopularCatBrand(
                        title: widget.title,
                      ),
                    ),
                  );
                },
                tooltip: 'back to home screen',
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
                  child: _itemCard(),
                  //widget.title == 'Popular Brands'
                  //     ? _latestProductCard()
                  //     : widget.title == 'Previous Bought Items'
                  //         ? _recentPurchasedProductCard()
                  //         : _topSelCard(),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future popularCategoryItemsApi() async {
    popularCat.clear();
    var id = widget.id;
    String url;

    if (widget.title == 'Popular Brands') {
      url =
          "http://staging.ireckoner.com:3000/master/getItemsDetails?ProfileId=92000067_Live&UserId=sa&QueryName=getItemsDetails&QueryCond=Brand='$id'";
    } else {
      url =
          "http://staging.ireckoner.com:3000/master/getItemsDetails?ProfileId=92000067_Live&UserId=sa&QueryName=getItemsDetails&QueryCond=Category=$id";
    }
    final response = await http.get(Uri.parse(url));

    var data = jsonDecode(response.body.toString());
    // print(data);

    if (response.statusCode == 200) {
      for (Map<String, dynamic> index in data) {
        //  for(int i =0; i < datarr.length; i++){
        popularCat.add(ServiceData.fromJson(index));
        // var usersdata = topSell.fromJson(index);
        // for()
      }
      return popularCat;
    } else {
      return popularCat;
    }
  }

  _itemCard() {
    return FutureBuilder(
      future: popularCategoryItemsApi(),
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
                          ItemListViewBrandCat(
                            imagurl:
                                'http://staging.ireckoner.com:9898/92000067/Images/Item_${popularCat[0].data[i].itemId}.PNG',
                            itemId: popularCat[0].data[i].itemId,
                            itemname: popularCat[0].data[i].itemName,
                            price: popularCat[0].data[i].salesPrice,
                            uom: popularCat[0].data[i].salesUom,
                            mrp: popularCat[0].data[i].mrp,
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
