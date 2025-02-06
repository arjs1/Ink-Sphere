import 'dart:async';

import 'package:flutter/material.dart';
import 'package:ink_sphere/core/api/blog_api.dart';
import 'package:ink_sphere/pages/CreateBloggPage/model/blog_model.dart';

class BlogProvider with ChangeNotifier {
  List<BlogModel> _data = [];
  final StreamController<List<dynamic>> _dataStreamController =
      StreamController.broadcast();
  Stream<List<dynamic>> get dataStream => _dataStreamController.stream;
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  // Fetch Data from API and update Stream
  Future<void> fetchData() async {
    _isLoading = true;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      notifyListeners();
    });

    try {
      _data = await ApiFetchBlog().fetchBlog();
      _dataStreamController.sink.add(_data); // Updates Stream
    } catch (e) {
      print("Error: $e");
    } finally {
      _isLoading = false;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        notifyListeners();
      });
    }
  }

  // Dispose StreamController to prevent memory leaks
  @override
  void dispose() {
    _dataStreamController.close();
    super.dispose();
  }
}
