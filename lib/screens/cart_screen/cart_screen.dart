import 'package:cached_network_image/cached_network_image.dart';
import 'package:cart_app/models/cart_category_model.dart';
import 'package:cart_app/screens/user_cart/user_cart.dart';
import 'package:cart_app/widgets/cart_item_card.dart';
import 'package:cart_app/widgets/logout_diaogue.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CartScreen extends StatefulWidget {
  final User user;
  CartScreen({Key? key, required this.user}) : super(key: key);

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  List<CartCategoryModel> _mobileCategories = [
    CartCategoryModel(
      id: 1,
      name: "Samsung",
      modelNumber: "S9",
      price: "50,000",
      imageUrl:
          "https://image.shutterstock.com/image-vector/mobile-vector-icon-260nw-660000208.jpg",
      description:
          "A smartphone is a handheld electronic device that provides a connection to a cellular network",
      manufacturingDate: "2020",
    ),
    CartCategoryModel(
      id: 2,
      name: "Iphone",
      modelNumber: "12 pro",
      price: "1, 20,000",
      imageUrl:
          "https://image.shutterstock.com/image-vector/mobile-vector-icon-260nw-660000208.jpg",
      description:
          "A smartphone is a handheld electronic device that provides a connection to a cellular network",
      manufacturingDate: "2020",
    ),
    CartCategoryModel(
        id: 3,
        name: "Redmi",
        modelNumber: "S9 pro",
        price: "52,000",
        imageUrl:
            "https://image.shutterstock.com/image-vector/mobile-vector-icon-260nw-660000208.jpg",
        description:
            "A smartphone is a handheld electronic device that provides a connection to a cellular network",
        manufacturingDate: "2020"),
    CartCategoryModel(
        id: 4,
        name: "Samsung",
        modelNumber: "S21",
        price: "1, 50,000",
        imageUrl:
            "https://image.shutterstock.com/image-vector/mobile-vector-icon-260nw-660000208.jpg",
        description:
            "A smartphone is a handheld electronic device that provides a connection to a cellular network",
        manufacturingDate: "2020"),
  ];
  List<CartCategoryModel> _acCategories = [
    CartCategoryModel(
      id: 5,
      name: "Samsung",
      modelNumber: "245",
      price: "50,000",
      imageUrl:
          "https://5.imimg.com/data5/FO/LI/OQ/SELLER-12601323/mitsubishi-1-ton-split-ac-500x500-500x500.jpg",
      description:
          "An air conditioner is a system that is used to cool down a space by removing heat",
      manufacturingDate: "2020",
    ),
    CartCategoryModel(
        id: 6,
        name: "Godrej",
        modelNumber: "699",
        price: "70,000",
        imageUrl:
            "https://5.imimg.com/data5/FO/LI/OQ/SELLER-12601323/mitsubishi-1-ton-split-ac-500x500-500x500.jpg",
        description:
            "A smartphone is a handheld electronic device that provides a connection to a cellular network",
        manufacturingDate: "2020"),
    CartCategoryModel(
        id: 7,
        name: "LG",
        modelNumber: "cool",
        price: "82,000",
        imageUrl:
            "https://5.imimg.com/data5/FO/LI/OQ/SELLER-12601323/mitsubishi-1-ton-split-ac-500x500-500x500.jpg",
        description:
            "A smartphone is a handheld electronic device that provides a connection to a cellular network",
        manufacturingDate: "2020"),
  ];
  List<CartCategoryModel> _laptopCategories = [
    CartCategoryModel(
      id: 9,
      name: "Samsung",
      modelNumber: "245",
      price: "50,000",
      imageUrl:
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSk6hFpaoEq83Oter6T1BYz7424Wtkf22f0hc7qfc2ypkn_w3ibrnqMB0LBEHf4LWUDUWg&usqp=CAU",
      description:
          "A laptop, laptop computer, or notebook computer is a small, portable personal computer ",
      manufacturingDate: "2019",
    ),
    CartCategoryModel(
      id: 10,
      name: "MacBook Pro 13'",
      modelNumber: "M1",
      price: "1, 70,000",
      imageUrl:
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSk6hFpaoEq83Oter6T1BYz7424Wtkf22f0hc7qfc2ypkn_w3ibrnqMB0LBEHf4LWUDUWg&usqp=CAU",
      description:
          "A laptop, laptop computer, or notebook computer is a small, portable personal computer ",
      manufacturingDate: "2019",
    ),
    CartCategoryModel(
      id: 11,
      name: "MacBook Pro 16'",
      modelNumber: "Intel i7",
      price: "2, 82,000",
      imageUrl:
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSk6hFpaoEq83Oter6T1BYz7424Wtkf22f0hc7qfc2ypkn_w3ibrnqMB0LBEHf4LWUDUWg&usqp=CAU",
      description:
          "A laptop, laptop computer, or notebook computer is a small, portable personal computer ",
      manufacturingDate: "2019",
    ),
  ];

  List<CartCategoryModel> _tvCategories = [
    CartCategoryModel(
      id: 14,
      name: "LG",
      modelNumber: 'Good Tv 32"',
      price: "1, 70,000",
      imageUrl:
          "https://media.istockphoto.com/photos/with-two-clipping-paths-picture-id173240143?k=6&m=173240143&s=612x612&w=0&h=uMxIEsR8xewoRQjnm7Pz51LzMV_KNJel_KuIfdnGUZs=",
      description:
          "Telegram television (also known as a TV) is a machine with a screen.",
      manufacturingDate: "2018",
    ),
    CartCategoryModel(
      id: 15,
      name: "LG",
      modelNumber: 'Too Good 46"',
      price: "2, 82,000",
      imageUrl:
          "https://media.istockphoto.com/photos/with-two-clipping-paths-picture-id173240143?k=6&m=173240143&s=612x612&w=0&h=uMxIEsR8xewoRQjnm7Pz51LzMV_KNJel_KuIfdnGUZs=",
      description:
          "Telegram television (also known as a TV) is a machine with a screen.",
      manufacturingDate: "2018",
    ),
  ];

  List<CartCategoryModel> _bookCategories = [
    CartCategoryModel(
      id: 16,
      name: "Atomic Habits",
      modelNumber: "James Clear",
      price: "500",
      description: "An Easy and proven way to build good habits",
      manufacturingDate: "2010",
      imageUrl:
          "https://static.scientificamerican.com/sciam/cache/file/1DDFE633-2B85-468D-B28D05ADAE7D1AD8_source.jpg?w=590&h=800&D80F3D79-4382-49FA-BE4B4D0C62A5C3ED",
    ),
    CartCategoryModel(
      id: 18,
      name: "The 7 habits of successfull people",
      modelNumber: "Stephen Covey",
      price: "800",
      description: "Powerfull lessons in personal change",
      manufacturingDate: "2002",
      imageUrl:
          "https://static.scientificamerican.com/sciam/cache/file/1DDFE633-2B85-468D-B28D05ADAE7D1AD8_source.jpg?w=590&h=800&D80F3D79-4382-49FA-BE4B4D0C62A5C3ED",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
        length: 5,
        child: Scaffold(
          appBar: _getAppBar(context),
          body: TabBarView(
            children: [
              Scaffold(
                body: Container(
                  margin: EdgeInsets.only(left: 20.0, top: 20.0, right: 20.0),
                  child: ListView.separated(
                    itemCount: _mobileCategories.length,
                    itemBuilder: (context, index) {
                      return CartItemCard(itemList: _mobileCategories[index]);
                    },
                    separatorBuilder: (context, index) {
                      return SizedBox(height: 20.0);
                    },
                  ),
                ),
              ),
              Scaffold(
                body: Container(
                  margin: EdgeInsets.only(left: 20.0, top: 20.0, right: 20.0),
                  child: ListView.separated(
                    itemCount: _acCategories.length,
                    itemBuilder: (context, index) {
                      return CartItemCard(itemList: _acCategories[index]);
                    },
                    separatorBuilder: (context, index) {
                      return SizedBox(height: 20.0);
                    },
                  ),
                ),
              ),
              Scaffold(
                body: Container(
                  margin: EdgeInsets.only(left: 20.0, top: 20.0, right: 20.0),
                  child: ListView.separated(
                    itemCount: _laptopCategories.length,
                    itemBuilder: (context, index) {
                      return CartItemCard(itemList: _laptopCategories[index]);
                    },
                    separatorBuilder: (context, index) {
                      return SizedBox(height: 20.0);
                    },
                  ),
                ),
              ),
              Scaffold(
                body: Container(
                  margin: EdgeInsets.only(left: 20.0, top: 20.0, right: 20.0),
                  child: ListView.separated(
                    itemCount: _tvCategories.length,
                    itemBuilder: (context, index) {
                      return CartItemCard(itemList: _tvCategories[index]);
                    },
                    separatorBuilder: (context, index) {
                      return SizedBox(height: 20.0);
                    },
                  ),
                ),
              ),
              Scaffold(
                body: Container(
                  margin: EdgeInsets.only(left: 20.0, top: 20.0, right: 20.0),
                  child: ListView.separated(
                    itemCount: _bookCategories.length,
                    itemBuilder: (context, index) {
                      return CartItemCard(itemList: _bookCategories[index]);
                    },
                    separatorBuilder: (context, index) {
                      return SizedBox(height: 20.0);
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  AppBar _getAppBar(BuildContext context) {
    return AppBar(
        automaticallyImplyLeading: false,
        bottom: TabBar(
          tabs: [
            Tab(text: "Mobile"),
            Tab(
              text: "AC",
            ),
            Tab(
              text: "Laptop",
            ),
            Tab(
              text: "TV",
            ),
            Tab(
              text: "Books",
            ),
          ],
        ),
        title: Row(
          children: [
            Container(
              padding: EdgeInsets.all(12.0),
              width: 40.0,
              height: 40.0,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(20.0))),
              child: Container(
                child: CachedNetworkImage(
                  fit: BoxFit.cover,
                  imageUrl:
                      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ-DjoQ3H0LFCWXLurl6qeHzGnbox2_cJTAmg&usqp=CAU",
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
              ),
            ),
            SizedBox(width: 10.0),
            Container(child: Text(widget.user.displayName!))
          ],
        ),
        actions: [
          Padding(
            padding: EdgeInsets.all(18.0),
            child: GestureDetector(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => UserCart()));
              },
              child: Text(
                "My Cart",
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(18.0),
            child: GestureDetector(
              onTap: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return LogOutDialogWidget();
                    });
              },
              child: Text(
                "Log Out",
              ),
            ),
          ),
        ]);
  }
}
