import 'package:flutter/material.dart';
import 'package:guidedlayout2_1748/View/Profile/profile.dart';
import 'package:guidedlayout2_1748/View/view_list.dart';
// import 'package:guidedlayout2_1748/View/Profile/pengaturan.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  // Define the widget options based on the selected index in the BottomNavigationBar
  final List<Widget> _pages = [
    CategorySelectionPage(),
    ListNamaView(),
    ProfilePage(),
    // Center(child: Text('Profile Page')),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.list), label: 'List'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
      body: IndexedStack(
        index: _selectedIndex,
        children: _pages,
      ),
    );
  }
}

class CategorySelectionPage extends StatefulWidget {
  const CategorySelectionPage({Key? key}) : super(key: key);

  @override
  State<CategorySelectionPage> createState() => _CategorySelectionPageState();
}

class _CategorySelectionPageState extends State<CategorySelectionPage> {
  final Map<String, bool> _selectedCategories = {
    'Running': false,
    'Walking': false,
    'Good Morning': false,
    'Cycling': false,
    'Sitting': false,
    'Lying': false,
    'Bench Press': false,
    'Yoga': false,
  };

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Choose Categories',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text(
              'Please Choose at least Two categories',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                children: _selectedCategories.keys.map((String key) {
                  return CategoryCard(
                    title: key,
                    icon: _getCategoryIcon(key),
                    isSelected: _selectedCategories[key]!,
                    onSelected: (bool selected) {
                      setState(() {
                        _selectedCategories[key] = selected;
                      });
                    },
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Ensure at least two categories are selected before submitting
                if (_selectedCategories.values.where((isSelected) => isSelected).length < 2) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Please select at least two categories.")),
                  );
                } else {
                  // Handle submission logic here
                  print("Selected Categories: ${_selectedCategories.keys.where((key) => _selectedCategories[key]!)}");
                }
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 14.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Center(
                child: Text(
                  'Submit',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Center(
              child: TextButton(
                onPressed: () {
                  // Handle skip logic
                  print("Skipped");
                },
                child: const Text(
                  'Skip',
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Helper function to get icons based on category
  IconData _getCategoryIcon(String category) {
    switch (category) {
      case 'Running':
        return Icons.directions_run;
      case 'Walking':
        return Icons.directions_walk;
      case 'Good Morning':
        return Icons.wb_sunny;
      case 'Cycling':
        return Icons.directions_bike;
      case 'Sitting':
        return Icons.chair;
      case 'Lying':
        return Icons.bed;
      case 'Bench Press':
        return Icons.fitness_center;
      case 'Yoga':
        return Icons.self_improvement;
      default:
        return Icons.category;
    }
  }
}

// Category Card widget
class CategoryCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final bool isSelected;
  final ValueChanged<bool> onSelected;

  const CategoryCard({
    Key? key,
    required this.title,
    required this.icon,
    required this.isSelected,
    required this.onSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onSelected(!isSelected),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: isSelected ? Colors.blue : Colors.grey.shade300,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 36, color: isSelected ? Colors.blue : Colors.grey),
            const SizedBox(height: 10),
            Text(
              title,
              style: TextStyle(
                color: isSelected ? Colors.blue : Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            Checkbox(
              value: isSelected,
              onChanged: (bool? value) {
                if (value != null) onSelected(value);
              },
            ),
          ],
        ),
      ),
    );
  }
}
