import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

FirebaseFirestore db = FirebaseFirestore.instance;
CollectionReference userRef = db.collection('users');
// CollectionReference userRef = db.collection('users');

void addFamilyMember(
    String name, String contact, String uid, List<dynamic> families) {
  families.add({"name": name, "contact": contact});
  userRef.doc(uid).update({"emergency-contacts": families});
}

void addNewPasscode(String old, String newPasscode, String uid) {
  userRef.doc(uid).update({"passcode": newPasscode});
}

Future<User> createUserWithEmailPassword(String email, String password) async {
  try {
    // await Firebase.initializeApp();
    UserCredential userCredential = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);
    // print(userCredential.user);
    User user = userCredential.user;
    return user;
  } on FirebaseAuthException catch (e) {
    if (e.code == 'weak-password') {
      print('The password provided is too weak.');
    } else if (e.code == 'email-already-in-use') {
      print('The account already exists for that email.');
    }
  } catch (e) {
    print(e);
  }
}

Future<bool> loginWithEmailAndPassword(String email, String password) async {
  try {
    // print(email + password);
    UserCredential userCredential = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
    // return true;
  } catch (e) {
    if (e.code == 'user-not-found') {
      print('No user found for that email.');
      return false;
    } else if (e.code == 'wrong-password') {
      print('Wrong password provided for that user.');
      return false;
    }
    return false;
  }
  return true;
}

Future<void> signOutUser() async {
  await FirebaseAuth.instance.signOut();
}

Future<void> addUser(String email, String contact, String name, String password,
    String passcode) async {
  User user = await createUserWithEmailPassword(email, password);

  userRef.doc(user.uid).set({
    'userID': user.uid,
    'email': email,
    'contact': contact,
    'name': name,
    'passcode': passcode
  });
}
