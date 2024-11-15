BottomNavigationBar(
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
  onTap: _onItemTapped,
);

