import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_project/service/database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';


class Fetch extends StatefulWidget {
  const Fetch({super.key});

  @override
  State<Fetch> createState() => _FetchState();
}

class _FetchState extends State<Fetch> {
  Stream? ServiceStream;
  Stream? CommissionStream;
  Stream? TdsStream;
  Stream? LeadStream;
  Stream? AccomodationStream;
  getontheload()async{
    ServiceStream = await DatabaseMethods().getServiceDetails();
    setState(() {
      
    });
  } 

  getcommissionload()async{
    CommissionStream = await DatabaseMethods().getCommissionDetails();
    setState(() {
      
    });
  } 

   gettdsload()async{
    TdsStream = await DatabaseMethods().getTdsDetails();
    setState(() {
      
    });
  } 

  getleadload()async{
    LeadStream = await DatabaseMethods().getLeadDetails();
    setState(() {
      
    });
  } 

  getaccomodationload()async{
    AccomodationStream = await DatabaseMethods().getAccomodationDetails();
    setState(() {
      
    });
  } 

  @override
  void initState() {
    getontheload();
    getcommissionload();
    gettdsload();
    getleadload();
    getaccomodationload();
    
    super.initState();
  }

  //Service_charge
   Widget allServiceCharge(){
    return StreamBuilder(
       stream: ServiceStream,
       builder:(context, AsyncSnapshot snapshot){
      return snapshot.hasData
      ? ListView.builder(
        itemCount: snapshot.data.docs.length,
        itemBuilder: (context, index){
          DocumentSnapshot ds = snapshot.data.docs[index];
          return  Material(
              elevation: 5.0,
              // borderRadius: BorderRadius.circular(10),
              child: Container(
                padding: EdgeInsets.all(20),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Title :"+ds["Title"] ,style: TextStyle(fontSize: 14.0,fontWeight: FontWeight.bold),),
                    Text("Chargers :"+ds["Charges"] ,style: TextStyle(fontSize: 14.0,fontWeight: FontWeight.bold),)                 
                  ],
                ),
              ),
            );
        })
      :Container();
    });
  }

  //commission_charge
  Widget allCommissionCharge(){
    return StreamBuilder(
       stream:  CommissionStream,
       builder:(context, AsyncSnapshot snapshot){
      return snapshot.hasData
      ? ListView.builder(
        itemCount: snapshot.data.docs.length,
        itemBuilder: (context, index){
          DocumentSnapshot ds = snapshot.data.docs[index];
          return  Material(
              elevation: 5.0,
              // borderRadius: BorderRadius.circular(10),
              child: Container(
                padding: EdgeInsets.all(20),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Title :"+ds["Title"] ,style: TextStyle(fontSize: 14.0,fontWeight: FontWeight.bold),),
                    Text("Chargers :"+ds["Charges"] ,style: TextStyle(fontSize: 14.0,fontWeight: FontWeight.bold),)                 
                  ],
                ),
              ),
            );
        })
      :Container();
    });
  }
   
   //TDS
   Widget allTDS(){
    return StreamBuilder(
       stream: TdsStream,
       builder:(context, AsyncSnapshot snapshot){
      return snapshot.hasData
      ? ListView.builder(
        itemCount: snapshot.data.docs.length,
        itemBuilder: (context, index){
          DocumentSnapshot ds = snapshot.data.docs[index];
          return  Material(
              elevation: 5.0,
              // borderRadius: BorderRadius.circular(10),
              child: Container(
                padding: EdgeInsets.all(20),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Title :"+ds["Title"] ,style: TextStyle(fontSize: 14.0,fontWeight: FontWeight.bold),),
                    Text("Chargers :"+ds["Charges"] ,style: TextStyle(fontSize: 14.0,fontWeight: FontWeight.bold),)                 
                  ],
                ),
              ),
            );
        })
      :Container();
    });
  }
  
//     //lead
//   Widget build(BuildContext context) {
//     return StreamBuilder(
//       stream:  LeadStream,
//       builder: (context, AsyncSnapshot snapshot) {
//         if (!snapshot.hasData) {
//           return Center(
//             child: CircularProgressIndicator(),
//           );
//         }
//         final List<DocumentSnapshot> documents = snapshot.data!.docs;
//         return ListView.builder(
//           itemCount: documents.length,
//           itemBuilder: (context, index) {
//             final String type = documents[index]['type'];
//             final Timestamp timestamp = documents[index]['timestamp'];
//             final DateTime dateTime = timestamp.toDate();
//             return ListTile(
//               title: Text(type),
//               subtitle: Text('Timestamp: $dateTime'),
//             );
//           },
//         );
//       },
//     );
//   }
// }


  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text('MASTERS DATA',style: TextStyle(color: Colors.white),),
      ),
      body: Row(
        children: [
          Container(
            width: 280,
            margin: EdgeInsets.only(left: 20.0,right: 20.0,bottom: 50.0),
            child: Column(
              children: [
                Title(color: Colors.black, child: Text("Service Charge")),
              Expanded(child:allServiceCharge()),
              ],
            ),
          ),
          SizedBox(width: 10),
          Container(
            width: 280,
            margin: EdgeInsets.only(left: 10.0,right: 10.0,bottom: 50.0),
            child: Column(
              children: [
                Title(color: Colors.black, child: Text("Commission Charge")),
              Expanded(child:allCommissionCharge()),
              ],
            ),
          ),
           SizedBox(width: 10),
          Container(
            width: 280,
            margin: EdgeInsets.only(left: 10.0,right: 10.0,bottom: 50.0),
            child: Column(
              children: [
                Title(color: Colors.black, child: Text("TDS")),
              Expanded(child:allTDS()),
              ],
            ),
          ),
          // SizedBox(width: 10),
          // Container(
          //   width: 280,
          //   margin: EdgeInsets.only(left: 10.0,right: 10.0,bottom: 50.0),
          //   child: Column(
          //     children: [
          //       Title(color: Colors.black, child: Text("Lead Type")),
          //     Expanded(child:allLead()),
          //     ],
          //   ),
          // ),

        ],
      ),
  
    
      );
    
    
  }
}