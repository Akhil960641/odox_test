import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:odox_test/ui/components/app_bar_custom.dart';
import 'package:odox_test/ui/pages/auth/login_page.dart';
import 'package:odox_test/ui/pages/cart_page/cart_page.dart';
import 'package:odox_test/ui/pages/home_screen/components/product_add_container.dart';
import 'package:odox_test/ui/pages/home_screen/cubit/home_screen_cubit.dart';
import 'package:odox_test/ui/pages/product_details/product_details.dart';
import 'package:odox_test/utils/extensions/margin_ext.dart';
import 'package:odox_test/utils/shared/page_navigator.dart';
import '../../../utils/colors.dart';
import '../../components/app_cached_image.dart';
import '../../components/app_text.dart';
import '../../components/dividers.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppAppbar(
        isHomePage: true,
        actions: [
          GestureDetector(
              onTap: () => Screen.open(context,const CartPage()),
              child:const Icon(
                Icons.trolley,
                size: 30,
              )),
          10.wBox
        ],
      ),
      body: BlocProvider(
        create: (context) => HomeScreenCubit(context),
        child: BlocBuilder<HomeScreenCubit, HomeScreenState>(
          builder: (context, state) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 10.hBox,
                Expanded(
                  child: state is ViewAllProduct
                      ? state.product.isEmpty
                          ? const Center(child: AppText("No Data"))
                          : ListView(
                              shrinkWrap: true,
                              children: [
                                GridView.builder(
                                  shrinkWrap: true,
                                  itemCount: state.product.length,
                                  padding: const EdgeInsets.only(
                                      right: 12, left: 12, bottom: 128),
                                  physics: const NeverScrollableScrollPhysics(),
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    childAspectRatio: 0.9,
                                    crossAxisSpacing: 16,
                                    mainAxisSpacing: 16,
                                  ),
                                  itemBuilder: (context, index) {
                                    final data = state.product[index];
                                    return GestureDetector(
                                      onTap: () => Screen.open(
                                          context, ProductDetails(data: data)),
                                      child: Card(
                                        elevation: 5,
                                        margin: EdgeInsets.zero,
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 12, vertical: 1),
                                          decoration: BoxDecoration(
                                            color: colorWhite,
                                            borderRadius:
                                                BorderRadius.circular(6),
                                          ),
                                          child: Column(
                                            children: [
                                              7.hBox,
                                              CachedImage(
                                                imageUrl: '${data.image}',
                                                height: 80,
                                              ),
                                              20.hBox,
                                              Expanded(
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        SizedBox(
                                                          width: 60,
                                                          child: AppText(
                                                            data.title,
                                                            color: const Color
                                                                .fromARGB(234,
                                                                61, 60, 60),
                                                            size: 12,
                                                            weight:
                                                                FontWeight.w500,
                                                            maxLines: 2,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                          ),
                                                        ),
                                                        AppText(
                                                          "₹${data.price}/-",
                                                          color: Colors.black45,
                                                          size: 12,
                                                          weight:
                                                              FontWeight.w500,
                                                        ),
                                                      ],
                                                    ),
                                                    CustomPaint(
                                                      size: const Size(4.5, 50),
                                                      painter: CurvePainter(),
                                                    ),
                                                    Counter(
                                                        data: data,
                                                        customerName: "title"),
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ],
                            )
                      : const Center(child: CupertinoActivityIndicator()),
                ),
              ],
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => FirebaseAuth.instance.signOut().then((value) => Screen.openAsNewPage(context, LoginScreen())),
        child: Icon(Icons.logout),
      ),
    );
  }
}
