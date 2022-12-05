import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final String uid;
  DatabaseService({required this.uid});

  final CollectionReference userCollection = FirebaseFirestore.instance.collection("users");

  final CollectionReference groupCollection = FirebaseFirestore.instance.collection("groups");

  Future updateUserData(String username, String email) async {
    return await userCollection.doc(uid).set({
      "username": username,
      "email": email,
      "group": [],
      "profilePicture": "",
      "uid": uid
    });
  }

  Future getUserData(String email) async {
    QuerySnapshot snapshot = await userCollection.where("email", isEqualTo: email).get();
    return snapshot;
  }

  getUserGroup() async {
    return userCollection.doc(uid).snapshots();
  }

  Future createGroup(String username, String id, String groupName) async {
    DocumentReference groupDocumentReference = await groupCollection.add({
      "groupName": groupName,
      "groupIcon": "",
      "admin": "${id}_$username",
      "member": [],
      "groupId": "",
      "recentMessage": "",
      "recentMessageSender": "",
    });

    await groupDocumentReference.set({
      "member": FieldValue.arrayUnion(["${uid}_$username"]),
      "groupId": groupDocumentReference.id,
    });

    DocumentReference userDocumentReference = userCollection.doc(uid);
    return await userDocumentReference.update({
      "group": FieldValue.arrayUnion(["${groupDocumentReference.id}_$groupName"]),
    });
  }
}