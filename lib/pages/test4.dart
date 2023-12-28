import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const FindProductsPage(),
    );
  }
}

class FindProductsPage extends StatelessWidget {
  const FindProductsPage({super.key});

  void _openFilters(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (_) => const FiltersPage(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Find Products'),
        actions: [
          IconButton(
            icon: const Icon(Icons.tune),
            onPressed: () => _openFilters(context),
          ),
        ],
      ),
      body: GridView.count(
        crossAxisCount: 2,
        children: List.generate(6, (index) {
          // Placeholder for your category widgets
          return Center(child: Text('Category $index'));
        }),
      ),
    );
  }
}

class FiltersPage extends StatefulWidget {
  const FiltersPage({super.key});

  @override
  _FiltersPageState createState() => _FiltersPageState();
}

class _FiltersPageState extends State<FiltersPage> {
  final Map<String, bool?> _filters = {
    'Eggs': false,
    'Noodles & Pasta': false,
    'Chips & Crisps': false,
    'Fast Food': false,
  };

  void _applyFilters() {
    Navigator.pop(context);
    // Apply your filters
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 250,
      child: Column(
        children: [
          AppBar(
            title: const Text('Filters'),
            automaticallyImplyLeading: false,
            actions: [
              IconButton(
                icon: const Icon(Icons.close),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
          Expanded(
            child: ListView(
              children: _filters.keys.map((String key) {
                return CheckboxListTile(
                  title: Text(key),
                  value: _filters[key] ??
                      false, // Handle null by providing a default value
                  onChanged: (bool? value) {
                    // Accept a nullable bool
                    setState(() {
                      _filters[key] = value;
                    });
                  },
                );
              }).toList(),
            ),
          ),
          ElevatedButton(
            onPressed: _applyFilters,
            child: const Text('Apply Filters'),
          )
        ],
      ),
    );
  }
}
