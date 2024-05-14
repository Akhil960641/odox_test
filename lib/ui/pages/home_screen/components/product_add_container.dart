import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:odox_test/data/models/product_model.dart';
import 'package:odox_test/ui/pages/home_screen/components/cubit/product_add_container_cubit.dart';

import '../../../../data/models/cart_items_model.dart';
import '../../../../utils/colors.dart';
import '../../../../utils/strings.dart';
import '../../../components/app_text.dart';
import '../../../components/btn_primary_gradient.dart';

class Counter extends StatelessWidget {
  const Counter({super.key, this.selectProductCount = 0, this.data, this.customerName, this.isCartPage = false, this.id, this.cartData});
  final int selectProductCount;
  final ProductModel? data;
  final CartItem? cartData;
  final String? customerName, id;
  final bool isCartPage;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProductAddContainerCubit(selectProductCount),
      child: BlocBuilder<ProductAddContainerCubit, ProductAddContainerState>(
        builder: (context, state) {
          final cubit = context.read<ProductAddContainerCubit>();
          return Container(
            child: cubit.productCount == 0
                ? BtnPrimaryGradient(
                    width: 70,
                    height: 30,
                    onTap: () {
                      cubit.increment();
                      cubit.addItem(
                          CartItem(
                            image: data!.image!.toString(),
                            id: data!.id.toString(), title: data!.title.toString(), price: data!.price!.toDouble(), quantity: cubit.productCount, description: customerName.toString()));
                    },
                    text: "Add",
                    fontSize: 14,
                    bgColor: primaryColor,
                    borderRadius: 5,
                    family: inter600,
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          cubit.decreaseCartItemQuantity(isCartPage ? id.toString() : data!.id.toString());
                          // cubit.deleteItem(int.parse(id.toString()));
                        },
                        child: Container(
                            width: 20,
                            height: 30,
                            alignment: Alignment.center,
                            decoration: const BoxDecoration(
                                color: primaryColor,
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(5),
                                  topLeft: Radius.circular(5),
                                )),
                            child: const AppText("-", family: inter600, color: colorWhite, size: 18)),
                      ),
                      Container(
                        width: 30,
                        height: 30,
                        decoration: const BoxDecoration(
                          color: primaryColor,
                        ),
                        child: Center(
                          child: AppText(
                            cubit.productCount,
                            family: inter600,
                            color: colorWhite,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          cubit.increaseCartItemQuantity(isCartPage ? id.toString() : data!.id.toString());
                          // cubit.addItem(CartItem(
                          //     productName: data!.name.toString(),
                          //     price: data!.price!.toDouble(),
                          //     quantity: cubit.productCount,
                          //     customerName: customerName.toString()));
                        },
                        child: Container(
                            width: 20,
                            height: 30,
                            alignment: Alignment.center,
                            decoration: const BoxDecoration(
                                color: primaryColor,
                                borderRadius: BorderRadius.only(
                                  bottomRight: Radius.circular(5),
                                  topRight: Radius.circular(5),
                                )),
                            child: const AppText("+", family: inter600, color: colorWhite, size: 18)),
                      ),
                    ],
                  ),
          );
        },
      ),
    );
  }
}
