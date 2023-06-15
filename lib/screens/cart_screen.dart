import 'package:flutter/material.dart';

class Product {
  final String name;
  final double price;

  Product({required this.name, required this.price});
}

class CartItem {
  final Product product;
  int quantity;

  CartItem({required this.product, this.quantity = 1});
}

class Cart {
  List<CartItem> items = [];

  void addToCart(Product product) {
    bool found = false;

    for (var item in items) {
      if (item.product.name == product.name) {
        item.quantity++;
        found = true;
        break;
      }
    }

    if (!found) {
      items.add(CartItem(product: product));
    }
  }
}

class CartView extends StatefulWidget {
  @override
  State<CartView> createState() => _CartViewState();
}

class _CartViewState extends State<CartView> {
  final Cart cart = Cart();
  List<Order> items = List.of(Data.order);
  @override
  void dismissItem(
    BuildContext context,
    int index,
    DismissDirection direction,
  ) {
    setState(() {
      items.removeAt(index);
    });

    switch (direction) {
      case DismissDirection.endToStart:
        showDialog<String>(
            context: context,
            builder: (BuildContext context) => AlertDialog(
                  content: const Text('The order has been canceled'),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () => Navigator.pop(context, 'OK'),
                      child: const Text('OK'),
                    ),
                  ],
                ));
        // Utils.showSnackBar(context, 'Order has been Canceled');
        break;
      case DismissDirection.startToEnd:
        showDialog<String>(
            context: context,
            builder: (BuildContext context) => AlertDialog(
                  title: const Text(
                    'Order has been Accepted',
                    style: TextStyle(fontSize: 15),
                  ),
                  content: const Text('The seller will contact you soon'),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () => Navigator.pop(context, 'OK'),
                      child: const Text('OK'),
                    ),
                  ],
                ));
        // Utils.showSnackBar(context, 'Order has been Accepted');
        break;
      default:
        break;
    }
  }

  Widget buildListTile(Order item) => ListTile(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 16,
        ),
        leading: Container(
          padding: const EdgeInsets.only(right: 12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            image: DecorationImage(
              image: AssetImage(item.imageAssets),
              fit: BoxFit.cover,
            ),
          ),
          width: 50,
          height: 50,
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              item.itemName,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            Text(item.message)
          ],
        ),
        onTap: () {},
      );
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Add to Cart Demo',
      home: Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
              color: Colors.white,
              icon: Icon(Icons.restore),
              onPressed: () {
                setState(() {
                  items = List.of(Data.order);
                });
              },
            ),
          ],
          backgroundColor: const Color(0XFFc37e37),
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back)),
          title: Text('Add to Cart'),
        ),
        body: ListView.separated(
          itemCount: items.length,
          separatorBuilder: (context, index) => Divider(),
          itemBuilder: (context, index) {
            final item = items[index];

            return DismissibleWidget(
              item: item,
              child: buildListTile(item),
              onDismissed: (direction) =>
                  dismissItem(context, index, direction),
            );
          },
        ),
        floatingActionButton: FloatingActionButton.extended(
          backgroundColor: const Color(0XFFc37e37),
          onPressed: () {
            showDialog<String>(
                context: context,
                builder: (BuildContext context) => AlertDialog(
                      title: const Text(
                        'Order has been Accepted',
                        style: TextStyle(fontSize: 15),
                      ),
                      content: const Text('The seller will contact you soon'),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () => Navigator.pop(context, 'OK'),
                          child: const Text('OK'),
                        ),
                      ],
                    ));
          },
          label: Text('Cart'),
          icon: Icon(Icons.shopping_cart),
        ),
      ),
    );
  }
}

//*** */
class Order {
  final String imageAssets;
  final String itemName;
  final String message;
  const Order({
    required this.imageAssets,
    required this.itemName,
    required this.message,
  });
}

class Data {
  static const order = <Order>[
    Order(
      imageAssets: 'assets/images/intro1.png',
      itemName: 'Edwardian Mahogany Breakfront Sideboard',
      message: 'Delivering from: Wrexham, United Kingdom (UK)',
    ),
    Order(
      imageAssets: 'assets/images/intro1.png',
      itemName: 'Edwardian Inlaid Mahogany Washstand',
      message: 'Delivering from: addis ababa, Ethiopia',
    ),
    Order(
      imageAssets: 'assets/images/intro1.png',
      itemName: 'Solid Wood Antique Leisure Sofa Chair',
      message: 'Delivering from: addis ababa, Ethiopia',
    ),
  ];
}

class DismissibleWidget<T> extends StatelessWidget {
  final T item;
  final Widget child;
  final DismissDirectionCallback onDismissed;

  const DismissibleWidget({
    required this.item,
    required this.child,
    required this.onDismissed,
    //required Key key,
  }) : super();

  @override
  Widget build(BuildContext context) => Dismissible(
        key: ObjectKey(item),
        background: buildSwipeActionLeft(),
        secondaryBackground: buildSwipeActionRight(),
        child: child,
        onDismissed: onDismissed,
      );

  Widget buildSwipeActionLeft() => Container(
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      color: Colors.green,
      child: Row(
        children: const [
          Icon(Icons.check_circle, color: Colors.white, size: 32),
          SizedBox(width: 10),
          Text(
            'Confirm',
            style: TextStyle(
                color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ],
      ));

  Widget buildSwipeActionRight() => Container(
      alignment: Alignment.centerRight,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      color: Colors.red,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: const [
          Icon(Icons.cancel, color: Colors.white, size: 32),
          SizedBox(width: 10),
          Text(
            'Cancel',
            style: TextStyle(
                color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ],
      ));
}
