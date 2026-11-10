

import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  TextEditingController searchController = TextEditingController();

  String result = '';
  String advice = '';
  String category = '';

  final Map<String, String> wasteItems = {
    'plastic bottle': 'Recyclable',
    'paper': 'Recyclable',
    'cardboard': 'Recyclable',
    'glass bottle': 'Recyclable',
    'banana peel': 'Compost',
    'apple peel': 'Compost',
    'food scraps': 'Compost',
    'battery': 'Special Waste',
    'old phone': 'Special Waste',
    'plastic bag': 'General Waste',
    'dirty tissue': 'General Waste',
  };

  void searchItem() {

    String item = searchController.text.trim().toLowerCase();

    if (item.isEmpty) {
      setState(() {
        result = 'Please enter an item!';
        advice = '';
        category = '';
      });
      return;
    }

    setState(() {

      if (wasteItems.containsKey(item)) {

        category = wasteItems[item]!;

        result = category;

        if (category == 'Recyclable') {
          advice = 'Place this item in the recycling bin.';
        }
        else if (category == 'Compost') {
          advice = 'Place this item in the organic waste bin.';
        }
        else if (category == 'Special Waste') {
          advice = 'Take this item to a suitable collection point.';
        }
        else {
          advice = 'Place this item in the general waste bin.';
        }

      } else {

        result = 'Item not found';
        advice = 'Try another item from the list.';

        category = '';
      }

    });
  }

  void clearSearch() {
    setState(() {
      searchController.clear();
      result = '';
      advice = '';
      category = '';
    });
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      backgroundColor: const Color(0xFFF7FAF5),

      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'SortSmart ♻️',
          style: TextStyle(
            color: Color(0xFF34764A),
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: SingleChildScrollView(

        child: Padding(
          padding: const EdgeInsets.all(20),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [

              const SizedBox(height: 15),

              const Center(
                child: Text(
                  'Welcome to SortSmart!',
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF34764A),
                  ),
                ),
              ),

              const SizedBox(height: 10),

              const Center(
                child: Text(
                  'Sort your waste the smart way.',
                  style: TextStyle(fontSize: 16),
                ),
              ),

              const SizedBox(height: 25),

              const Text(
                'Search for an item',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 12),

              TextField(
                controller: searchController,
                decoration: InputDecoration(
                  hintText: 'Example: Plastic bottle',
                  prefixIcon: const Icon(Icons.search),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide.none,
                  ),
                ),
                onSubmitted: (value) {
                  searchItem();
                },
              ),

              const SizedBox(height: 15),

              Row(
                children: [

                  Expanded(
                    child: ElevatedButton(
                      onPressed: searchItem,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF34764A),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.all(15),
                      ),
                      child: const Text('Search'),
                    ),
                  ),

                  const SizedBox(width: 10),

                  OutlinedButton(
                    onPressed: clearSearch,
                    child: const Text('Clear'),
                  ),

                ],
              ),

              const SizedBox(height: 25),

              const Text(
                'Waste Categories',
                style: TextStyle(
                  fontSize: 21,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 15),

              categoryCard(
                '♻️',
                'Recyclable',
                'Paper, cardboard and glass',
                Colors.green.shade50,
              ),

              categoryCard(
                '🍂',
                'Compost',
                'Food scraps and fruit peels',
                Colors.orange.shade50,
              ),

              categoryCard(
                '🗑️',
                'General Waste',
                'Non-recyclable items',
                Colors.blue.shade50,
              ),

              categoryCard(
                '⚠️',
                'Special Waste',
                'Batteries and electronic waste',
                Colors.red.shade50,
              ),

              const SizedBox(height: 20),

              if (result.isNotEmpty)
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(18),
                    border: Border.all(
                      color: const Color(0xFF34764A),
                    ),
                  ),

                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      const Text(
                        'Search Result',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF34764A),
                        ),
                      ),

                      const SizedBox(height: 12),

                      Text(
                        result,
                        style: const TextStyle(
                          fontSize: 19,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 8),

                      Text(
                        advice,
                        style: const TextStyle(fontSize: 15),
                      ),

                    ],
                  ),
                ),

              const SizedBox(height: 25),

              const Center(
                child: Text(
                  'Small actions make a big difference! 🌱',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xFF34764A),
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),

              const SizedBox(height: 25),

            ],
          ),
        ),
      ),
    );
  }

  Widget categoryCard(
    String emoji,
    String title,
    String description,
    Color color,
  ) {

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(17),

      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(17),
      ),

      child: Row(
        children: [

          Text(
            emoji,
            style: const TextStyle(fontSize: 30),
          ),

          const SizedBox(width: 15),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 17,
                  ),
                ),

                const SizedBox(height: 5),

                Text(description),

              ],
            ),
          ),

        ],
      ),
    );
  }
}
