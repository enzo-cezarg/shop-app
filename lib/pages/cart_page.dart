import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/components/cart_item.dart';
import 'package:shop/models/cart.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    final Cart cart = Provider.of(context);
    final items = cart.items.values.toList();

    return Scaffold(
      appBar: AppBar(
        title: Text('Carrinho'),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
      ),
      body: Column(
        children: [
          Card(
            margin: EdgeInsets.symmetric(vertical: 25, horizontal: 15),
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Total',
                    style: TextStyle(fontSize: 20),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Chip(
                    side: BorderSide(style: BorderStyle.none),
                    padding: EdgeInsets.all(0),
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    label: Text(
                      'R\$${cart.totalAmount.toStringAsFixed(2)}',
                      style: TextStyle(
                        color: Theme.of(context)
                            .primaryTextTheme
                            .headlineLarge
                            ?.color,
                      ),
                    ),
                  ),
                  Spacer(),
                  TextButton(
                    onPressed: () {},
                    style: TextButton.styleFrom(
                        textStyle: TextStyle(
                            color: Theme.of(context).colorScheme.primary)),
                    child: Text('COMPRAR'),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: items.length,
              itemBuilder: (ctx, i) => CartItemWidget(cartItem: items[i]),
            ),
          )
        ],
      ),
    );
  }
}
