import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CartDetailsScreen extends StatelessWidget {
  final String itemName;
  final String itemDescription;
  final String itemManufacturingDate;
  final String itemImageUrl;

  CartDetailsScreen(
      {Key? key,
      required this.itemName,
      required this.itemDescription,
      required this.itemManufacturingDate,
      required this.itemImageUrl})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    double blockWidth = width / 100;
    double blockHeight = height / 100;
    return Scaffold(
      appBar: AppBar(
        title: Text(this.itemName),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              Container(
                child: Container(
                  width: width,
                  child: Container(
                    padding: EdgeInsets.all(12.0),
                    width: width,
                    height: blockHeight * 40.0,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(20.0))),
                    child: Container(
                      child: CachedNetworkImage(
                        fit: BoxFit.cover,
                        imageUrl: this.itemImageUrl,
                        errorWidget: (context, url, error) => Icon(Icons.error),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 24.0),
              Container(
                child: Text(
                  this.itemName,
                  style: TextStyle(fontSize: 40.0),
                ),
              ),
              SizedBox(height: 24.0),
              Container(
                padding: EdgeInsets.only(left: 10.0),
                child: Text(
                  this.itemDescription,
                  style: TextStyle(fontSize: 40.0),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
