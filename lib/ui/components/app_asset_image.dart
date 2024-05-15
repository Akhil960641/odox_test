import 'package:flutter/material.dart';

import '../../utils/strings.dart';

class AppAssetImg extends StatelessWidget {
  const AppAssetImg({super.key, required this.imageName, this.fit, this.width, this.height});

  final String imageName;
  final BoxFit? fit;
  final double? width, height;

  @override
  Widget build(BuildContext context) => Image.asset('$imagePath/$imageName', fit: fit, width: width, height: height);
}
