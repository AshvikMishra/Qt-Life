import 'dart:io';
import 'package:flutter/material.dart';
import 'package:csv/csv.dart';
import 'package:path/path.dart' as p;
import 'package:productivity_app/pages/landing.dart';
import 'package:productivity_app/pages/ml_ouput.dart';

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
      routes: {
        '/landing': (context) => const Landing(), // Define your Landing page route here
        "/ml_output": (context) => const MLOutput(),
      },
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
  final Map<String, int> _selectedValues = {};

  @override
  void initState() {
    super.initState();

    // Initialize selected values for each time slot to default to 0
    for (var slot in _timeSlots) {
      _selectedValues[slot] = 0;
    }

    _clearCSVFile();
  }

  Future<void> _clearCSVFile() async {
    final String filePath = p.join('ProductivityData', 'productivity_data.csv');
    final File file = File(filePath);

    if (await file.exists()) {
      await file.writeAsString('');
    }
  }

  Future<void> _saveToCSV() async {
    List<List<dynamic>> rows = [
      ["Day", "Time Slot", "Productivity (0-10)"]
    ];

    // Prepare data rows for the current day
    _selectedValues.forEach((slot, value) {
      rows.add([_currentDay, slot, value]);
    });

    String csvData = const ListToCsvConverter().convert(rows);

    final String filePath = p.join('ProductivityData', 'productivity_data.csv');
    final File file = File(filePath);

    if (!await file.exists()) {
      await file.writeAsString(csvData);
    } else {
      String newData = const ListToCsvConverter().convert(rows.skip(1).toList());
      await file.writeAsString("\n$newData", mode: FileMode.append);
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Day $_currentDay data uploaded to CSV')),
    );

    setState(() {
      _currentDay++;
    });

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
        actions: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
            child: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.grey[200]),
              onPressed: () {
                Navigator.of(context).pushNamed('/landing');
              },
              tooltip: 'Back',
              iconSize: 30, 
            ),
          ),
        ],
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
                    padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0), // Add 20px padding
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Time Slot: $timeSlot',
                          style: TextStyle(fontSize: 18, color: Colors.amber[200]),
                        ),
                        const SizedBox(height: 10),
                        DropdownButton<int>(
                          value: _selectedValues[timeSlot],
                          items: List.generate(
                            11, // Values 0-10
                            (value) => DropdownMenuItem<int>(
                              value: value,
                              child: Text(value.toString(), style: const TextStyle(color: Colors.white)),
                            ),
                          ),
                          onChanged: (value) {
                            setState(() {
                              _selectedValues[timeSlot] = value!;
                            });
                          },
                          dropdownColor: Colors.grey[800],
                          style: const TextStyle(color: Colors.white),
                          isExpanded: true, // Make it take the full width
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
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton.icon(
                  onPressed: _saveToCSV,
                  label: Text("Upload", style: TextStyle(color: Colors.grey[400])),
                  icon: Icon(Icons.upload, color: Colors.amber[200]),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey[900],
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.pushNamed(context, '/ml_output');
                  },
                  label: Text("Prediction", style: TextStyle(color: Colors.grey[400])),
                  icon: Icon(Icons.access_time, color: Colors.amber[200]),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey[900],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}