import 'package:flutter/material.dart';
import 'data/wisata_data.dart';  // Ganti dengan path file data Anda
import 'models/wisata.dart';     // Ganti dengan path model wisata Anda

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Wisata Indonesia',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: const MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;  // Untuk menentukan layar yang dipilih

  // Daftar untuk menyimpan wisata favorit
  List<Wisata> favoriteWisata = [];

  final List<Widget> _screens = [];

  @override
  void initState() {
    super.initState();

    _screens.add(
      WisataListScreen(onFavoriteChanged: _toggleFavorite),
    );  // Layar pertama - Wisata List
    _screens.add(
      FavoritesScreen(favoriteWisata: favoriteWisata, onUnfavorite: _toggleFavorite),
    );  // Layar kedua - Favorites
    _screens.add(
      const ProfileScreen(),  // Layar ketiga - Profile
    );
  }

  // Fungsi untuk menambahkan wisata ke favorit atau menghapus dari favorit
  void _toggleFavorite(Wisata wisata, bool isFavorite) {
    setState(() {
      if (isFavorite) {
        favoriteWisata.add(wisata);  // Menambahkan wisata ke favorit
      } else {
        favoriteWisata.remove(wisata);  // Menghapus wisata dari favorit
      }
    });
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;  // Mengubah layar berdasarkan index
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],  // Tampilkan layar berdasarkan index yang dipilih
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favorites',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blueAccent,
        onTap: _onItemTapped,  // Menangani event saat item dipilih
      ),
    );
  }
}

// ----------------------------------------
// Halaman Wisata List (Home)
class WisataListScreen extends StatefulWidget {
  final Function(Wisata, bool) onFavoriteChanged;  // Fungsi callback untuk mengubah status favorit

  const WisataListScreen({required this.onFavoriteChanged, super.key});

  @override
  State<WisataListScreen> createState() => _WisataListScreenState();
}

class _WisataListScreenState extends State<WisataListScreen> {
  List<bool> favoriteStatus = List.filled(wisataList.length, false);  // Status favorit untuk setiap wisata

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Wisata Indonesia'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Teks Selamat Datang
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 16.0),
              child: Center(
                child: Text(
                  'Selamat Datang di Pengenalan Wisata Indonesia',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.blueAccent,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Daftar Wisata
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                  childAspectRatio: 0.8,
                ),
                itemCount: wisataList.length,
                itemBuilder: (context, index) {
                  final Wisata wisata = wisataList[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => WisataDetailScreen(wisata: wisata),
                        ),
                      );
                    },
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      elevation: 5,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Stack(
                            children: [
                              ClipRRect(
                                borderRadius: const BorderRadius.vertical(top: Radius.circular(15)),
                                child: Image.asset(
                                  wisata.gambar,
                                  height: 130,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Positioned(
                                top: 8,
                                right: 8,
                                child: IconButton(
                                  icon: Icon(
                                    favoriteStatus[index] ? Icons.favorite : Icons.favorite_border,
                                    color: favoriteStatus[index] ? Colors.red : Colors.grey,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      favoriteStatus[index] = !favoriteStatus[index];
                                    });
                                    widget.onFavoriteChanged(wisata, favoriteStatus[index]);
                                  },
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  wisata.nama,
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  wisata.lokasi,
                                  style: const TextStyle(
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ----------------------------------------
// Halaman Favorites
class FavoritesScreen extends StatefulWidget {
  final List<Wisata> favoriteWisata;
  final Function(Wisata, bool) onUnfavorite;  // Fungsi callback untuk menghapus dari favorit

  const FavoritesScreen({
    required this.favoriteWisata,
    required this.onUnfavorite,
    super.key,
  });

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorite Wisata'),
        backgroundColor: Colors.blueAccent,
      ),
      body: widget.favoriteWisata.isEmpty
          ? const Center(child: Text('Belum ada wisata favorit.'))
          : ListView.builder(
              itemCount: widget.favoriteWisata.length,
              itemBuilder: (context, index) {
                final Wisata wisata = widget.favoriteWisata[index];
                return ListTile(
                  leading: Image.asset(wisata.gambar),
                  title: Text(wisata.nama),
                  subtitle: Text(wisata.lokasi),
                  trailing: IconButton(
                    icon: const Icon(Icons.remove_circle, color: Colors.red),
                    onPressed: () {
                      widget.onUnfavorite(wisata, false);  // Unfavorite wisata
                    },
                  ),
                );
              },
            ),
    );
  }
}

// ----------------------------------------
// Halaman Detail Wisata
class WisataDetailScreen extends StatelessWidget {
  final Wisata wisata;
  const WisataDetailScreen({required this.wisata, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(wisata.nama),
        backgroundColor: Colors.blueAccent,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              wisata.gambar,
              width: double.infinity,
              height: 250,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    wisata.nama,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    wisata.lokasi,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    wisata.deskripsi,
                    textAlign: TextAlign.justify,
                    style: const TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ----------------------------------------
// Halaman Profile
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'Profile',
        style: TextStyle(fontSize: 24),
      ),
    );
  }
}
