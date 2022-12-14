
import 'package:flutter/cupertino.dart';
import '../data/Bank.dart';

class GetDataOfBank extends ChangeNotifier{
  List _banksList = [];
  Future<void> getListOfBankNames() async{
    _banksList = await Bank().fetchBankNames();

    notifyListeners();
  }
  get banksList => _banksList;

  Map _investment = {};
  Future <void> getInvestmentOfBank(String bankName)async{
    try {
      _investment = await Bank().fetchInvestmentBank(bankName);
    }catch(e){
      _investment = {};
    }
    notifyListeners();
  }
  get investment => _investment;

  Future<bool> deleteInvestment(String name, String id) async {
    if(await Bank().deleteInvestmentOfBank(name,id) == true){
      return true;
    }else {
      return true;
    }
  }

}