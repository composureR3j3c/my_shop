import 'package:flutter/material.dart';
import 'package:my_shop/providers/orders.dart' show Order;
import 'package:my_shop/widgets/app_drawer.dart';
import 'package:my_shop/widgets/order_item.dart';
import 'package:provider/provider.dart';

class OrdersScreen extends StatefulWidget {
  static const routeName = '/orders-screens';

  @override
  _OrdersScreenState createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  Future? _ordersFuture;
  Future _ordersOrdersFuture() {
    return Provider.of<Order>(context, listen: false).fetchOrders();
  }

  @override
  void initState() {
    _ordersFuture = _ordersOrdersFuture();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: AppDrawer(),
        appBar: AppBar(
          title: Text('Your Orders'),
        ),
        body: FutureBuilder(
          future: _ordersFuture,
          builder: (context, dataSnapshot) {
            if (dataSnapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (dataSnapshot.error != null) {
              return Center(child: Text('An Error Occurred!'));
            } else {
              return Consumer<Order>(
                  builder: (context, orderData, _) => ListView.builder(
                        itemBuilder: (context, i) =>
                            OrderItem(orderData.orders[i]),
                        itemCount: orderData.orders.length,
                      ));
            }
          },
        ));
  }
}
