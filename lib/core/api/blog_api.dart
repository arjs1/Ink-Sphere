import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:ink_sphere/core/provider/user_auth_data_provider.dart';
import 'package:ink_sphere/pages/CreateBloggPage/model/blog_model.dart';
import 'package:provider/provider.dart';

class ApiFetchBlog {
  final String baseUrl = "https://blogapp-production-53f2.up.railway.app/blogs";

  Future<void> createBlog(
    String title,
    String content,
    String categoryName,
    BuildContext context,
  ) async {
    final userAuth =
        Provider.of<UserAuthDataProvider>(context, listen: false).authToken;
    final createUrl = "$baseUrl/create/";
    final uri = Uri.parse(createUrl);
    final response = await http.post(
      uri,
      headers: {
        "Content-Type": "application/json",
        "Authorization": 'Token $userAuth',
      },
      body: jsonEncode({
        "title": title,
        "content": content,
        "category_name": categoryName,
      }),
    );
    if (response.statusCode == 201) {
      final responseBody = jsonDecode(response.body);
      // debugPrint(responseBody);
      debugPrint("successfull");
    } else {
      debugPrint("error while posting");
    }
  }
  // static Future<List<dynamic>> fetchData() async {
  //   final response = await http.get(Uri.parse('$baseUrl/data'));

  //   if (response.statusCode == 200) {
  //     return jsonDecode(response.body);
  //   } else {
  //     throw Exception('Failed to load data');
  //   }
  // }

  Future<List<BlogModel>> fetchBlog() async {
    final uri = Uri.parse("$baseUrl/posts/");
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      List<BlogModel> blogsData =
          data.map((e) => BlogModel.fromJson(e)).toList();
      return blogsData;
    } else {
      print(response.body);
      throw Exception('Failed to load doctors');
    }
  }
}
