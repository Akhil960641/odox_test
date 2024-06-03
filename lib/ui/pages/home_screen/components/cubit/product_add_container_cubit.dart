// ignore_for_file: unnecessary_null_comparison, depend_on_referenced_packages, unnecessary_import

import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:meta/meta.dart';

import '../../../../../data/models/cart_items_model.dart';

part 'product_add_container_state.dart';

class ProductAddContainerCubit extends Cubit<ProductAddContainerState> {
  ProductAddContainerCubit()
      : super(ProductAddContainerInitial()) {
    // getCartItems();
  }

}
