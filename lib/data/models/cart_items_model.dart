import 'package:hive/hive.dart';
part 'cart_items_model.g.dart';

@HiveType(typeId: 0)
class CartItem {
  @HiveField(0)
  String id;

  @HiveField(1)
  String title;

  @HiveField(2)
  double price;

  @HiveField(3)
  int quantity;

  @HiveField(4)
  String description;

  @HiveField(5)
  String image;

  CartItem({
    required this.id,
    required this.title,
    required this.price,
    required this.quantity,
    required this.description,
    required this.image, 
  });
}
