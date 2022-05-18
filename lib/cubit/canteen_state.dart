part of 'canteen_cubit.dart';

class CanteenState {
  CanteenState(
      {required this.cart_items,
      required this.currentuser,
      required this.currentCanteenUser});

  List<Widget> cart_items;
  appUser currentuser;
  canteenUser currentCanteenUser;
}
