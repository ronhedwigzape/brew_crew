import 'package:brew_crew/models/brew.dart';
import 'package:brew_crew/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  
    final String? uid;
    final CollectionReference brewCollection = FirebaseFirestore.instance.collection('brews');
    
    DatabaseService({this.uid});
    
    Future updateUserData(String sugars, String name, int strength) async {
      return await brewCollection.doc(uid).set({
        'sugars': sugars,
        'name': name,
        'strength': strength
      });
    }

    // brew list from snapshot
    List<Brew> _brewListFromSnapshot(QuerySnapshot snapshot) {
      return snapshot.docs.map((doc){
        return Brew(
          name: (doc.data() as Map<String, dynamic>)['name'] ?? '',
          sugars: (doc.data() as Map<String, dynamic>)['sugars'] ?? '0',
          strength: (doc.data() as Map<String, dynamic>)['strength'] ?? 0,
        );
      }).toList();
    }

    // user data from snapshots
    UserData _userDataFromSnapshot(DocumentSnapshot<Object?> snapshot) {
      return UserData(
        uid: uid,
        name: (snapshot.data() as Map<String, dynamic>)['name'],
        sugars: (snapshot.data() as Map<String, dynamic>)['sugars'],
        strength: (snapshot.data() as Map<String, dynamic>)['strength'],
      );
    }

    // get brews stream
    Stream<List<Brew>> get brews {
      return brewCollection.snapshots()
      .map(_brewListFromSnapshot);
    } 

    // get user doc stream
    Stream<UserData> get userData {
      return brewCollection.doc(uid).snapshots()
      .map(_userDataFromSnapshot);
    } 
}