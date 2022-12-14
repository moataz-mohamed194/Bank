
import 'package:firebase_database/firebase_database.dart';

import 'CheckLoged.dart';

class Note{
  Future fetchNotesBank(String name) async {
    try {
      String? key = await CheckLogged().changeChecked();
      if (key == null){
        return 'can\'t get data';
      }
      final ref = FirebaseDatabase.instance.ref();
      final snapshot = await ref.child('$key/banks/$name/Notes').get();
      if (snapshot.exists) {
        Map<dynamic,dynamic> dataOfBanks= snapshot.value as Map<dynamic,dynamic>;
        return dataOfBanks;
      } else {
        return ('No data available.');
      }
    } catch (e) {
      return e;
    }
  }

  Future addNoteOfBank(String name, String? note) async {
    try {
      String? key = await CheckLogged().changeChecked();
      if (key == null){
        return 'can\'t get data';
      }
      DatabaseReference ref = FirebaseDatabase.instance.ref('$key/banks/$name/Notes').push();
      ref.set({
        "note": note.toString(),
      }).then((_) {
        return null;
      }).catchError((error) {
        return error.toString();
      });
    } catch (e) {
      return e;
    }
  }

  Future deleteNoteOfBank(String name, String id)async{
    try {
      String? key = await CheckLogged().changeChecked();
      if (key == null) {
        return 'can\'t get data';
      }
      await FirebaseDatabase.instance.ref('$key/banks/$name/Notes/$id')
          .remove();
      return true;
    }catch(e){
      return false;
    }
  }

  Future editNoteOfBank(String? name, String? id, String? note)async{
    try {
      String? key = await CheckLogged().changeChecked();
      if (key == null) {
        return 'can\'t get data';
      }
       await FirebaseDatabase.instance.ref('$key/banks/$name/Notes/$id')
          .update({
        "note": note.toString(),
      });
      return true;
    }catch(e){
      print('-$e');
      return false;
    }
  }
}