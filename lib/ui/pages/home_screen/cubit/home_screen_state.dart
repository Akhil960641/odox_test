part of 'home_screen_cubit.dart';

@immutable
sealed class HomeScreenState {}

final class HomeScreenInitial extends HomeScreenState {}

final class ViewAllProduct extends HomeScreenState {
  final List<ProductModel> product;
  ViewAllProduct({required this.product});
}
