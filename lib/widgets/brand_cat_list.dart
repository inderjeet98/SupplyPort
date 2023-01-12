import 'package:octo_image/octo_image.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

//screen
import '../screens/product_details/product_details.dart';
import '../screens/brandCat_wise_items/brandCat_wise_items.dart';

//extenstions
import 'extenstions.dart';

class BrandCatList extends StatefulWidget {
  const BrandCatList(
      {Key? key, this.id, this.title, this.imgUrl, this.name, this.itemCount})
      : super(key: key);
  final String? id, name, imgUrl, itemCount, title;

  @override
  State<BrandCatList> createState() => _BrandCatListState();
}

class _BrandCatListState extends State<BrandCatList> {
  @override
  void initState() {
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
              builder: (BuildContext context) => BrandCatWiseItems(
                title: widget.title.toString(),
                id: widget.id.toString(),
                name: widget.name,
              ),
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
                    widget.imgUrl!,
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
                width: MediaQuery.of(context).size.width / 1.6,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width / 1.7,
                          child: Text(
                            widget.name.toString().toTitleCase(),
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
                          padding: const EdgeInsets.only(left: 10, top: 8),
                          child: Text(
                            'No. of Products: ${widget.itemCount.toString()}',
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
            // Padding(
            //   padding: const EdgeInsets.only(right: 5),
            //   child: InkWell(
            //     child: Container(
            //       width: 99,
            //       height: 35,
            //       decoration: BoxDecoration(
            //         borderRadius: const BorderRadius.all(Radius.circular(28.5)),
            //         boxShadow: const [
            //           BoxShadow(
            //               color:
            //                   Color.fromRGBO(29, 55, 84, 0.10000000149011612),
            //               offset: Offset(0, 20),
            //               blurRadius: 30)
            //         ],
            //         // color: Color.fromRGBO(29, 55, 84, 1),
            //         border: Border.all(
            //           color: const Color.fromRGBO(29, 55, 84, 1),
            //           width: 1,
            //         ),
            //       ),
            //       child: const Padding(
            //         padding: EdgeInsets.only(top: 8, bottom: 8),
            //         child: Text(
            //           'ADD',
            //           textAlign: TextAlign.center,
            //           style: TextStyle(
            //               color: Color.fromRGBO(29, 55, 84, 1),
            //               fontFamily: 'Arboria-Medium',
            //               fontSize: 16,
            //               letterSpacing:
            //                   0 /*percentages not used in flutter. defaulting to zero*/,
            //               fontWeight: FontWeight.normal,
            //               height: 1),
            //         ),
            //       ),
            //     ),
            //     onTap: () {
            //       // _showMyBottomSheet();
            //     },
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
