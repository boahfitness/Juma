import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:juma/models/lifting/program.dart';
import 'package:juma/models/users/user.dart';

class ProgramService {
  CollectionReference _templateCollection = Firestore.instance.collection('programTemplates');
  CollectionReference _historyCollection = Firestore.instance.collection('programHistory');

  Future<ProgramTemplate> getProgramTemplate(String templateId) async {
    if (templateId == null || templateId.isEmpty) return null;

    try {
      var templateDoc = await _templateCollection.document(templateId).get();
      if (templateDoc == null) return null;

      Map<String, dynamic> templateData = templateDoc.data;
      templateData.addEntries([MapEntry('id', templateDoc.documentID)]);

      return ProgramTemplate.fromMap(templateData);
    }
    catch (e) {
      print(e);
      return null;
    }
  }

  Future<String> createProgramTemplate(ProgramTemplate newPT) async {
    try {
      var doc = await _templateCollection.add(newPT.toMap());
      return doc.documentID;
    }
    catch (e) {
      print(e);
      return null;
    }
  }
}