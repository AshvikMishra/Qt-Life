import 'dart:io'; 
import 'package:flutter/material.dart'; 
import 'package:csv/csv.dart'; 
import 'package:path_provider/path_provider.dart'; // Import path_provider
import 'package:path/path.dart' as p;

void main() {
  runApp(CalendarApp());
}

class CalendarApp extends StatelessWidget {
  const CalendarApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Productivity Calendar',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ProductivityScreen(),
    );
  }
}

class ProductivityScreen extends StatefulWidget {
  const ProductivityScreen({super.key});

  @override
  _ProductivityScreenState createState() => _ProductivityScreenState();
}

class _ProductivityScreenState extends State<ProductivityScreen> {
  final List<String> _timeSlots = ["0-4", "4-8", "8-12", "12-16", "16-20", "20-24"];
  final Map<String, TextEditingController> _controllers = {};

  @override
  void initState() {
    super.initState();
    // Initialize controllers for each time slot
    for (var slot in _timeSlots) {
      _controllers[slot] = TextEditingController();
    }
  }

  @override
  void dispose() {
    // Dispose controllers
    _controllers.forEach((key, controller) {
      controller.dispose();
    });
    super.dispose();
  }

  Future<void> _saveToCSV() async {
    List<List<dynamic>> rows = [
      ["Time Slot", "Productivity (1-10)"]
    ];

    // Prepare data rows
    _controllers.forEach((slot, controller) {
      rows.add([slot, controller.text]);
    });

    // Convert rows to CSV
    String csvData = const ListToCsvConverter().convert(rows);

    // Get the platform-specific directory to save the file
    final Directory directory = await getApplicationDocumentsDirectory();

    // Create a 'data' folder in the app's documents directory
    final String dataFolderPath = p.join(directory.path, 'data');
    final Directory dataDir = Directory(dataFolderPath);
    if (!await dataDir.exists()) {
      await dataDir.create();
    }

    // Save the CSV file in the 'data' folder
    final String filePath = p.join(dataFolderPath, 'productivity_data.csv');
    final File file = File(filePath);

    // Write to file
    await file.writeAsString(csvData);

    // Show confirmation in the app UI
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Data saved to CSV at $filePath')),
    );

    // Show the CSV contents in the terminal
    print('--- CSV File Contents ---');
    print(csvData);  // Print the CSV content
    print('-------------------------');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Productivity Tracker'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _timeSlots.length,
              itemBuilder: (context, index) {
                String timeSlot = _timeSlots[index];
                return Card(
                  margin: const EdgeInsets.all(10.0),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Time Slot: $timeSlot',
                          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 10),
                        TextField(
                          controller: _controllers[timeSlot],
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            labelText: 'Productivity (1-10)',
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          ElevatedButton(
            onPressed: _saveToCSV,
            child: const Text('Save to CSV'),
          ),
        ],
      ),
    );
  }
}
