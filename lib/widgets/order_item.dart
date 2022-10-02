import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_shop/providers/orders.dart' as ord;

class OrderItem extends StatefulWidget {
  final ord.OrderItem orders;
  OrderItem(this.orders);

  @override
  _OrderItemState createState() => _OrderItemState();
}

class _OrderItemState extends State<OrderItem> {
  var _expanded = false;
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      height: _expanded
          ? min(180, widget.orders.product.length * 20.0 + 100.0)
          : 95,
      child: Card(
          child: Column(
        children: [
          ListTile(
            title: Text('${widget.orders.amount}'),
            subtitle: Text(DateFormat('MMM dd/yyyy   hh:mm')
                .format(widget.orders.dateTime)),
            trailing: IconButton(
              icon: Icon(_expanded ? Icons.expand_less : Icons.expand_more),
              onPressed: () {
                setState(() {
                  _expanded = !_expanded;
                });
              },
            ),
          ),
          AnimatedContainer(
            duration: Duration(milliseconds: 300),
            padding: EdgeInsets.symmetric(
              horizontal: 15,
              vertical: 4,
            ),
            height: _expanded
                ? min(180, widget.orders.product.length * 20.0 + 10.0)
                : 0,
            child: ListView(
              children: widget.orders.product
                  .map(
                    (e) => Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          e.title,
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          '${e.quantity}x \$${e.price}',
                          style: TextStyle(
                            fontSize: 18.0,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  )
                  .toList(),
            ),
          )
        ],
      )),
    );
  }
}
