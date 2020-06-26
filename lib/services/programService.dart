import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:juma/models/lifting/program.dart';

class ProgramService {
  CollectionReference _templateCollection = Firestore.instance.collection('programTemplates');
  CollectionReference _historyCollection = Firestore.instance.collection('programHistory');

  Future<ProgramTemplate> getProgramTemplate(String templateId, {bool expanded = true}) async {
    if (templateId == null || templateId.isEmpty) return null;

    try {
      var templateDoc = await _templateCollection.document(templateId).get();
      if (templateDoc == null) return null;

      Map<String, dynamic> templateData = templateDoc.data;
      templateData.addEntries([MapEntry('id', templateDoc.documentID)]);

      if (!expanded) templateData.remove('trainingBlocks');

      return ProgramTemplate.fromMap(templateData);
    }
    catch (e) {
      print(e);
      return null;
    }
  }

  Future<ProgramHistory> getProgramHistory(String id, {bool expanded = true}) async {
    if (id == null || id.isEmpty) return null;

    try {
      var doc = await _historyCollection.document(id).get();
      if (doc == null) return null;

      Map<String ,dynamic> data = doc.data;
      if (!expanded) data.remove('trainingBlocks');

      var p =  ProgramHistory.fromMap(data);
      p.id = id;
      return p;
    }
    catch (e) {
      print(e);
      return null;
    }
  }

  Future<String> createProgramHistory(ProgramHistory newPH) async {
    if (newPH == null) return null;
    try {
      var doc = await _historyCollection.add(newPH.toMap());
      return doc.documentID;
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

  Future<List<ProgramDescriptor>> getProgramTemplates(List<String> ids) async {
    try {
      List<ProgramDescriptor> result = [];
      for (String id in ids) {
        var docSnap = await _templateCollection.document(id).get();
        if (docSnap != null) {
          result.add(ProgramDescriptor.fromMap(docSnap.data));
        }
      }
      return result;
    }
    catch (e) {
      print(e);
      return null;
    }
  }
}