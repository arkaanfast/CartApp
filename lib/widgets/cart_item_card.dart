import 'package:cached_network_image/cached_network_image.dart';

import 'package:cart_app/models/cart_category_model.dart';
import 'package:cart_app/provider/cart_list_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartItemCard extends StatefulWidget {
  final CartCategoryModel itemList;
  final bool isInCart;

  CartItemCard({Key? key, required this.itemList, this.isInCart = false})
      : super(key: key);

  @override
  _CartItemCardState createState() => _CartItemCardState();
}

class _CartItemCardState extends State<CartItemCard> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartListProvider>(context);
    final snackBar = SnackBar(content: Text('Added Go To Cart'));
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    double blockWidth = width / 100;
    double blockHeight = height / 100;
    return GestureDetector(
      onTap: () {
        setState(() {
          _isExpanded = !_isExpanded;
        });
        // Navigator.push(
        //     context,
        //     MaterialPageRoute(
        //         builder: (context) => CartDetailsScreen(
        //               itemName: this.itemList.name,
        //               itemDescription: this.itemList.itemDescription,
        //               itemImageUrl: this.itemList.imageUrl,
        //             )));
      },
      child: this.widget.isInCart
          ? Dismissible(
              key: Key(this.widget.itemList.id.toString()),
              onDismissed: (direction) {
                print(direction);
                if (this.widget.isInCart) {
                  cartProvider.removeItem(widget.itemList.id);
                }
              },
              background: Container(color: Colors.red),
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: Column(
                  children: [
                    _getDismissingCardRow(blockWidth, blockHeight),
                    _isExpanded
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                    child: Text(widget.itemList.description)),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  child: Text(
                                    "Manufacturing Year:-" +
                                        widget.itemList.manufacturingDate,
                                    style: TextStyle(color: Colors.blue),
                                  ),
                                ),
                              ),
                            ],
                          )
                        : Container()
                  ],
                ),
              ),
            )
          : Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _getCardRow(
                      blockWidth, blockHeight, cartProvider, context, snackBar),
                  _isExpanded
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                  child: Text(widget.itemList.description)),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                child: Text(
                                  "Manufacturing Year:-" +
                                      widget.itemList.manufacturingDate,
                                  style: TextStyle(color: Colors.blue),
                                ),
                              ),
                            ),
                          ],
                        )
                      : Container()
                ],
              ),
            ),
    );
  }

  Widget _getDismissingCardRow(double blockWidth, double blockHeight) {
    return Container(
      child: Row(
        children: [
          Container(
            width: blockWidth * 30.0,
            height: blockHeight * 12.0,
            child: Container(
              padding: EdgeInsets.all(12.0),
              child: Container(
                child: CachedNetworkImage(
                  fit: BoxFit.cover,
                  imageUrl: this.widget.itemList.imageUrl,
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                  width: blockWidth * 50.0,
                  child: Text(this.widget.itemList.name,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontSize: 26.0))),
              SizedBox(height: 10.0),
              Container(
                  child: Text(this.widget.itemList.modelNumber,
                      style: TextStyle(fontSize: 12.0))),
              SizedBox(height: 6.0),
              Container(
                  child: Text("₹ ${this.widget.itemList.price}",
                      style: TextStyle(fontSize: 18.0)))
            ],
          ),
          Container(
            padding: EdgeInsets.only(bottom: 4.0),
            child: Text("Swipe", style: TextStyle(fontSize: 8.0)),
          )
        ],
      ),
    );
  }

  Widget _getCardRow(double blockWidth, double blockHeight,
      CartListProvider cartProvider, BuildContext context, SnackBar snackBar) {
    return Container(
      child: Row(
        children: [
          Container(
            width: blockWidth * 30.0,
            height: blockHeight * 12.0,
            child: Container(
              padding: EdgeInsets.all(12.0),
              child: Container(
                child: CachedNetworkImage(
                  fit: BoxFit.cover,
                  imageUrl: this.widget.itemList.imageUrl,
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                  width: blockWidth * 50.0,
                  child: Text(this.widget.itemList.name,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontSize: 26.0))),
              SizedBox(height: 10.0),
              Container(
                  child: Text(this.widget.itemList.modelNumber,
                      style: TextStyle(fontSize: 12.0))),
              SizedBox(height: 6.0),
              Container(
                  child: Text("₹ ${this.widget.itemList.price}",
                      style: TextStyle(fontSize: 18.0)))
            ],
          ),
          Container(
            padding: EdgeInsets.only(bottom: 4.0),
            child: GestureDetector(
              onTap: () {
                cartProvider.addItem(widget.itemList);
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              },
              child: Text("Add", style: TextStyle(fontSize: 12.0)),
            ),
          )
        ],
      ),
    );
  }
}
