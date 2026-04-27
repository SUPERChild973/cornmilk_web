import 'package:flutter/material.dart';

class ProdukPage extends StatelessWidget {

  final List<Map<String, String>> produk = [
    {"nama": "Produk 1", "img": "https://via.placeholder.com/150"},
    {"nama": "Produk 2", "img": "https://via.placeholder.com/150"},
  ];

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: EdgeInsets.all(20),
      itemCount: produk.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemBuilder: (context, index) {
        return Card(
          child: Column(
            children: [
              Expanded(
                child: Image.network(produk[index]["img"]!),
              ),
              Text(produk[index]["nama"]!)
            ],
          ),
        );
      },
    );
  }
}