// import 'package:drink_smart/core/utils/size_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
// ignore: depend_on_referenced_packages
import 'package:octo_image/octo_image.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:shared_preferences/shared_preferences.dart';

//screen import
import '../cart/cart.dart';
import '../products/products.dart';

//model
import '../../model/product_detail.dart';
import '../../model/items_api_model.dart';

//extenstion
import '../../widgets/extenstions.dart';

// ignore: must_be_immutable
class ProductDetails extends StatefulWidget {
  ProductDetails(this.itemId, {super.key});

  String? itemId;

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  List<ProductDetail> productDetail = [];
  List<ServiceData> itemArr = [];

  bool showQtyButton = false;
  bool showAddButton = true;

  // ignore: prefer_typing_uninitialized_variables
  var categoryName;

  @override
  void initState() {
    super.initState();
    _getItemDetails();
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
              Navigator.pop(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) => const Products(),
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
                        builder: (BuildContext context) => const Cart(),
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
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: _imgCard(),
                ),
                // Text(widget.itemId.toString()),

                // for 3 dots
                Container(
                  height: 10,
                ),

                //Item details
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: _itemDetailsCard(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _imgCard() {
    return Container(
      height: 200,
      width: MediaQuery.of(context).size.width / 1.1,
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
      child: OctoImage(
        image: CachedNetworkImageProvider(
            'http://staging.ireckoner.com:9898/92000067/Images/Item_${widget.itemId}.PNG'),
        placeholderBuilder: OctoPlaceholder.blurHash(
          'LhL4yx%2x^WV~pkCWCWBR:WVRPof',
        ),
        width: double.maxFinite,
        height: 133,
        errorBuilder: (context, url, error) => Image.asset(
          "assets/images/product.png",
          fit: BoxFit.fitHeight,
        ),
        fit: BoxFit.fitHeight,
      ),
    );
  }

  Future _getItemDetails() async {
    productDetail.clear();
    var selectedItemId = widget.itemId;
    var url =
        "http://staging.ireckoner.com:3000/master/getItemView?ProfileId=92000067_Live&UserId=sa&QueryName=getItemView&ItemId=${selectedItemId}";
    final response = await http.get(Uri.parse(url));

    var data = jsonDecode(response.body.toString());
    print(data);

    if (response.statusCode == 200) {
      for (Map<String, dynamic> index in data) {
        //  for(int i =0; i < datarr.length; i++){
        productDetail.add(ProductDetail.fromJson(index));
        // var usersdata = productDetail.fromJson(index);
        // for()
      }
      categoryName = productDetail[0].data[0].category.toString();
      print(productDetail[0].data.length);
      price = productDetail[0].data[0].salesPrice;
      return productDetail;
    } else {
      return productDetail;
    }
  }

  _itemDetailsCard() {
    // ignore: avoid_unnecessary_containers
    return Container(
      child: FutureBuilder(
          future: _getItemDetails(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Column(
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 1.1,
                    height: 150,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 8),
                              child: SizedBox(
                                width: MediaQuery.of(context).size.width / 2,
                                height: 40,
                                child: Text(
                                  productDetail[0]
                                      .data[0]
                                      .itemName
                                      .toString()
                                      .toTitleCase(),
                                  textAlign: TextAlign.left,
                                  style: const TextStyle(
                                      color: Color.fromRGBO(29, 55, 84, 1),
                                      fontFamily: 'Arboria-Medium',
                                      fontSize: 20,
                                      letterSpacing:
                                          0 /*percentages not used in flutter. defaulting to zero*/,
                                      fontWeight: FontWeight.normal,
                                      height: 1),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 8),
                              child: SizedBox(
                                width: MediaQuery.of(context).size.width / 2,
                                height: 35,
                                child: Text(
                                  productDetail[0].data[0].salesUom.toString(),
                                  textAlign: TextAlign.left,
                                  style: const TextStyle(
                                      color: Color.fromRGBO(29, 55, 84, 1),
                                      fontFamily: 'Arboria-Medium',
                                      fontSize: 18,
                                      letterSpacing: 0.46000000834465027,
                                      fontWeight: FontWeight.normal,
                                      height: 1),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 1),
                              child: SizedBox(
                                width: MediaQuery.of(context).size.width / 2,
                                height: 35,
                                child: Text(
                                  productDetail[0]
                                      .data[0]
                                      .salesTaxRate
                                      .toString(),
                                  textAlign: TextAlign.left,
                                  style: const TextStyle(
                                      color: Color.fromRGBO(29, 55, 84, 1),
                                      fontFamily: 'Arboria-Medium',
                                      fontSize: 14,
                                      letterSpacing: 0.46000000834465027,
                                      fontWeight: FontWeight.normal,
                                      height: 1),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            SizedBox(
                              height: 120,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Container(
                                    width: 97,
                                    height: 27,
                                    decoration: const BoxDecoration(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(6)),
                                      boxShadow: [
                                        BoxShadow(
                                            color: Color.fromRGBO(147, 187, 213,
                                                0.20000000298023224),
                                            offset:
                                                Offset(0, 5.847456932067871),
                                            blurRadius: 23.389827728271484)
                                      ],
                                      color: Color.fromRGBO(221, 86, 92, 1),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: const [
                                        Text(
                                          '40% off',
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                              color: Color.fromRGBO(
                                                  255, 255, 255, 1),
                                              fontFamily: 'Arboria-Medium',
                                              fontSize: 14,
                                              letterSpacing:
                                                  0.46000000834465027,
                                              fontWeight: FontWeight.normal,
                                              height: 1),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 10),
                                    child: Container(
                                      width: 125,
                                      height: 37,
                                      decoration: BoxDecoration(
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(6)),
                                        boxShadow: const [
                                          BoxShadow(
                                              color: Color.fromRGBO(147, 187,
                                                  213, 0.20000000298023224),
                                              offset:
                                                  Offset(0, 5.847456932067871),
                                              blurRadius: 23.389827728271484)
                                        ],
                                        // color: Colors.white,
                                        border: Border.all(
                                          color: const Color.fromRGBO(
                                              183, 227, 244, 1),
                                          width: 1,
                                        ),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            top: 10, left: 8, bottom: 8),
                                        child: Text(
                                          'Rs. ${productDetail[0].data[0].salesPrice.toStringAsFixed(2)}/-',
                                          textAlign: TextAlign.left,
                                          style: const TextStyle(
                                              color:
                                                  Color.fromRGBO(29, 55, 84, 1),
                                              fontFamily: 'Arboria-Medium',
                                              fontSize: 18,
                                              letterSpacing:
                                                  0.46000000834465027,
                                              fontWeight: FontWeight.normal,
                                              height: 1),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 10),
                                    child: Container(
                                      width: 125,
                                      height: 28,
                                      decoration: const BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(6),
                                          topRight: Radius.circular(6),
                                          bottomLeft: Radius.circular(6),
                                          bottomRight: Radius.circular(6),
                                        ),
                                        boxShadow: [
                                          BoxShadow(
                                              color: Color.fromRGBO(147, 187,
                                                  213, 0.20000000298023224),
                                              offset:
                                                  Offset(0, 5.847456932067871),
                                              blurRadius: 23.389827728271484)
                                        ],
                                        color: Color.fromRGBO(183, 227, 244, 1),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            top: 7, left: 8, bottom: 8),
                                        child: Text(
                                          'Rs. ${productDetail[0].data[0].mrp}/-',
                                          textAlign: TextAlign.left,
                                          style: const TextStyle(
                                              decoration:
                                                  TextDecoration.lineThrough,
                                              color:
                                                  Color.fromRGBO(29, 55, 84, 1),
                                              fontFamily: 'Arboria-Bold',
                                              fontSize: 14,
                                              letterSpacing:
                                                  0.46000000834465027,
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

                  //Description container
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 15, left: 20, right: 20),
                    child: _discriptionCard(
                        productDetail[0].data[0].description.toString()),
                  ),

                  //Add to cart heading
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 15, left: 20, right: 20),
                    child: _getHeading("Add to Cart"),
                  ),

                  // //Add to cart container
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 15, left: 20, right: 20),
                    child: _addToCart(
                      productDetail[0].data[0].salesUom.toString(),
                      productDetail[0].data[0].secondaryUom.toString(),
                    ),
                  ),

                  //Related Products Heading
                  Padding(
                    padding: const EdgeInsets.only(top: 20, left: 20),
                    child: _getHeading('Related Products'),
                  ),

                  //Related Products
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: _relatedProducts(),
                  ),
                ],
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

  _discriptionCard(String discrp) {
    return SizedBox(
      height: 80,
      width: MediaQuery.of(context).size.width,
      child: Text(
        discrp,
        textAlign: TextAlign.left,
        style: const TextStyle(
            color: Color.fromRGBO(29, 55, 84, 1),
            fontFamily: 'Arboria-Light',
            fontSize: 14,
            letterSpacing: 0.46000000834465027,
            fontWeight: FontWeight.normal,
            height: 1),
      ),
    );
  }

  _getHeading(String title) {
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
                textAlign: TextAlign.left,
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

  _addToCart(String uom, String secUom) {
    return SizedBox(
      height: 36,
      width: MediaQuery.of(context).size.width,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: 36,
                child: Padding(
                  padding: const EdgeInsets.only(top: 5, bottom: 5),
                  child: Text(
                    '$uom $secUom',
                    textAlign: TextAlign.left,
                    style: const TextStyle(
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
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              showAddButton == true ? _addButton() : _qtyButton(),
            ],
          ),
        ],
      ),
    );
  }

  Future relatedProductApi() async {
    itemArr.clear();
    var url =
        "http://staging.ireckoner.com:3000/master/getItemsDetails?ProfileId=92000067_Live&UserId=sa&QueryName=getItemsDetails&QueryCond=item.Category='$categoryName'";
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

  _relatedProducts() {
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
          future: relatedProductApi(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  // children: <Widget>[
                  itemCount:
                      itemArr[0].data.length >= 5 ? 5 : itemArr[0].data.length,
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
                                                      ' ₹ ${itemArr[0].data[index].salesPrice!.toStringAsFixed(2)} /-',
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
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(28.5),
                      topRight: Radius.circular(28.5),
                      bottomLeft: Radius.circular(28.5),
                      bottomRight: Radius.circular(28.5),
                    ),
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
                          'ADD TO CART',
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
                          builder: (BuildContext context) => const Cart(),
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
  void _onAddClick() {
    setState(() {
      showQtyButton = true;
      showAddButton = false;
      itmQty = 1;
    });
  }

  void _minusclick() {
    setState(() {
      if (itmQty >= 1) {
        itmQty--;
        showAddButton = false;
        showQtyButton = true;
      } else {
        itmQty = 0;
        showAddButton = true;
        showQtyButton = false;
      }
    });
  }

  void _addClick() {
    setState(() {
      itmQty++;
    });
  }

  _addButton() {
    return InkWell(
      child: Container(
        width: 99,
        height: 35,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(28.5)),
          boxShadow: const [
            BoxShadow(
                color: Color.fromRGBO(29, 55, 84, 0.10000000149011612),
                offset: Offset(0, 20),
                blurRadius: 30)
          ],
          // color: Color.fromRGBO(29, 55, 84, 1),
          border: Border.all(
            color: const Color.fromRGBO(29, 55, 84, 1),
            width: 1,
          ),
        ),
        child: const Padding(
          padding: EdgeInsets.only(top: 8, bottom: 8),
          child: Text(
            'ADD',
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Color.fromRGBO(29, 55, 84, 1),
                fontFamily: 'Arboria-Medium',
                fontSize: 16,
                letterSpacing:
                    0 /*percentages not used in flutter. defaulting to zero*/,
                fontWeight: FontWeight.normal,
                height: 1),
          ),
        ),
      ),
      onTap: () => _onAddClick(),
    );
  }

  _qtyButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        InkWell(
          child: const Icon(
            size: 30,
            Icons.remove_circle_outline_rounded,
            color: Color.fromRGBO(221, 86, 92, 1),
          ),
          onTap: () => _minusclick(),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 5, right: 5),
          child: Text(
            itmQty.toString(),
            textAlign: TextAlign.left,
            style: const TextStyle(
                color: Color.fromRGBO(43, 68, 94, 1),
                fontFamily: 'Arboria-Medium',
                fontSize: 18,
                letterSpacing:
                    0 /*percentages not used in flutter. defaulting to zero*/,
                fontWeight: FontWeight.normal,
                height: 1),
          ),
        ),
        InkWell(
          child: const Icon(
            size: 30,
            Icons.add_circle_rounded,
            color: Color.fromRGBO(221, 86, 92, 1),
          ),
          onTap: () => _addClick(),
        )
      ],
    );
  }

  _itemAddToCart() {}
}
