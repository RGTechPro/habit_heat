import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:habit_heat/sccreens/home_page.dart';
import 'package:habit_heat/sccreens/log_in.dart';
import 'package:provider/provider.dart';
import 'package:habit_heat/Provider/account.dart';
import 'package:http/http.dart' as http;

class Auth extends ChangeNotifier {
   User? _firebaseUser; 
   bool isLoading = false;
     String mobileNumber = 'Unknown';
  setUser(User? user) {
    _firebaseUser = user;
    notifyListeners();
  }
   User? getUser() {
    return _firebaseUser;
  }


  String baseUrl = "http://e84f-42-111-11-28.ngrok.io";
signInWithGoogle(BuildContext context) async {
    // Trigger the authentication flow

   try{
     final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
     isLoading = true;
     //isLoading = true;
     notifyListeners();
     // Obtain the auth details from the request
     final GoogleSignInAuthentication googleAuth =
     await googleUser!.authentication;

     // Create a new credential
     final credential = GoogleAuthProvider.credential(
       accessToken: googleAuth.accessToken,
       idToken: googleAuth.idToken,
     );

     // Once signed in, return the UserCredential

     UserCredential user = await FirebaseAuth.instance.signInWithCredential(credential);


     print(user.user?.uid);
     print(user.user?.email);
     //if(user.additionalUserInfo.isNewUser) {
       var response = await http.post(Uri.parse("${baseUrl}/user/"),
           headers: {
             "Accept": "application/json",
             "Content-Type": "application/x-www-form-urlencoded"
           },

           // name, email , uid, imgLink
           body: {
             "name":user.user?.displayName,
             "email":user.user?.email,
             "uid":user.user?.uid,
             "imgLink":user.user?.photoURL,
           });

     //}


     Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => HomePage()), (route) => false);
   }catch(e) {
     print(e);
   }

  }
 // addUser() async {
 //    User? user = FirebaseAuth.instance.currentUser;
 //    CollectionReference users = FirebaseFirestore.instance.collection('users');
 //    bool exist = false;
 //    try {
 //      await users.doc(user!.uid).get().then((doc) {
 //        exist = doc.exists;
 //        if (exist == true) print('exist');
 //      });
 //    } catch (e) {
 //      // If any error
 //      exist = false;
 //      print(e);
 //    }
 //    if (exist == false) {
 //      users
 //          .doc(user!.uid)
 //          .set({
 //            'name': user.displayName,
 //            'email': user.email,
 //            'phoneNo': user.phoneNumber
 //          })
 //          .then((value) => print("User Added"))
 //          .catchError((error) => print("Failed to add user: $error"));
 //    }
 //  }
 //

  Future<void> logout(BuildContext context) async {
    /// Method to Logout the `FirebaseUser` (`_firebaseUser`)
    final GoogleSignIn googleSignIn = GoogleSignIn();

    try {
      // signout code
      await FirebaseAuth.instance.signOut();
      await googleSignIn.signOut();
      _firebaseUser = null;
      final snackBar = SnackBar(content: Text('Logged Out!'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      // Provider.of<CartData>(context, listen: false).clearCartData();
      // Provider.of<CartData>(context, listen: false).cleara();
    } catch (e) {
      final snackBar = SnackBar(content: Text(e.toString()));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
   
   Provider.of<Account>(context, listen: false).logout();
    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => LogIn()), (route) => false);
    notifyListeners();
  }

}
