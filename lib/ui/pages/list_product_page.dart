import 'dart:convert';

import 'package:epsi_shop/bo/cart.dart';
import 'package:epsi_shop/bo/product.dart';
import 'package:epsi_shop/ui/pages/detail_page.dart';
import 'package:epsi_shop/ui/pages/panier.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';

class ListProductPage extends StatelessWidget {
  ListProductPage({super.key});

  Future<List<Product>> getProducts() async {
    Response res = await get(Uri.parse("https://fakestoreapi.com/products"));
    if (res.statusCode == 200) {
      List<dynamic> listMapProducts = jsonDecode(res.body);
      return listMapProducts.map((lm) => Product.fromMap(lm)).toList();
    }
    return Future.error("Erreur de téléchargement");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.scrim,
        title: const Text('EPSI Shop'),
        actions: [
          Consumer<Cart>(
            builder: (context, cart, child) {
              return IconButton(
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CartPage()),
                ),
                icon: Badge(
                  label: Text(cart.getItemCount().toString()),
                  child: const Icon(Icons.shopping_cart),
                ),
              );
            },
          )
        ],
      ),
      body: FutureBuilder<List<Product>>(
        future: getProducts(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasData) {
            final listProducts = snapshot.data!;
            return ListViewProducts(listProducts: listProducts);
          } else {
            return Center(child: Text("Erreur"));
          }
        },
      ),
    );
  }
}

class ListViewProducts extends StatelessWidget {
  const ListViewProducts({
    super.key,
    required this.listProducts,
  });

  final List<Product> listProducts;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: listProducts.length,
      itemBuilder: (ctx, index) => InkWell(
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => DetailPage(product: listProducts[index])),
        ),
        child: ListTile(
          leading: Image.network(
            listProducts[index].image,
            width: 90,
            height: 90,
          ),
          title: Text(listProducts[index].title),
          subtitle: Text(listProducts[index].getPrice()),
          trailing: IconButton(
            icon: Icon(Icons.add_shopping_cart),
            onPressed: () {
              context.read<Cart>().addItem(listProducts[index]);
            },
          ),
        ),
      ),
    );
  }
}
