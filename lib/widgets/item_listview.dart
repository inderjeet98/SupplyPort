// ignore: depend_on_referenced_packages
import 'package:octo_image/octo_image.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

//screen
import '../screens/product_details/product_details.dart';
import '../screens/cart/cart.dart';

//extenstions
import 'extenstions.dart';

class ItemListView extends StatefulWidget {
  const ItemListView(
      {Key? key,
      this.imagurl,
      this.itemId,
      this.itemname,
      this.price,
      this.uom,
      this.mrp})
      : super(key: key);

  final String? imagurl, itemname, uom;
  final int? itemId;
  final double? price, mrp;

  @override
  // ignore: library_private_types_in_public_api
  _ItemListViewState createState() => _ItemListViewState();
}

class _ItemListViewState extends State<ItemListView> {
  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // width: MediaQuery.of(context).size.width,
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
      child: InkWell(
        onTap: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) =>
                  ProductDetails(widget.itemId.toString()),
            ),
          );
        },
        child: Row(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 8, top: 5, bottom: 5),
              child: ClipRRect(
                borderRadius: const BorderRadius.all(
                  Radius.circular(5),
                ),
                child: OctoImage(
                  image: CachedNetworkImageProvider(
                    widget.imagurl!,
                  ),
                  placeholderBuilder: OctoPlaceholder.blurHash(
                    'LSO|2?WB.Txa%LoLWBWCyEoeMdWB',
                  ),
                  width: 60,
                  height: 66,
                  errorBuilder: (context, url, error) => Image.asset(
                    "assets/images/product.png",
                    fit: BoxFit.cover,
                    height: 60.0,
                    width: 66.0,
                  ),
                  fit: BoxFit.fitHeight,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  top: 10, bottom: 10, left: 10, right: 6),
              child: SizedBox(
                width: MediaQuery.of(context).size.width / 2.2,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width / 2.29,
                          child: Text(
                            widget.itemname.toString().toTitleCase(),
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.left,
                            style: const TextStyle(
                              color: Color.fromRGBO(29, 55, 84, 1),
                              fontFamily: 'Arboria-Medium',
                              fontSize: 16,
                              letterSpacing:
                                  0 /*percentages not used in flutter. defaulting to zero*/,
                              fontWeight: FontWeight.bold,
                              height: 1,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 5, top: 8),
                          child: Text(
                            '₹ ${widget.price.toString()} /-',
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.left,
                            style: const TextStyle(
                              color: Color.fromRGBO(29, 55, 84, 1),
                              fontFamily: 'Arboria-Medium',
                              fontSize: 16,
                              letterSpacing:
                                  0 /*percentages not used in flutter. defaulting to zero*/,
                              fontWeight: FontWeight.normal,
                              height: 1,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 5),
              child: InkWell(
                child: Container(
                  width: 99,
                  height: 35,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(28.5)),
                    boxShadow: const [
                      BoxShadow(
                          color:
                              Color.fromRGBO(29, 55, 84, 0.10000000149011612),
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
                onTap: () {
                  _showMyBottomSheet();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  errText(String title) {
    return Text(
      title,
      style: const TextStyle(
        color: Color.fromRGBO(29, 55, 84, 1),
        fontFamily: 'Arboria-Medium',
        fontWeight: FontWeight.bold,
        fontSize: 30,
        height: 1,
      ),
    );
  }

  void _showMyBottomSheet() {
    // the context of the bottomSheet will be this widget
    //the context here is where you want to showthe bottom sheet
    Scaffold.of(context).showBottomSheet(
      // backgroundColor: Colors.transparent,
      // enableDrag: true,
      shape: const RoundedRectangleBorder(
        // <-- SEE HERE
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20.0),
        ),
      ),
      (BuildContext context) {
        return MyCustomBottomSheet(
          uom: widget.uom,
          price: widget.price,
          mrp: widget.mrp,
        ); // returns your BottomSheet widget
      },
    );
  }
}

class MyCustomBottomSheet extends StatefulWidget {
  const MyCustomBottomSheet({super.key, this.price, this.mrp, this.uom});
  final String? uom;
  final double? price, mrp;

  @override
  State<MyCustomBottomSheet> createState() => _MyCustomBottomSheetState();
}

class _MyCustomBottomSheetState extends State<MyCustomBottomSheet> {
  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    super.initState();
  }

  bool showQtyButton = false;
  bool showAddButton = true;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        color: Color.fromRGBO(255, 255, 255, 1),
      ),
      height: MediaQuery.of(context).size.height / 3.4,
      child: Center(
        child: Column(
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: _getHeading('Add to Cart'),
                )
              ],
            ),
            const Divider(color: Color.fromRGBO(29, 55, 84, 1), thickness: 1),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: SizedBox(
                height: 50,
                width: MediaQuery.of(context).size.width,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 50,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 15, bottom: 10),
                            child: Text(
                              '${widget.uom}',
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
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: SizedBox(
                height: MediaQuery.of(context).size.height / 7.6,
                child: Scaffold(
                  bottomNavigationBar: getBottomBar(),
                ),
              ),
            ),
          ],
        ),
      ),
    ); // return your bottomSheetLayout
  }

  _getHeading(
    String title,
  ) {
    return Padding(
      padding: const EdgeInsets.only(top: 15.0, bottom: 10),
      child: Row(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width / 1.15,
                child: Text(
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
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              InkWell(
                child: const Icon(
                  Icons.close_outlined,
                  color: Color.fromRGBO(221, 86, 92, 1),
                ),
                // color: Color.fromRGBO(221, 86, 92, 1),
                onTap: () {
                  Navigator.pop(context);
                },
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
            color: Color.fromRGBO(29, 55, 84, 1),
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
          child: Icon(
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
            style: TextStyle(
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
          child: Icon(
            size: 30,
            Icons.add_circle_rounded,
            color: Color.fromRGBO(221, 86, 92, 1),
          ),
          onTap: () => _addClick(),
        )
      ],
    );
  }

  double price = 0;
  getBottomBar() {
    price = widget.price!.toDouble();
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
                  'Rs. ${(price * itmQty).toDouble()}/-',
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
                          builder: (BuildContext context) => Cart(),
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
}
