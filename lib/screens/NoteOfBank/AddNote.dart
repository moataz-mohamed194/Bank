
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/widgets/button_widget.dart';
import '../../core/widgets/textfield.dart';
import '../../domain/NoteDateProvider.dart';

class AddNote extends StatelessWidget{
  final String bank;
  final String? nameNote;
  final String? idNote;

  const AddNote({super.key, required this.bank, this.nameNote, this.idNote});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appBarBody(context),
        body:bodyWidget(context)
    );
  }

  AppBar appBarBody(BuildContext context){
    return AppBar(
      title: nameNote != null?const Text('Edit note'): const Text('Add Note'),
    );
  }

  Widget bodyWidget(BuildContext context){
    final validationService = Provider.of<NoteDateProvider>(context);
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextFieldWidget(
            hintText: "Note of bank",
            errorText: validationService.noteText.error,
            textIcon: const Icon(Icons.note_alt),
            cursorColor: Colors.black,
            borderSideColor: Theme.of(context).primaryColor,
            textStyleColor: Colors.black,
            textChange: (vals) {
              validationService.changeNoteTextOfBank(vals);
            },
            inputType: TextInputType.text,
            oldData: nameNote,
          ),
          ButtonWidget(
            height: 50,
            color: Theme.of(context).primaryColor,
            text: nameNote != null?'Edit note':"Add Note",
            borderColor: Theme.of(context).primaryColor,
            textColor:Theme.of(context).cardColor,
            onPressed: ()  async {
              if (idNote==null && nameNote ==null){
                if (await validationService.investmentIsValid(bank)) {
                  Navigator.of(context).pop();
                }
              }else{
                if (await validationService.editNote(bank, idNote, validationService.noteText.value)) {
                  Navigator.of(context).pop();
                }
              }
              validationService.getNotesOfBank(bank.toString());

            },
          )
        ],
      ),
    );
  }


}