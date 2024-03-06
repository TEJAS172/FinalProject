import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';

class DatabaseMethods{
  // final CollectionReference Commission = FirebaseFirestore.instance.collection("Commission");

  // Future<void> addCommissionCharge() async{
  //   DocumentReference newCommissionRef = await Commission.add({});
  // }

  Future addServiceCharge(Map<String, dynamic> serviceInfoMap, String id)async{
   return await FirebaseFirestore.instance.collection("Service Charge")
   .doc(id)
   .set(serviceInfoMap);
  }
    Future addCommissionCharge(Map<String, dynamic> commissionInfoMap, String id)async{
   return await FirebaseFirestore.instance.collection("Commission Charge").doc(id).set(commissionInfoMap);
  }
  Future addTDS(Map<String, dynamic> tdsInfoMap, String id)async{
   return await FirebaseFirestore.instance.collection("TDS").doc(id).set(tdsInfoMap);
  }

  Future<Stream<QuerySnapshot>> getServiceDetails() async{
    return await FirebaseFirestore.instance.collection("Service Charge").snapshots();
  }
  
  Future<Stream<QuerySnapshot>> getCommissionDetails() async{
    return await FirebaseFirestore.instance.collection("Commission Charge").snapshots();
  }
  
  Future<Stream<QuerySnapshot>> getTdsDetails() async{
    return await FirebaseFirestore.instance.collection("TDS").snapshots();
  }

  Future<Stream<QuerySnapshot>> getLeadDetails() async{
    return await FirebaseFirestore.instance.collection("Lead Type").snapshots();
  }

   Future<Stream<QuerySnapshot>> getAccomodationDetails() async{
    return await FirebaseFirestore.instance.collection("Accomodation Type").snapshots();
  }
}