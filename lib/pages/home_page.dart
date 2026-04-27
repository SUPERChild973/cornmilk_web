import 'package:flutter/material.dart';
import 'package:flutter_cornmilk_1/pages/kontak_page.dart';
import 'package:flutter_cornmilk_1/pages/produk_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {

  int selectedIndex = 0;

  final Color primaryColor = const Color(0xFF6C63FF);

  final List<Widget> pages = [
    HomeContent(),
    ProdukPage(),
    KontakPage(),
  ];

  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    _scaleAnimation = Tween<double>(begin: 0.9, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );
  }

  void openDrawer() {
    _controller.forward();
    Scaffold.of(context).openDrawer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // ================= APPBAR =================
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Row(
          children: [
            Image.asset(
              'assets/images/logo.png',
              height: 35,
            ),
            const SizedBox(width: 10),
            const Text("CornMilk"),
          ],
        ),
      ),

      // ================= DRAWER =================
      drawer: Drawer(
        child: ListView(
          children: [
            UserAccountsDrawerHeader(
              decoration: BoxDecoration(color: primaryColor),
              currentAccountPicture: CircleAvatar(
                backgroundImage:
                    AssetImage('assets/images/profile.jpg'), // FOTO PROFIL
              ),
              accountName: const Text("Nama Kamu"),
              accountEmail: const Text("email@contoh.com"),
            ),

            ListTile(
              leading: const Icon(Icons.home),
              title: const Text("Home"),
              onTap: () {
                setState(() => selectedIndex = 0);
                Navigator.pop(context);
              },
            ),

            ListTile(
              leading: const Icon(Icons.shopping_cart),
              title: const Text("Produk"),
              onTap: () {
                setState(() => selectedIndex = 1);
                Navigator.pop(context);
              },
            ),

            ListTile(
              leading: const Icon(Icons.contact_mail),
              title: const Text("Kontak"),
              onTap: () {
                setState(() => selectedIndex = 2);
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),

      // ================= BODY + ANIMASI =================
      body: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Transform.scale(
            scale: _scaleAnimation.value,
            child: pages[selectedIndex],
          );
        },
      ),
    );
  }
}

////////////////////////////////////////////////////////////
/// HOME CONTENT
////////////////////////////////////////////////////////////

class HomeContent extends StatelessWidget {
  final Color primaryColor = const Color(0xFF6C63FF);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          // ================= HERO =================
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(30),
            color: primaryColor,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  "Minuman Sehat & Kekinian 🍹",
                  style: TextStyle(
                    fontSize: 28,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  "Susu jagung segar dengan berbagai varian rasa!",
                  style: TextStyle(color: Colors.white70),
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          // ================= BANNER =================
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image.asset(
                'assets/images/banner.jpg',
                height: 180,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
          ),

          const SizedBox(height: 30),

          // ================= PRODUK =================
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              "Produk Unggulan",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          const SizedBox(height: 15),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                productCard("Original", "assets/images/produk1.png"),
                const SizedBox(width: 10),
                productCard("Coklat", "assets/images/produk2.png"),
              ],
            ),
          ),

          const SizedBox(height: 30),

          // ================= CTA =================
          Center(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: primaryColor,
                padding: const EdgeInsets.symmetric(
                    horizontal: 30, vertical: 15),
              ),
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Fitur pemesanan coming soon")),
                );
              },
              child: const Text("Pesan Sekarang"),
            ),
          ),

          const SizedBox(height: 40),
        ],
      ),
    );
  }

  static Widget productCard(String nama, String img) {
    return Expanded(
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        elevation: 4,
        child: Column(
          children: [
            ClipRRect(
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(15)),
              child: Image.asset(
                img,
                height: 120,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              nama,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}