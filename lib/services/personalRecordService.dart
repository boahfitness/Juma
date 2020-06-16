import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:juma/models/lifting/personalRecords.dart';

class PersonalRecordService {
  CollectionReference _prCollection = Firestore.instance.collection('personalRecords');

  final String uid;

  PersonalRecordService(this.uid);

  Future<String> createTrackedLift (TrackedLift newTrackedLift) async {
    newTrackedLift.uid = uid;

    //check if trackedLift descriptor exists for uid in database
    try {
      var result = await _prCollection
        .where('uid', isEqualTo: uid)
        .where('liftDescriptor', isEqualTo: newTrackedLift.liftDescriptor.toString())
        .snapshots()
        .first;
      
      if (result.documents.length == 0) {
        // if it doesn't exist, add the new trackedLift and return the new docID
        var newDoc = await _prCollection.add(newTrackedLift.toMap());
        return newDoc.documentID;
      }
    }
    catch(e, st) { print('ERROOORRR\n$e'); 
      print(st);
    }

    return null;
  }
}