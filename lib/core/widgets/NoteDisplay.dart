
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../domain/NoteDateProvider.dart';
import '../../screens/NoteOfBank/AddNote.dart';

class NoteDisplay extends StatelessWidget{
  final String id ;
  final String note;
  final String number;
  final String name;

  const NoteDisplay({super.key,
    required this.id,
    required this.note,
    required this.name,
    required this.number});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(20.0),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Text('$number.'),
          ),
          Expanded(
            flex: 5,
            child: Text(note.toString()),
          ),
          Expanded(
            flex: 1,
            child: Column(
              children: [
                IconButton(
                    onPressed: ()=>_editNoteMethod(context),
                    icon: const Icon(Icons.edit)
                ),
                IconButton(
                  onPressed:()=> _deleteNoteMethod(name,id,context),
                  icon: const Icon(Icons.close),
                  color: Colors.red
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  _deleteNoteMethod(String name, String id,BuildContext context ){
    final dataProvider = Provider.of<NoteDateProvider>(context,listen: false);
    dataProvider.deleteNote(name,id);
    dataProvider.getNotesOfBank(name.toString());

  }

  _editNoteMethod(BuildContext context){
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return AddNote(bank:name,nameNote: note, idNote: id,);
    }));
  }
}