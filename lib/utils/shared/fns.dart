import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:odox_test/ui/pages/auth/login_page.dart';
import 'package:odox_test/utils/shared/page_navigator.dart';
import '../../../../../data/models/cart_items_model.dart';

bool isLoading = false;

void get hideKeyboard => FocusManager.instance.primaryFocus?.unfocus();

class Helper {
 static Future<void> clearCart(BuildContext context) async {
    var box = await Hive.openBox<CartItem>("cartBox");
    await box.clear();
        FirebaseAuth.instance.signOut().then((value) => Screen.openAsNewPage(context,const LoginScreen()));

  } 
}
