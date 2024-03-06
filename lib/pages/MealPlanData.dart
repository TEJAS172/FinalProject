import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class MealPlanData extends StatefulWidget {
  @override
  _MealPlanDataState createState() =>
      _MealPlanDataState();
}

class _MealPlanDataState extends State<MealPlanData> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<QuerySnapshot> _getMealPlanData() {
    return _firestore.collection('Meal Plan').snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('MEAL_PLAN DATA'),
      ),
      body: StreamBuilder(
        stream: _getMealPlanData(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          }
          if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
            return ListView(
              children: snapshot.data!.docs.map((DocumentSnapshot document) {
                Map<String, dynamic> data =
                    document.data() as Map<String, dynamic>;
                List<dynamic> remarks = data['remarks'] ?? [];
                Timestamp timestamp = data['timestamp'] ?? Timestamp.now();
                DateTime dateTime = timestamp.toDate();

                return Container(
                  width: 400,
                  child: Card(
                    child: ListTile(
                      title: Text('Remarks: ${remarks.join(",  ")}'),
                      subtitle: Text('Submitted at: $dateTime'),
                    ),
                  ),
                );
              }).toList(),
            );
          }
          return Center(
            child: Text('No cancellation remarks available.'),
          );
        },
      ),
    );
  }
}

