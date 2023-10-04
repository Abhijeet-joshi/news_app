import 'dart:convert';
import 'package:http/http.dart' as http;

class IndiaNewsAPI{
  Future<dynamic> getAPI({required String CAT}) async{
    String url = "https://newsapi.org/v2/top-headlines?country=in&category=$CAT&apiKey=d62e3fddfbac4845b7355633aa97cd4c";
    var res = await http.get(Uri.parse(url));
    if (res.statusCode == 200) {
      return jsonDecode(res.body);
    } else {
      return null;
    }
  }
}