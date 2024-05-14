import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:odox_test/utils/shared/app_snackbar.dart';
import 'package:odox_test/utils/shared/helper_loader.dart';

import '../../../../utils/shared/page_navigator.dart';
import '../../home_screen/home_screen.dart';

part 'login_screen_state.dart';

class LoginScreenCubit extends Cubit<LoginScreenState> {
  LoginScreenCubit(this.context) : super(LoginScreenInitial());

  bool passwordVisible = true;
  bool valueChange = true;

  TextEditingController emailCtr = TextEditingController();
  TextEditingController passwordCtr = TextEditingController();
  BuildContext context;
  void passChange() {
    passwordVisible = !passwordVisible;
    emit(LoginScreenInitial());
  }

  bool screenVisible = false;

  void screenChange() {
    screenVisible = !screenVisible;
    emit(LoginScreenInitial());
  }

  createUserWithEmailAndPassword(context) async {
    if (emailCtr.text.isNotEmpty && passwordCtr.text.isNotEmpty) {
      try {
        loader(context: context);
        final FirebaseAuth auth = FirebaseAuth.instance;
 await auth.createUserWithEmailAndPassword(
          email: emailCtr.text.trim(),
          password: passwordCtr.text.trim(),
        )
        .then((value) => Screen.openAsNewPage(context, const HomeScreen()));
      } on FirebaseAuthException catch (e) {
        hideLoader(context);
        if (e.code == 'weak-password') {
          snackBar(context, message: 'The password provided is too weak.');
        } else if (e.code == 'email-already-in-use') {
          snackBar(context,
              message: 'The account already exists for that email.');
        } else {
          snackBar(context, message: e.code);
        }
      } catch (e) {
        hideLoader(context);

        debugPrint(e.toString());
      }
    } else {
      snackBar(context, message: "Invalid username or password");
    }
  }

  signInWithEmailAndPassword(context) async {
    if (emailCtr.text.isNotEmpty && passwordCtr.text.isNotEmpty) {
      try {
        loader(context: context);

        final FirebaseAuth auth = FirebaseAuth.instance;
         await auth
            .signInWithEmailAndPassword(
              email: emailCtr.text.trim(),
              password: passwordCtr.text.trim(),
            )
            .then((value) => Screen.openAsNewPage(context, const HomeScreen()));
      } on FirebaseAuthException catch (e) {
        hideLoader(context);
        snackBar(context, message: e.code);
      } catch (e) {
        hideLoader(context);

        snackBar(context, message: e.toString());
      }
    } else {
      snackBar(context, message: "Invalid username or password");
    }
  }

}
