import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:modul/1/second_day/models/user.dart';
import 'package:modul/1/second_day/repository/provider.dart';

class UserRepository implements DataProvider {
 static final Dio dio = Dio();

  @override
  Future<List<User>> getData() async {
    try {
      await dotenv.load();
      final String endpoint = dotenv.env['API_URL'] ?? 'https://jsonplaceholder.typicode.com/users';
      final Response response = await dio.get(endpoint);
      if (response.statusCode == 200) {
        final dynamic body = response.data;
        if (body != null && body is List) {
          var json = body.map((element) => User.fromJson(element)).toList();
          return json;
        } else {
          throw Exception('eror');
        }
      } else {
        throw Exception('gagal untuk load data');
      }
    } catch (e) {
      debugPrint('eror : $e');
      throw Exception('gagal untuk load data');
    
    }
  }

 
}
