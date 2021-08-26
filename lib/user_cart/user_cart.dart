import 'package:cart_app/models/cart_category_model.dart';
import 'package:cart_app/provider/cart_list_provider.dart';
import 'package:cart_app/widgets/cart_item_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserCart extends StatefulWidget {
  UserCart({Key? key}) : super(key: key);

  @override
  _UserCartState createState() => _UserCartState();
}

class _UserCartState extends State<UserCart> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Cart"),
      ),
      body: Container(child:
          Consumer<CartListProvider>(builder: (context, provider, child) {
        return Container(
            margin: EdgeInsets.only(left: 20.0, top: 20.0, right: 20.0),
            child: provider.cartList.length == 0
                ? Center(child: Container(child: Text("EMPTY")))
                : ReorderableListView.builder(
                    itemCount: provider.cartList.length,
                    itemBuilder: (context, index) {
                      return CartItemCard(
                        key: Key(provider.cartList[index].id.toString()),
                        itemList: provider.cartList[index],
                        isInCart: true,
                      );
                    },
                    onReorder: (int oldIndex, int newIndex) {
                      setState(() {
                        if (oldIndex < newIndex) {
                          newIndex -= 1;
                        }
                        final CartCategoryModel item =
                            provider.cartList.removeAt(oldIndex);
                        provider.cartList.insert(newIndex, item);
                      });
                    },
                  ));
      })),
    );
  }
}
