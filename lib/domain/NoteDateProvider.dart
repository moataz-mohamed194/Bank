import 'package:flutter/cupertino.dart';

import '../core/error/error_text.dart';
import '../core/network/check_network.dart';
import '../data/Note.dart';
import '../data/model/ValidationItem.dart';

class NoteDateProvider extends ChangeNotifier{
  Map _note = {};
  Future <void> getNotesOfBank(String bankName)async{
    CheckNetwork().connection();

    try {
      _note = await Note().fetchNotesBank(bankName);
    }catch(e){
      MessageSnackBar(failedToGetData.toString());

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
    CheckNetwork().connection();
    if (noteTextData.value != null) {
      String? result = await Note().addNoteOfBank(name,noteTextData.value);
        if(result != null){
          MessageSnackBar(result.toString());
        }
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
    CheckNetwork().connection();
    if(await Note().deleteNoteOfBank(name,id) == true){
      return true;
    }else {
      MessageSnackBar(failedTheAction.toString());
      return true;
    }
  }


  Future<bool> editNote(String? bank, String? id, String? note)async{
    CheckNetwork().connection();
    if(await Note().editNoteOfBank(bank,id, note) == true){
      return true;
    }else {
      MessageSnackBar(failedTheAction.toString());
      return true;
    }
  }

}