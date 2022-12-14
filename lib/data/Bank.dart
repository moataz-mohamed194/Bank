
import 'package:firebase_database/firebase_database.dart';

import 'CheckLoged.dart';

class Bank{

  Future<String?> addNewBank(String bankName, String saving)async{
    String? key = await CheckLogged().changeChecked();
    if (key == null){
      return 'can\'t add';
    }
    DatabaseReference ref = FirebaseDatabase.instance.ref('$key/banks/$bankName');
    await ref.set({
      "saving": saving.toString(),
    }).then((_) {
      return null;
      // Data saved successfully!
    }).catchError((error) {
      return error.toString();
    });

    return 'null';


  }

  Future fetchBankNames() async {
    try {
      String? key = await CheckLogged().changeChecked();
      if (key == null){
        return 'can\'t get data';
      }
      final ref = FirebaseDatabase.instance.ref();
      final snapshot = await ref.child('$key/banks').get();
      if (snapshot.exists) {
        Map dataOfBanks= snapshot.value as Map;
        return dataOfBanks.keys.toList();
      } else {
        return ('No data available.');
      }
    } catch (e) {
      return e;
    }
  }

  Future fetchInvestmentBank(String name) async {
    try {
      String? key = await CheckLogged().changeChecked();
      if (key == null){
        return 'can\'t get data';
      }
      final ref = FirebaseDatabase.instance.ref();
      final snapshot = await ref.child('$key/banks/$name/Investment').get();
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

  Future addInvestmentBank(String name, String? number, String? amount, String? benefit, String? dateOfBenefit, String? dateOfEnd) async {
    try {
      String? key = await CheckLogged().changeChecked();
      if (key == null){
        return 'can\'t get data';
      }
      DatabaseReference ref = FirebaseDatabase.instance.ref('$key/banks/$name/Investment').push();

      ref.set({
        "amount": amount.toString(),
        "benefit": benefit.toString(),
        "date_of_benefit": dateOfBenefit.toString(),
        "date_of_end": dateOfEnd.toString(),
        "number": number.toString(),
      }).then((_) {
        return null;
      }).catchError((error) {
        return error.toString();
      });
    } catch (e) {
      return e;
    }
  }

  Future deleteInvestmentOfBank(String name, String id)async{
    try {
      String? key = await CheckLogged().changeChecked();
      if (key == null) {
        return 'can\'t get data';
      }
      await FirebaseDatabase.instance.ref('$key/banks/$name/Investment/$id')
          .remove();
      return true;
    }catch(e){
      return false;
    }
  }

  Future editInvestmentOfBank(String? name, String? id, String? number, String? amount, String? benefit, String? dateOfBenefit, String? dateOfEnd)async{
    try {
      String? key = await CheckLogged().changeChecked();
      if (key == null) {
        return 'can\'t get data';
      }
      var ref = FirebaseDatabase.instance.ref('$key/banks/$name/Investment/$id');
      if (amount!=null) {
        await ref.update({
          "amount": amount.toString()
          });
      }
      if(benefit!=null) {
        await ref.update({
          "benefit": benefit.toString(),
        });
      }
      if(dateOfBenefit!=null) {
        await ref.update({
          "date_of_benefit": dateOfBenefit.toString(),
        });
      }
      if(dateOfEnd!=null) {
        await ref.update({
          "date_of_end": dateOfEnd.toString(),
        });
      }
      if(number!=null) {
        await ref.update({
          "number": number.toString(),
        });
      }
      return true;
    }catch(e){
      return false;
    }
  }


}