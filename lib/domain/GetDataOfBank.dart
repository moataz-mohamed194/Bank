
import 'package:flutter/cupertino.dart';
import '../core/error/error_text.dart';
import '../core/network/check_network.dart';
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
    CheckNetwork().connection();
    try {
      _investment = await Bank().fetchInvestmentBank(bankName);
    }catch(e){
      MessageSnackBar(failedTheAction.toString());
      _investment = {};
    }
    notifyListeners();
  }
  get investment => _investment;

  Future<bool> deleteInvestment(String name, String id) async {
    CheckNetwork().connection();
    if(await Bank().deleteInvestmentOfBank(name,id) == true){
      return true;
    }else {
      MessageSnackBar(failedTheAction.toString());
      return true;
    }
  }

}