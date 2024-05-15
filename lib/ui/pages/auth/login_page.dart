import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:odox_test/ui/pages/auth/cubit/login_screen_cubit.dart';
import 'package:odox_test/utils/extensions/margin_ext.dart';

import '../../../utils/colors.dart';
import '../../components/app_text.dart';
import '../../components/app_text_field.dart';
import '../../components/btn_primary_gradient.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocProvider(
      create: (context) => LoginScreenCubit(context),
      child: BlocBuilder<LoginScreenCubit, LoginScreenState>(
        builder: (context, state) {
          final cubit = context.read<LoginScreenCubit>();
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18),
            child: cubit.screenVisible
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const AppText(
                        "Sign Up",
                        weight: FontWeight.w600,
                        size: 22,
                        color: Colors.blue,
                        // ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(left: 0),
                        child: AppText(
                          "Create Account today",
                          weight: FontWeight.w500,
                          size: 12,
                          color: Colors.black38,
                          // ),
                        ),
                      ),
                      const AppTextField(
                        label: "",
                        hint: "Name",
                        isBorderNeeded: true,
                        // controller: cubit.userNameCtr,
                      ),
                      AppTextField(
                        label: "",
                        hint: "Email",
                        isBorderNeeded: true,
                        controller: cubit.emailCtr,
                      ),
                      AppTextField(
                        label: "",
                        hint: "Password",
                        isBorderNeeded: true,
                        suffixIcon: IconButton(
                            onPressed: () {
                              cubit.passChange();
                            },
                            icon: cubit.passwordVisible
                                ? const Icon(Icons.visibility)
                                : const Icon(Icons.visibility_off)),
                        obscureText: cubit.passwordVisible,
                        controller: cubit.passwordCtr,
                      ),
                      30.hBox,
                      BtnPrimaryGradient(
                          onTap: () async {
                            cubit.createUserWithEmailAndPassword(context);
                          },
                          padding: const EdgeInsets.symmetric(horizontal: 25),
                          text: "Sign Up",
                          textColor: colorWhite,
                          fontSize: 13,
                          family: "poppins",
                          bgColor: primaryColor,
                          borderRadius: 10),
                      35.hBox,
                      Row(
                        children: [
                          const AppText("Alredy have account?"),
                          TextButton(
                              onPressed: () => cubit.screenChange(),
                              child: const AppText("Sign In"))
                        ],
                      ),
                    ],
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const AppText(
                        "Sign in",
                        weight: FontWeight.w600,
                        size: 20,
                        color: Colors.blue,
                        // ),
                      ),
                      const AppText(
                        "Welcome back! Please enter your credentials to login",
                        weight: FontWeight.w500,
                        size: 9.5,
                        color: Colors.black,
                        // ),
                      ),
                       AppTextField(
                        label: "",
                        hint: "Email",
                        isBorderNeeded: true,
                        controller: cubit.emailCtr,
                      ),
                      AppTextField(
                        label: "",
                        hint: "Password",
                        isBorderNeeded: true,
                        suffixIcon: IconButton(
                            onPressed: () {
                              cubit.passChange();
                            },
                            icon: cubit.passwordVisible
                                ? const Icon(Icons.visibility)
                                : const Icon(Icons.visibility_off)),
                        obscureText: cubit.passwordVisible,
                        controller: cubit.passwordCtr,
                      ),
                      30.hBox,
                      BtnPrimaryGradient(
                          onTap: () async {
                            cubit.signInWithEmailAndPassword(context);
                          },
                          padding: const EdgeInsets.symmetric(horizontal: 25),
                          text: "Sign In",
                          textColor: colorWhite,
                          fontSize: 13,
                          family: "poppins",
                          bgColor: primaryColor,
                          borderRadius: 10),
                      35.hBox,
                      Row(
                        children: [
                          const AppText("Don't have account?"),
                          TextButton(
                              onPressed: () => cubit.screenChange(),
                              child: const AppText("Sign up"))
                        ],
                      ),
                    ],
                  ),
          );
        },
      ),
    ));
  }
}
