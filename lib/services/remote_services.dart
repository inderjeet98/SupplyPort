import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

//models import
import '../model/promooffer.dart';

class RemoteService {
  static var client = http.Client();

  static Future<dynamic> fetchCarouselData() async {
    List<PromoOffers> promoOffers = [];
    try {
      promoOffers.clear();
      var url =
          "http://staging.ireckoner.com:3000/transaction/getPromoOffers?ProfileId=92000067_Live";
      final response = await http.get(Uri.parse(url));
      var data = jsonDecode(response.body.toString());
      print(data);
      if (response.statusCode == 200) {
        // for (Map<String, dynamic> index in data) {
        //   promoOffers.add(PromoOffers.fromJson(index));
        // }
        print(promoOffers[0].data.length);
        return response.body;
      }
    } catch (err) {
      return null;
    }
  }
}
