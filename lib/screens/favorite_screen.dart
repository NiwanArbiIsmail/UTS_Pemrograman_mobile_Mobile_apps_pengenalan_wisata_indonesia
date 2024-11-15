class FavoritesScreen extends StatelessWidget {
  final Set<Wisata> favoriteWisata;
  final Function(Wisata, bool) onUnfavorite;

  const FavoritesScreen({
    required this.favoriteWisata,
    required this.onUnfavorite,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorite Wisata'),
        backgroundColor: Colors.blueAccent,
      ),
      body: favoriteWisata.isEmpty
          ? const Center(child: Text('Belum ada wisata favorit.'))
          : ListView.builder(
              itemCount: favoriteWisata.length,
              itemBuilder: (context, index) {
                final wisata = favoriteWisata.elementAt(index);
                return ListTile(
                  leading: Image.asset(wisata.gambar, width: 50, fit: BoxFit.cover),
                  title: Text(wisata.nama),
                  subtitle: Text(wisata.lokasi),
                  trailing: IconButton(
                    icon: const Icon(Icons.remove_circle, color: Colors.red),
                    onPressed: () {
                      onUnfavorite(wisata, false);
                    },
                  ),
                );
              },
            ),
    );
  }
}

