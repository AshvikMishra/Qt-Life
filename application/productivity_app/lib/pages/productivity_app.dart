import 'dart:io';
import 'package:flutter/material.dart';
import 'package:csv/csv.dart';
import 'package:path/path.dart' as p;

class ProductivityApp extends StatelessWidget {
  const ProductivityApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Productivity Tracker',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.grey[850],
      ),
      home: const ProductivityHomePage(),
    );
  }
}

class ProductivityHomePage extends StatefulWidget {
  const ProductivityHomePage({super.key});

  @override
  _ProductivityHomePageState createState() => _ProductivityHomePageState();
}

class _ProductivityHomePageState extends State<ProductivityHomePage> {
  int _currentDay = 1;
  final List<String> _timeSlots = ["0-4", "4-8", "8-12", "12-16", "16-20", "20-24"];
  final Map<String, TextEditingController> _controllers = {};

  @override
  void initState() {
    super.initState();
    // Initialize text controllers for each time slot
    for (var slot in _timeSlots) {
      _controllers[slot] = TextEditingController();
    }

    // Clear the CSV file when the app starts
    _clearCSVFile();
  }

  @override
  void dispose() {
    // Dispose controllers
    _controllers.forEach((key, controller) {
      controller.dispose();
    });
    super.dispose();
  }

  Future<void> _clearCSVFile() async {
    final String filePath = p.join('ProductivityData', 'productivity_data.csv');
    final File file = File(filePath);

    // Check if the file exists and clear it
    if (await file.exists()) {
      await file.writeAsString('');
    }
  }

  Future<void> _saveToCSV() async {
    List<List<dynamic>> rows = [
      ["Day", "Time Slot", "Productivity (0-10)"]
    ];

    // Prepare data rows for the current day
    _controllers.forEach((slot, controller) {
      rows.add([_currentDay, slot, controller.text]);
    });

    // Convert rows to CSV
    String csvData = const ListToCsvConverter().convert(rows);

    // Set the absolute path for saving the CSV file
    final String filePath = p.join('ProductivityData', 'productivity_data.csv');
    final File file = File(filePath);

    // Check if the file exists; if not, write the header and the first row
    if (!await file.exists()) {
      await file.writeAsString(csvData);
    } else {
      // Append new data without the header
      String newData = const ListToCsvConverter().convert(rows.skip(1).toList());
      await file.writeAsString("\n$newData", mode: FileMode.append);
    }

    // Show a confirmation message in the app
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Day $_currentDay data uploaded to CSV')),
    );

    // Clear the text fields and increment the day
    _controllers.forEach((slot, controller) {
      controller.clear();
    });
    setState(() {
      _currentDay++;
    });

    // Print the CSV file contents in the terminal for debugging purposes
    print('--- CSV File Contents ---');
    print(await file.readAsString());
    print('-------------------------');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Productivity Tracker - Day $_currentDay', style: const TextStyle(color: Colors.white)),
        backgroundColor: Colors.black,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _timeSlots.length,
              itemBuilder: (context, index) {
                String timeSlot = _timeSlots[index];
                return Card(
                  color: Colors.grey[900],
                  margin: const EdgeInsets.all(5.0),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Time Slot: $timeSlot',
                          style: TextStyle(fontSize: 18, color: Colors.amber[200]),
                        ),
                        const SizedBox(height: 10),
                        TextField(
                          controller: _controllers[timeSlot],
                          keyboardType: TextInputType.number,
                          style: const TextStyle(color: Colors.white),
                          decoration: const InputDecoration(
                            contentPadding: EdgeInsets.all(10),
                            labelText: 'Productivity (0-10)',
                            labelStyle: TextStyle(fontSize: 14, color: Colors.white),
                            border: OutlineInputBorder(),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: ElevatedButton.icon(
              onPressed: _saveToCSV,
              label: Text("Upload", style: TextStyle(color: Colors.grey[400])),
              icon: Icon(Icons.upload, color: Colors.amber[200]),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.grey[900],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
