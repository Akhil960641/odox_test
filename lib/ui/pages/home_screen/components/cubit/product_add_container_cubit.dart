// ignore_for_file: unnecessary_null_comparison, depend_on_referenced_packages, unnecessary_import

import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:meta/meta.dart';

import '../../../../../data/models/cart_items_model.dart';

part 'product_add_container_state.dart';

class ProductAddContainerCubit extends Cubit<ProductAddContainerState> {
  ProductAddContainerCubit(this.productCount)
      : super(ProductAddContainerInitial()) {
    getCartItems();
  }

  int productCount;

  increment() {
    productCount += 1;
    emit(ProductAddContainerInitial());
  }

  decrement() {
    if (productCount > 0) {
      productCount -= 1;
      emit(ProductAddContainerInitial());
    }
  }

  final boxName = 'cartBox';
  bool clicked = false;

  void addItem(CartItem item) async {
    clicked = true;
    log(clicked.toString());

    var box = await Hive.openBox<CartItem>(boxName);
    box.put(item.id, item); 
    emit(AddToCartDataLoaded(box: box.values.toList()));
  }

  void increaseCartItemQuantity(String id) async {
    increment();
    clicked = true;

    log(clicked.toString());

    var box = await Hive.openBox<CartItem>(boxName);
    CartItem? cartItem = box.get(id);

    if (cartItem != null) {
      cartItem.quantity += 1;
      box.put(id, cartItem); 
      getCartItems();
      emit(AddToCartDataLoaded(box: box.values.toList()));

    }
  }

  // void addItem(CartItem item) async {
  //   var box = await Hive.openBox<CartItem>(boxName);
  //   box.add(item);
  //   emit(AddToCartDataLoaded(box: box.values.toList()));
  // }

  // void increaseCartItemQuantity(String id) async {
  //   increment();
  //   var box = await Hive.openBox<CartItem>(boxName);
  //   CartItem cartItem = box.values.firstWhere((item) => item.id == id);

  //   if (cartItem != null) {
  //     cartItem.quantity += 1;
  //     // await box.putAt(int.parse(cartItem.id), cartItem);
  //     getCartItems();
  //     // Update the cart state after incrementing
  //   }
  // }
  void decreaseCartItemQuantity(String id) async {
    log(clicked.toString());
    decrement();
    var box = await Hive.openBox<CartItem>(boxName);
    CartItem? cartItem = box.get(id);

    if (cartItem != null && cartItem.quantity > 0) {
      cartItem.quantity -= 1;
    if (productCount == 0) clicked = false;
      
      box.put(id, cartItem); 
      getCartItems();
      emit(AddToCartDataLoaded(box: box.values.toList()));
    }
  }

  Future<void> getCartItems() async {
    try {
      var box = await Hive.openBox<CartItem>(boxName);
      List<CartItem?> cartItems = box.values.toList();
      double totalPrice = 0;
      double totalTaxPrice = 0;

      for (var item in cartItems) {
        totalPrice += item!.price * item.quantity;
        totalTaxPrice = totalPrice + 50;
      }
      debugPrint(totalTaxPrice.toString());
      emit(AddToCartDataLoaded(
          box: box.values.toList(),
          totalTaxPrice: totalTaxPrice.toString(),
          totalPrice: totalPrice.toString()));

      debugPrint("........$totalPrice $totalTaxPrice");
    } catch (e) {
      log(e.toString());
    }
  }

  Future<void> deleteItem(int id) async {
    var box = await Hive.openBox<CartItem>(boxName);
    await box.deleteAt(id);
    getCartItems();
    emit(AddToCartDataLoaded(box: box.values.toList()));
  }
}
