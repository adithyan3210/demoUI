import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:uidemo/screens/Add_product/product_model.dart';

class ApiService {
  static String baseUrl = "https://dummyjson.com/products";
  static Future<List<Products>> fetchUsers() async {
    List<Products> list = [];
    final response = await http.get(Uri.parse(baseUrl));
   
    if (response.statusCode == 200) {
      var s = jsonDecode(response.body.toString());
      MainProduct u = MainProduct.fromJson(s);
      list = u.products;
      return list;
    } else {
      throw Exception('unable to fetch users');
    }
  }
}
