import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:juma/models/lifting/personalRecords.dart';

class PersonalRecordService {
  CollectionReference _prCollection = Firestore.instance.collection('personalRecords');

  Future<bool> createTrackedLift (TrackedLift newTrackedLift) async {
    //must be connected to a user
    if (newTrackedLift.uid.isEmpty || newTrackedLift.uid == null) return false;

    //check if trackedLift descriptor exists for uid in database
    var x = await _prCollection
      .where('uid', isEqualTo: newTrackedLift.uid)
      .where('liftDescriptor', isEqualTo: newTrackedLift.liftDescriptor.toString())
      .snapshots()
      .single;

    if (x.documents.length == 0) return false;

    await _prCollection.add(newTrackedLift.toMap());

    return true;
  }
}