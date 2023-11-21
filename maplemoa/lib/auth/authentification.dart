import'package:firebase_auth/firebase_auth.dart';
import 'package:community/main.dart';

class Authentification{
  Future<bool> createUser(String email, String pw) async{
    try{
      final crendential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email, password: pw
        );
    } on FirebaseAuthException catch (e){
      if (e.code == 'weak-password'){
        logger.w('The password provided is too weak');
      }else if(e.code == 'wrong-password'){
        logger.w('Wrong password provided for that user.');
      }
    }catch(e){
      logger.e(e);
      return false;
    }
    return true;
  }

  //logout
  void signOut() async{
    await FirebaseAuth.instance.signOut();
  }

  //login persist
  void authPersistence() async{
    await FirebaseAuth.instance.setPersistence(Persistence.NONE);
  }

  //delete user
  Future<void>deleteUser(String email) async{
    final user = FirebaseAuth.instance.currentUser;
    await user?.delete();
  }

  User? getUser(){
    final user = FirebaseAuth.instance.currentUser;
    logger.e(user);
    if(user != null){
      final name = user.displayName;
      final email = user.email;
      final photoUrl = user.photoURL;

      //check that email is verified
      final emailVerified = user.emailVerified;

      final uid = user.uid;
    }
    return user;
  }

  User? getUserInfo(){
    final user = FirebaseAuth.instance.currentUser;
    if(user != null){
      for(final providerProfile in user.providerData){
        final provider = providerProfile.providerId;

        final uid = providerProfile.uid;

        final name = providerProfile.displayName;
        final emailAddress = providerProfile.email;
        final profilePhoto = providerProfile.photoURL;
        
      }
    }
    return user;
  }
  //user name update
  Future<void> updateProfileName(String name) async {
    final user = FirebaseAuth.instance.currentUser;
    await user?.updateDisplayName(name);
  }
  //user photo update
  Future<void>updateProfileUrl(String url) async{
    final user = FirebaseAuth.instance.currentUser;
    await user?.updatePhotoURL(url);
  }
  //sending pw reset email
  Future<void> sendPasswordResetEmail(String email) async {
    await FirebaseAuth.instance.setLanguageCode("kr");
    await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
  }
}