import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coffee/models/coffee.dart';
import 'package:coffee/models/user.dart';

class DatabaseService{

  final String uid;
  DatabaseService({this.uid});

  // collection reference
  final CollectionReference coffeeCollection = Firestore.instance.collection('coffee');

  Future updateUserDate(String sugars,String name, int strength) async{
    return await coffeeCollection.document(uid).setData({
      'sugars': sugars,
      'name': name,
      'strength': strength,
    });
  }

  // coffee list from snapshot
  List<Coffee> _coffeeListFromSnapshot(QuerySnapshot snapshot){
    return snapshot.documents.map((doc){
      return Coffee(
        name: doc.data['name'] ?? '',
        strength: doc.data['strength'] ?? 0,
        sugars: doc.data['sugars'] ?? '0'
      );
    }).toList();
  }

  // userData From snapshot
  UserData _userDataFromSnapshot(DocumentSnapshot snapshot){
    return UserData(
      uid: uid,
      name: snapshot.data['name'],
      sugars: snapshot.data['sugars'],
      strength: snapshot.data['strength'],
    );
  }


  // get coffee stream
  Stream<List<Coffee>> get coffee{
    return coffeeCollection.snapshots().map(_coffeeListFromSnapshot);
  }

  // get user doc stream
  Stream<UserData> get userData{
    return coffeeCollection.document(uid).snapshots().
    map(_userDataFromSnapshot);
  }


}