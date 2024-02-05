import 'dart:convert';

import 'package:dio/dio.dart';

class FetchData {
  static Dio dio = Dio();
  int maxProduct = 10;
  Future<void> getData() async {
    const String endpoint = 'https://dummyjson.com/products';
    try {
      final Response response = await dio.get(endpoint);
      if (response.statusCode == 200) {
        final dynamic body = jsonEncode(response.data);
        print(body);
      }
    } catch (e) {}
  }
}

void main() {
  FetchData fetchData = FetchData();
  fetchData.getData();
}
