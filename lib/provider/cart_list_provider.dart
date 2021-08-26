import 'package:cart_app/models/cart_category_model.dart';
import 'package:flutter/material.dart';

class CartListProvider extends ChangeNotifier {
  final List<CartCategoryModel> cartList = [];

  void addItem(CartCategoryModel item) {
    cartList.add(item);
    notifyListeners();
  }

  void removeItem(int id) {
    cartList.removeWhere((element) => element.id == id);
    notifyListeners();
  }
}
