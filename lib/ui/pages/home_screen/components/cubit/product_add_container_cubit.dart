// ignore_for_file: unnecessary_null_comparison, depend_on_referenced_packages, unnecessary_import

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
    var box = await Hive.openBox<CartItem>(boxName);
    box.put(item.id, item); // Use id as the key
    emit(AddToCartDataLoaded(box: box.values.toList()));
  }

  void increaseCartItemQuantity(String id) async {
    increment();
    var box = await Hive.openBox<CartItem>(boxName);
    CartItem? cartItem = box.get(id);

    if (cartItem != null) {
      
      cartItem.quantity += 1;
      box.put(id, cartItem); // Update existing item
      getCartItems();
    }
  }

  void decreaseCartItemQuantity(String id) async {
    decrement();
    var box = await Hive.openBox<CartItem>(boxName);
    CartItem? cartItem = box.get(id);

    if (cartItem != null && cartItem.quantity > 0) {
      cartItem.quantity -= 1;
      box.put(id, cartItem); // Update existing item
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
      print(e);
    }
  }

  Future<void> deleteItem(int id) async {
    var box = await Hive.openBox<CartItem>(boxName);
    await box.deleteAt(id);
    getCartItems();
    emit(AddToCartDataLoaded(box: box.values.toList()));
  }
}
