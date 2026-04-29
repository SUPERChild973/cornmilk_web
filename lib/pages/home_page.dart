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
  final Color textColor = const Color(0xFF222222);

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

    _scaleAnimation = Tween<double>(begin: 1, end: 0.95).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  void closeDrawer() {
    _controller.reverse();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: primaryColor,
        textTheme: TextTheme(
          bodyMedium: TextStyle(color: textColor),
          titleLarge:
              TextStyle(color: textColor, fontWeight: FontWeight.bold),
        ),
      ),
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: primaryColor,
          leading: Builder(
            builder: (context) => IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () {
                _controller.forward();
                Scaffold.of(context).openDrawer();
              },
            ),
          ),
          title: Row(
            children: [
              CircleAvatar(
                radius: 18,
                backgroundImage: AssetImage('assets/logoCornMilk.png'),
                backgroundColor: Colors.white,
              ),
              const SizedBox(width: 10),
              const Text("CornMilk"),
            ],
          ),
        ),
        drawer: Drawer(
          child: ListView(
            children: [
              UserAccountsDrawerHeader(
                decoration: BoxDecoration(color: primaryColor),
                currentAccountPicture: const CircleAvatar(
                  backgroundImage: AssetImage('assets/logoCornMilk.png'),
                ),
                accountName: const Text("CornMilk"),
                accountEmail: const Text("info@cornmilk.com"),
              ),
              ListTile(
                leading: const Icon(Icons.home),
                title: const Text("Home"),
                onTap: () {
                  setState(() => selectedIndex = 0);
                  closeDrawer();
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.shopping_cart),
                title: const Text("Produk"),
                onTap: () {
                  setState(() => selectedIndex = 1);
                  closeDrawer();
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.contact_mail),
                title: const Text("Kontak"),
                onTap: () {
                  setState(() => selectedIndex = 2);
                  closeDrawer();
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
        body: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return Transform.scale(
              scale: _scaleAnimation.value,
              child: pages[selectedIndex],
            );
          },
        ),
      ),
    );
  }
}

class HomeContent extends StatefulWidget {
  @override
  _HomeContentState createState() => _HomeContentState();
}

class _HomeContentState extends State<HomeContent>
    with SingleTickerProviderStateMixin {
  final Color primaryColor = const Color(0xFF6C63FF);

  late AnimationController _btnController;

  final List<Map<String, String>> produk = [
    {"nama": "Original", "img": "assets/jagung.jpeg"},
    {"nama": "Coklat", "img": "assets/coklat.jpeg"},
    {"nama": "Matcha", "img": "assets/matcha.jpeg"},
    {"nama": "Strawberry", "img": "assets/strawberry.jpeg"},
  ];

  @override
  void initState() {
    super.initState();

    _btnController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 120),
    );
  }

  @override
  void dispose() {
    _btnController.dispose();
    super.dispose();
  }

  void _onTapDown(TapDownDetails details) {
    _btnController.forward();
  }

  void _onTapUp(TapUpDetails details) {
    _btnController.reverse();
  }

  void _onTapCancel() {
    _btnController.reverse();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(30),
            color: primaryColor,
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
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
                  "Fresh Taste, Happy Vibes Only!",
                  style: TextStyle(color: Colors.white70),
                ),
              ],
            ),
          ),
          const SizedBox(height: 30),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              "Produk Unggulan",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: produk.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 15,
                mainAxisSpacing: 15,
                childAspectRatio: 0.75,
              ),
              itemBuilder: (context, index) {
                return productCard(
                  produk[index]["nama"]!,
                  produk[index]["img"]!,
                );
              },
            ),
          ),
          const SizedBox(height: 40),

          Center(
            child: GestureDetector(
              onTapDown: _onTapDown,
              onTapUp: _onTapUp,
              onTapCancel: _onTapCancel,
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Fitur pemesanan coming soon")),
                );
              },
              child: AnimatedBuilder(
                animation: _btnController,
                builder: (context, child) {
                  return Transform.scale(
                    scale: 1 - (_btnController.value * 0.1),
                    child: child,
                  );
                },
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 35, vertical: 15),
                  decoration: BoxDecoration(
                    color: primaryColor,
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      )
                    ],
                  ),
                  child: const Text(
                    "Pesan Sekarang",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 40),
        ],
      ),
    );
  }

  static Widget productCard(String nama, String img) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      elevation: 6,
      child: Column(
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(20)),
              child: Image.asset(
                img,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Text(
              nama,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}