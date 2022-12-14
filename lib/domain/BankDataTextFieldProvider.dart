
import 'package:flutter/material.dart';
import '../data/Bank.dart';
import '../data/model/ValidationItem.dart';

class BankDataTextFieldProvider extends ChangeNotifier{
  ValidationItem nameOfBankData = ValidationItem(null, null);
  ValidationItem get nameOfBank => nameOfBankData;

  void changeNameOfBank(String value) {
    if (value.length>1) {
      nameOfBankData = ValidationItem(value, null);
    } else {
      nameOfBankData = ValidationItem(null, "must the name of bank be longer");
    }
    notifyListeners();
  }

  ValidationItem savingOfBankData = ValidationItem(null, null);
  ValidationItem get savingOfBank => savingOfBankData;

  void changeSavingOfBank(String value) {
    if (value.length>1&&value.contains(RegExp(r"^[0-9]*$")) == true) {
      savingOfBankData = ValidationItem(value, null);
    } else {
      savingOfBankData = ValidationItem(null, "must add the saving of bank");
    }
    notifyListeners();
  }

  Future<bool> get nameOfBankIsValid async {
    if (nameOfBankData.value != null ) {
      await Bank().addNewBank(nameOfBankData.value.toString(), savingOfBankData.value.toString());
      return true;
    } else {
      if (nameOfBankData.value == null){
        nameOfBankData = ValidationItem(null, "must add name of bank");
      }
      if (savingOfBankData.value == null){
        savingOfBankData = ValidationItem(null, "must add saving of bank");
      }
      notifyListeners();
      return false;
    }
  }

  ValidationItem numberOfInvestmentData = ValidationItem(null, null);
  ValidationItem get numberOfInvestment => numberOfInvestmentData;

  void changeNumberOfInvestment(String value) {
    if (value.length>1&&value.contains(RegExp(r"^[0-9]*$")) == true) {
      numberOfInvestmentData = ValidationItem(value, null);
    } else {
      numberOfInvestmentData = ValidationItem(null, "must add the number of investment");
    }
    notifyListeners();
  }

  ValidationItem amountOfInvestmentData = ValidationItem(null, null);
  ValidationItem get amountOfInvestment => amountOfInvestmentData;


  void changeAmountOfInvestment(String value) {
    if (value.length>1&&value.contains(RegExp(r"^[0-9]*$")) == true) {
      amountOfInvestmentData = ValidationItem(value, null);
    } else {
      amountOfInvestmentData = ValidationItem(null, "must add the amount of investment");
    }
    notifyListeners();
  }

  ValidationItem dateOfEndTheInvestmentData = ValidationItem(null, null);
  ValidationItem get dateOfEndTheInvestment => dateOfEndTheInvestmentData;

  void changeDateOfEndTheInvestment(String value) {
    if (value.length>1&&value.contains(RegExp(r"(?:(?:31(\/|-|\.)(?:0?[13578]|1[02]))\1|(?:(?:29|30)(\/|-|\.)(?:0?[13-9]|1[0-2])\2))(?:(?:1[6-9]|[2-9]\d)?\d{2})$|^(?:29(\/|-|\.)0?2\3(?:(?:(?:1[6-9]|[2-9]\d)?(?:0[48]|[2468][048]|[13579][26])|(?:(?:16|[2468][048]|[3579][26])00))))$|^(?:0?[1-9]|1\d|2[0-8])(\/|-|\.)(?:(?:0?[1-9])|(?:1[0-2]))\4(?:(?:1[6-9]|[2-9]\d)?\d{2})$")) == true) {
      dateOfEndTheInvestmentData = ValidationItem(value, null);
    } else {
      dateOfEndTheInvestmentData = ValidationItem(null, "must add the end date of investment");
    }
    notifyListeners();
  }

  ValidationItem timeOfBenefitData = ValidationItem(null, null);
  ValidationItem get timeOfBenefit => timeOfBenefitData;

  void changeTimeOfBenefit(String value) {

    try{
      if (int.parse(value)>=1&&int.parse(value)<=12&&value.contains(RegExp(r"^[0-9]*$")) == true) {
        timeOfBenefitData = ValidationItem(value, null);
      } else {
        timeOfBenefitData = ValidationItem(null, "must add the date of benefit for investment");
      }
    }catch(e){
      timeOfBenefitData = ValidationItem(null, "must add the time of benefit for investment");
    }
    notifyListeners();
  }

  ValidationItem benefitOfInvestmentData = ValidationItem(null, null);
  ValidationItem get benefitOfInvestment => benefitOfInvestmentData;

  void changeBenefitOfInvestment(String value) {

    try{
      if (value.length>=1&&value.contains(RegExp(r"^[0-9]*$")) == true) {
          benefitOfInvestmentData = ValidationItem(value, null);
      } else {
        benefitOfInvestmentData = ValidationItem(null, "must add the benefit for investment");
      }
    }catch(e){
      benefitOfInvestmentData = ValidationItem(null, "must add the benefit for investment");
    }
    notifyListeners();
  }

  Future<bool>  investmentIsValid(String name) async {
    if (numberOfInvestmentData.value != null&&
        benefitOfInvestmentData.value != null&&
        timeOfBenefitData.value != null&&
        dateOfEndTheInvestmentData.value != null&&
        amountOfInvestmentData.value !=null) {
      await Bank().addInvestmentBank(name,numberOfInvestmentData.value,amountOfInvestmentData.value,benefitOfInvestmentData.value,timeOfBenefitData.value,dateOfEndTheInvestmentData.value);

      return true;
    } else {
      if (numberOfInvestmentData.value == null){
        numberOfInvestmentData = ValidationItem(null, "must add number of investment");
      }
      if (amountOfInvestmentData.value == null){
        amountOfInvestmentData = ValidationItem(null, "must add amount of investment");
      }
      if (dateOfEndTheInvestmentData.value == null){
        dateOfEndTheInvestmentData = ValidationItem(null, "must add date of end the investment");
      }
      if (timeOfBenefitData.value == null){
        timeOfBenefitData = ValidationItem(null, "must add time of benefit for the investment");
      }
      if (benefitOfInvestmentData.value == null){
        benefitOfInvestmentData = ValidationItem(null, "must add benefit of investment");
      }
      notifyListeners();
      return false;
    }
  }
  Future<bool> editInvestment(String? bank, String? id)async{

    if( await Bank().editInvestmentOfBank(bank,id,
        numberOfInvestmentData.value,amountOfInvestmentData.value,
        benefitOfInvestmentData.value,timeOfBenefitData.value,
        dateOfEndTheInvestmentData.value)== true){
      return true;
    }else {
      return true;
    }
  }

}