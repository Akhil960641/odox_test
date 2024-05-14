import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:odox_test/data/models/product_model.dart';
import 'package:odox_test/ui/components/app_bar_custom.dart';
import 'package:odox_test/ui/components/app_text.dart';
import 'package:odox_test/utils/extensions/margin_ext.dart';

import '../home_screen/components/product_add_container.dart';

class ProductDetails extends StatelessWidget {
  const ProductDetails({super.key, required this.data});
  final ProductModel data;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppAppbar(
        title: data.title,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                height: 380,
                decoration: BoxDecoration(
                  image: DecorationImage(image: NetworkImage(data.image!))
                ),
              )
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AppText(
                    "₹${data.price}",
                    size: 28,
                    color: Colors.grey.shade700,
                  ),
                  Container(
                    height: 45,
                    width: 45,
                    decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(10)),
                    child: Center(
                      child: AppText(data.rating!.rate),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: AppText(data.description),
            ),
            SizedBox(
                height: 50,
                width: 100,
                child: Counter(data: data, customerName: "title")),
            50.hBox
          ],
        ),
      ),
    );
  }
}
