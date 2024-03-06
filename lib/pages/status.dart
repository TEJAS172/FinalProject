import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Status extends StatelessWidget {
  const Status({Key? key});

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
        title: const Text('STATUS'),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Choose a Status', style: textTheme.headline6),
            const SizedBox(height: 10.0),
            Wrap(
              spacing: 5.0,
              children: List<Widget>.generate(
                4,
                (int index) {
                  String chipLabel = '';
                  switch (index) {
                    case 0:
                      chipLabel = 'Pending';
                      break;
                    case 1:
                      chipLabel = 'In progress';
                      break;
                    case 2:
                      chipLabel = 'Confirmed';
                      break;
                    case 3:
                      chipLabel = 'Cancelled';
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
                  _submitToFirebase();
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Please select a status')),
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

  void _submitToFirebase() async {
    try {
      await _firestore.collection('Status Type').add({
        'type': _selectedStatus,
        'timestamp': FieldValue.serverTimestamp(),
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Status submitted')),
      );
    } catch (e) {
      print('Error submitting status: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to submit status')),
      );
    }
  }
}
