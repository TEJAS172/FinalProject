import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MealPlan extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Editable Dropdown List',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('MEAL PLAN', style: TextStyle(color: Colors.white)),
          backgroundColor: Colors.blue,
        ),
        body: Center(
          child: Container(
            margin: EdgeInsets.fromLTRB(0, 50.0, 0, 0),
            width: 600,
            child: PTextField(),
          ),
        ),
      ),
    );
  }
}

class PTextField extends StatefulWidget {
  @override
  _PTextFieldState createState() => _PTextFieldState();
}

class _PTextFieldState extends State<PTextField> {
  List<TextEditingController> _controllers = [TextEditingController()];

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  void _addTextField() {
    setState(() {
      _controllers.add(TextEditingController());
    });
  }

  void _removeTextField(int index) {
    setState(() {
      _controllers.removeAt(index);
    });
  }

  Future<void> _handleSubmit() async {
    List<String> submittedValues = _controllers
        .map((controller) => controller.text)
        .where((value) => value.isNotEmpty)
        .toList();

    try {
      await _firestore.collection('Meal Plan').add({
        'remarks': submittedValues,
        'timestamp': Timestamp.now(),
      });

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Submitted Meal Plans'),
            content: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: submittedValues.map((value) => Text(value)).toList(),
              ),
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  _resetForm();
                },
                child: Text('Close'),
              ),
            ],
          );
        },
      );
    } catch (e) {
      print('Error submitting remarks: $e');
    }
  }

  void _resetForm() {
    setState(() {
      _controllers.clear();
      _controllers.add(TextEditingController());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: _controllers.asMap().entries.map((entry) {
            int index = entry.key;
            TextEditingController controller = entry.value;
            return Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: controller,
                    decoration: InputDecoration(
                      hintText: 'Enter Here...',
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.remove),
                  onPressed: () {
                    _removeTextField(index);
                  },
                  color: Colors.red,
                  iconSize: 32,
                  padding: EdgeInsets.all(8),
                  splashRadius: 20,
                  constraints: BoxConstraints(),
                  splashColor: Colors.white,
                ),
                IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () {
                    _addTextField();
                  },
                  color: Colors.blue,
                  iconSize: 32,
                  padding: EdgeInsets.all(8),
                  splashRadius: 20,
                  constraints: BoxConstraints(),
                  splashColor: Colors.white,
                ),
              ],
            );
          }).toList(),
        ),
        SizedBox(height: 20),
        ElevatedButton(
          onPressed: () {
            _handleSubmit();
          },
          child: Text('Submit'),
        ),
      ],
    );
  }
}
