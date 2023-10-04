import 'dart:convert';
import 'package:http/http.dart' as http;

class USNewsAPI{
  Future<dynamic> getUsNews() async{
    String url = "https://newsapi.org/v2/top-headlines?country=us&apiKey=d62e3fddfbac4845b7355633aa97cd4c";
    var res = await http.get(Uri.parse(url));
    if (res.statusCode == 200) {
      return jsonDecode(res.body);
    } else {
      return null;
    }
  }
}