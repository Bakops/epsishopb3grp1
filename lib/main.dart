import 'package:epsi_shop/bo/cart.dart';
import 'package:epsi_shop/ui/pages/list_product_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => Cart(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'EPSI Shop',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ListProductPage(),
    );
  }
}
