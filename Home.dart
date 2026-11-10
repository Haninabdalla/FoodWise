
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  int selectedIndex = 0;

  void updatePage(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  void addFood() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Add Food Selected')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: const Text(
          'FoodWise',
          style: TextStyle(
            color: Colors.green,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),

      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [

              const SizedBox(height: 20),

              const Text(
                'Welcome to FoodWise!',
                style: TextStyle(
                  fontSize: 27,
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
              ),

              const SizedBox(height: 10),

              const Text(
                'Smart Food Management',
                style: TextStyle(fontSize: 16),
              ),

              const SizedBox(height: 15),

              const Text(
                '🥬 🥕 🍅',
                style: TextStyle(fontSize: 50),
              ),

              const SizedBox(height: 25),

              // Add Your Food
              Container(
                width: 330,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.green.shade700,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  children: [
                    const Text(
                      'Add Your Food',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 10),

                    const Text(
                      'Add food to your inventory.',
                      style: TextStyle(color: Colors.white),
                    ),

                    const SizedBox(height: 15),

                    ElevatedButton(
                      onPressed: addFood,
                      child: const Text('Add Food +'),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // Expiry Alerts
              Container(
                width: 330,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.orange.shade50,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Expiry Alerts 🔔',
                      style: TextStyle(
                        fontSize: 21,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    SizedBox(height: 15),

                    Text('🥛 Milk - Expires in 2 days'),

                    Divider(),

                    Text('🥣 Yogurt - Expires in 4 days'),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // My Food Inventory
              Container(
                width: 330,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.green.shade50,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'My Food Inventory',
                      style: TextStyle(
                        fontSize: 21,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    SizedBox(height: 15),

                    Text('🍅 Tomato - 5 items'),

                    Divider(),

                    Text('🥚 Eggs - 12 items'),

                    Divider(),

                    Text('🥬 Lettuce - 1 piece'),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // Recipe Suggestions
              Container(
                width: 330,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.green.shade50,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Column(
                  children: [
                    Text(
                      'Recipe Suggestions',
                      style: TextStyle(
                        fontSize: 21,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    SizedBox(height: 15),

                    Text(
                      '🍝',
                      style: TextStyle(fontSize: 55),
                    ),

                    Text(
                      'Veggie Pasta',
                      style: TextStyle(fontSize: 18),
                    ),

                    Text('Recipes based on your ingredients.'),
                  ],
                ),
              ),

              const SizedBox(height: 25),

              const Text(
                'Save Food, Reduce Waste!',
                style: TextStyle(
                  color: Colors.green,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 25),

            ],
          ),
        ),
      ),

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,
        onTap: updatePage,
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,

        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.inventory),
            label: 'Inventory',
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.restaurant),
            label: 'Recipes',
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
