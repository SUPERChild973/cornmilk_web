import 'package:flutter/material.dart';

class KontakPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Kontak Kami"),
          SizedBox(height: 10),
          Text("Email: CornMilk@email.com"),
          Text("Instagram: @CornMilk"),
        ],
      ),
    );
  }
}