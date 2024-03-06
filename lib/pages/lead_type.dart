import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';



class Lead extends StatelessWidget {
  const Lead({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.blue, // Setting app bar background color to blue
          foregroundColor: Colors.white, // Setting app bar text color to white
        ),
      ),
      home: const ActionChoiceExample(),
    );
  }
}

class ActionChoiceExample extends StatefulWidget {
  const ActionChoiceExample({Key? key});

  @override
  State<ActionChoiceExample> createState() => _ActionChoiceExampleState();
}

class _ActionChoiceExampleState extends State<ActionChoiceExample> {
  int? _value = 1;
  String _selectedStatus = '';

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('LEAD TYPE'),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Choose a Type', style: textTheme.headline6),
            const SizedBox(height: 10.0),
            Wrap(
              spacing: 5.0,
              children: List<Widget>.generate(
                2,
                (int index) {
                  String chipLabel = '';
                  switch (index) {
                    case 0:
                      chipLabel = 'Retail';
                      break;
                    case 1:
                      chipLabel = 'Corporate';
                      break;
                  }
                  return ChoiceChip(
                    label: Text(chipLabel),
                    selected: _value == index,
                    onSelected: (bool selected) {
                      setState(() {
                        _value = selected ? index : null;
                        _selectedStatus = chipLabel;
                      });
                    },
                  );
                },
              ).toList(),
            ),
            const SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                if (_selectedStatus.isNotEmpty) {
                  _submitTypeToFirebase(_selectedStatus);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Please select a Type')),
                  );
                }
              },
              child: const Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }

  void _submitTypeToFirebase(String selectedStatus) async {
    try {
      await _firestore.collection('Lead Type').add({
        'type': selectedStatus,
        'timestamp': FieldValue.serverTimestamp(),
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Type submitted')),
      );
    } catch (e) {
      print('Error submitting type: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to submit type')),
      );
    }
  }
}