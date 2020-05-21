import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:link/models/orders.dart';
import 'orders_tile.dart';

class OrdersList extends StatefulWidget {
  @override
  _OrdersListState createState() => _OrdersListState();
}

class _OrdersListState extends State<OrdersList> {
  @override
  Widget build(BuildContext context) {
    final orders = Provider.of<List<Orders>>(context);
    return ListView.builder(
      itemCount: orders?.length??0,
      itemBuilder: (context, index) {
        return OrdersTile(orders: orders[index]);
      },
    );
  }
}
