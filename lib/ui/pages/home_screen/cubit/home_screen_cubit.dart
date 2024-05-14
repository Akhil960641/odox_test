import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:odox_test/data/services/urls.dart';
import 'package:http/http.dart' as http;
import '../../../../data/models/product_model.dart';

part 'home_screen_state.dart';

class HomeScreenCubit extends Cubit<HomeScreenState> {
  HomeScreenCubit(this.context) : super(HomeScreenInitial()) {
    productGet();
  }

  BuildContext context;

  productGet() async {
    try {
      final response = await http.get(Uri.parse(baseUrl + productListUrl));
      debugPrint(response.body);
      final res = jsonDecode(response.body);
      // final data = ProductModel.fromJson(res);
      final List<ProductModel> data =
          List<ProductModel>.from(res.map((x) => ProductModel.fromJson(x)));
      emit(ViewAllProduct(product: data));
    } catch (e) {
      print(e);
    }
  }
}
