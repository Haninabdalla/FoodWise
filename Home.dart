import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class FoodItem {
  String name;
  String category;
  DateTime expiryDate;
  bool isUsed;

  FoodItem(this.name, this.category, this.expiryDate,
      {this.isUsed = false});
}

class _HomeState extends State<Home> {
  final TextEditingController foodController =
      TextEditingController();

  String selectedCategory = 'Vegetables';
  String filter = 'All';
  DateTime? selectedDate;

  List<FoodItem> foods = [];

  void addFood() {
    if (foodController.text.trim().isEmpty ||
        selectedDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter food name and expiry date'),
        ),
      );
      return;
    }

    setState(() {
      foods.add(
        FoodItem(
          foodController.text.trim(),
          selectedCategory,
          selectedDate!,
        ),
      );

      foodController.clear();
      selectedDate = null;
    });
  }

  int daysLeft(DateTime date) {
    final today = DateTime.now();
    final todayDate = DateTime(today.year, today.month, today.day);
    final expiry = DateTime(date.year, date.month, date.day);

    return expiry.difference(todayDate).inDays;
  }

  List<FoodItem> get filteredFoods {
    if (filter == 'Soon') {
      return foods.where((food) =>
          !food.isUsed &&
          daysLeft(food.expiryDate) >= 0 &&
          daysLeft(food.expiryDate) <= 3).toList();
    }

    if (filter == 'Expired') {
      return foods.where((food) =>
          !food.isUsed && daysLeft(food.expiryDate) < 0).toList();
    }

    return foods;
  }

  List<String> get recipes {
    List<String> suggestions = [];
    List<String> names = foods
        .where((food) => !food.isUsed)
        .map((food) => food.name.toLowerCase())
        .toList();

    if (names.any((n) => n.contains('egg')) &&
        names.any((n) => n.contains('potato'))) {
      suggestions.add('Potato Omelette');
    }

    if (names.any((n) => n.contains('tomato')) &&
        names.any((n) => n.contains('cheese'))) {
      suggestions.add('Tomato and Cheese Sandwich');
    }

    if (names.any((n) => n.contains('chicken')) &&
        names.any((n) => n.contains('rice'))) {
      suggestions.add('Chicken and Rice');
    }

    if (names.any((n) => n.contains('banana')) &&
        names.any((n) => n.contains('milk'))) {
      suggestions.add('Banana Smoothie');
    }

    if (suggestions.isEmpty && names.isNotEmpty) {
      suggestions.add('Try creating a meal with your available food!');
    }

    return suggestions;
  }

  @override
  void dispose() {
    foodController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    int expiringCount = foods.where((food) =>
        !food.isUsed &&
        daysLeft(food.expiryDate) >= 0 &&
        daysLeft(food.expiryDate) <= 3).length;

    return Scaffold(
      backgroundColor: const Color(0xFFF6F8F2),

      appBar: AppBar(
        backgroundColor: const Color(0xFF527D50),
        foregroundColor: Colors.white,
        centerTitle: true,
        title: const Text(
          'FoodWise',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(18),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            const Text(
              'Welcome to FoodWise!',
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: Color(0xFF315C37),
              ),
            ),

            const SizedBox(height: 5),

            const Text(
              'Save food, reduce waste and discover recipes.',
              style: TextStyle(fontSize: 14),
            ),

            const SizedBox(height: 20),

            // Expiry reminder

            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFFFFE8B2),
                borderRadius: BorderRadius.circular(15),
              ),

              child: Row(
                children: [
                  const Icon(
                    Icons.notifications_active,
                    size: 35,
                    color: Colors.orange,
                  ),

                  const SizedBox(width: 12),

                  Expanded(
                    child: Text(
                      '$expiringCount food items are expiring soon!',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 25),

            const Text(
              'Add Your Food',
              style: TextStyle(
                fontSize: 21,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 12),

            TextField(
              controller: foodController,
              decoration: InputDecoration(
                hintText: 'Enter food name',
                prefixIcon: const Icon(Icons.fastfood),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                filled: true,
                fillColor: Colors.white,
              ),
            ),

            const SizedBox(height: 12),

            // Food category dropdown

            DropdownButtonFormField<String>(
              value: selectedCategory,

              decoration: InputDecoration(
                labelText: 'Food Category',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                filled: true,
                fillColor: Colors.white,
              ),

              items: [
                'Vegetables',
                'Fruits',
                'Dairy',
                'Meat',
                'Other'
              ].map((category) {
                return DropdownMenuItem(
                  value: category,
                  child: Text(category),
                );
              }).toList(),

              onChanged: (value) {
                setState(() {
                  selectedCategory = value!;
                });
              },
            ),

            const SizedBox(height: 12),

            // Expiry date picker

            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                icon: const Icon(Icons.calendar_month),
                label: Text(
                  selectedDate == null
                      ? 'Select Expiry Date'
                      : 'Expiry: ${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}',
                ),

                onPressed: () async {
                  DateTime? date = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime.now(),
                    lastDate: DateTime.now().add(
                      const Duration(days: 3650),
                    ),
                  );

                  if (date != null) {
                    setState(() {
                      selectedDate = date;
                    });
                  }
                },
              ),
            ),

            const SizedBox(height: 10),

            // Add button

            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: addFood,
                icon: const Icon(Icons.add),
                label: const Text('Add Food'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF527D50),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.all(14),
                ),
              ),
            ),

            const SizedBox(height: 25),

            const Text(
              'My Food Inventory',
              style: TextStyle(
                fontSize: 21,
                fontWeight: FontWeight.bold,
              ),
            ),

            // Radio buttons for filtering

            Wrap(
              spacing: 8,
              children: [
                filterOption('All'),
                filterOption('Soon'),
                filterOption('Expired'),
              ],
            ),

            // Food list

            if (filteredFoods.isEmpty)
              const Padding(
                padding: EdgeInsets.all(20),
                child: Center(
                  child: Text('No food items found.'),
                ),
              ),

            ...filteredFoods.map((food) {
              int days = daysLeft(food.expiryDate);

              return Card(
                color: Colors.white,
                child: CheckboxListTile(
                  value: food.isUsed,

                  onChanged: (value) {
                    setState(() {
                      food.isUsed = value!;
                    });
                  },

                  title: Text(
                    food.name,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  subtitle: Text(
                    '${food.category} • '
                    '${days < 0 ? "Expired" : days == 0 ? "Expires today" : "$days days left"}',
                    style: TextStyle(
                      color: days <= 3
                          ? Colors.red
                          : Colors.green,
                    ),
                  ),

                  secondary: const Icon(
                    Icons.restaurant,
                    color: Color(0xFF527D50),
                  ),

                  controlAffinity:
                      ListTileControlAffinity.trailing,
                ),
              );
            }),

            const SizedBox(height: 25),

            const Text(
              'Recipe Suggestions',
              style: TextStyle(
                fontSize: 21,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            ...recipes.map((recipe) {
              return Card(
                color: Colors.white,
                child: ListTile(
                  leading: const Icon(
                    Icons.restaurant_menu,
                    color: Color(0xFF527D50),
                    size: 30,
                  ),
                  title: Text(
                    recipe,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: const Text(
                    'Based on your available ingredients',
                  ),
                ),
              );
            }),

            if (recipes.isEmpty)
              const Text(
                'Add some food to discover recipes!',
              ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget filterOption(String value) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Radio<String>(
          value: value,
          groupValue: filter,
          activeColor: const Color(0xFF527D50),
          onChanged: (newValue) {
            setState(() {
              filter = newValue!;
            });
          },
        ),
        Text(value),
      ],
    );
  }
}
