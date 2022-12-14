import 'package:flutter/cupertino.dart';

import '../data/Note.dart';
import '../data/model/ValidationItem.dart';

class NoteDateProvider extends ChangeNotifier{
  Map _note = {};
  Future <void> getNotesOfBank(String bankName)async{
    try {
      _note = await Note().fetchNotesBank(bankName);
    }catch(e){
      _note = {};
    }
    notifyListeners();
  }
  get note => _note;

  ValidationItem noteTextData = ValidationItem(null, null);
  ValidationItem get noteText => noteTextData;

  void changeNoteTextOfBank(String value) {
    if (value.length>1) {
      noteTextData = ValidationItem(value, null);
    } else {
      noteTextData = ValidationItem(null, "must the name of bank be longer");
    }
    notifyListeners();
  }

  Future<bool>  investmentIsValid(String name) async {
    if (noteTextData.value != null) {
      await Note().addNoteOfBank(name,noteTextData.value);

      return true;
    } else {
      if (noteTextData.value == null){
          noteTextData = ValidationItem(null, "must add number of investment");
      }
      notifyListeners();
      return false;
    }
  }


  Future<bool> deleteNote(String name, String id) async {
    if(await Note().deleteNoteOfBank(name,id) == true){
      return true;
    }else {
      return true;
    }
  }


  Future<bool> editNote(String? bank, String? id, String? note)async{
    if(await Note().editNoteOfBank(bank,id, note) == true){
      return true;
    }else {
      return true;
    }
  }

}