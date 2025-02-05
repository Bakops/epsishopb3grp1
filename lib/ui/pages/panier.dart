import 'package:epsi_shop/bo/cart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Panier'),
      ),
      body: Consumer<Cart>(
        builder: (context, cart, child) {
          final items = cart.getAll();
          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: items.length,
                  itemBuilder: (ctx, index) {
                    final product = items[index];
                    return ListTile(
                      leading: Image.network(
                        product.image,
                        width: 90,
                        height: 90,
                      ),
                      title: Text(product.title),
                      subtitle: Text(product.getPrice()),
                      trailing: IconButton(
                        icon: Icon(Icons.remove_shopping_cart),
                        onPressed: () {
                          cart.removeItem(product);
                        },
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      'Total: \€{cart.getTotal().toStringAsFixed(2)}',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () {
                        // Action pour procéder au paiement
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Procéder au paiement')),
                        );
                      },
                      child: Text('Procéder au paiement'),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
