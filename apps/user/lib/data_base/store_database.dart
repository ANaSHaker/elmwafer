import "package:cloud_firestore/cloud_firestore.dart";
import 'package:faker/faker.dart';

class StoreDatabse {
  Firestore _firestore = Firestore.instance;
  Future<List<DocumentSnapshot>> getAllCAT() async {
    List<DocumentSnapshot> docs;
    QuerySnapshot _querySnapshot = await _firestore
        .collection("categories")
        .orderBy("category")
        .getDocuments();
    docs = _querySnapshot.documents;
    return docs;
  }

  Future<List<DocumentSnapshot>> getSuggestions(String pattern) async {
    List<DocumentSnapshot> documentSnapshot;
    QuerySnapshot querytSnapshot = await Firestore.instance
        .collection("categories")
        .where('category', isGreaterThanOrEqualTo: pattern)
        .where('category', isLessThan: pattern +'ي')

        .getDocuments();
    documentSnapshot = querytSnapshot.documents;

    return documentSnapshot;
  }

  Future<DocumentSnapshot> getCAT(String CATID) async {
    DocumentSnapshot CATsnapshot =
        await _firestore.collection("categories").document(CATID).get();
    return CATsnapshot;
  }
  Future<List<DocumentSnapshot>> getallproductCategory(String CAT) async
  {
    List<DocumentSnapshot> documentSnapshot;
    if ((CAT != null && CAT != "All"))
    {
      if (CAT != "All" )
      {
        QuerySnapshot querytSnapshot = await Firestore.instance.collection("categories")
            .where("cat", isEqualTo: CAT)
            .getDocuments();
        documentSnapshot = querytSnapshot.documents;
      }
      else if (CAT == "All")
      {
        QuerySnapshot querytSnapshot = await Firestore.instance.collection("categories").getDocuments();
        documentSnapshot = querytSnapshot.documents;
      }
    }
    else
    {
      QuerySnapshot querytSnapshot = await Firestore.instance.collection("categories").getDocuments();
      documentSnapshot = querytSnapshot.documents;
    }
    return documentSnapshot;
  }
}
