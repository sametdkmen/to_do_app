import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_app/data/entity/note.dart';
import 'package:to_do_app/ui/cubit/home_cubit.dart';
import 'package:to_do_app/ui/cubit/note_detail_cubit.dart';
import 'package:to_do_app/ui/widgets/note_editor_card.dart';

/// Lets the user edit the text of an existing note.
class NoteDetailScreen extends StatefulWidget {
  final Note note;

  const NoteDetailScreen({super.key, required this.note});

  @override
  State<NoteDetailScreen> createState() => _NoteDetailScreenState();
}

class _NoteDetailScreenState extends State<NoteDetailScreen> {
  late final TextEditingController _noteController;

  @override
  void initState() {
    super.initState();
    _noteController = TextEditingController(text: widget.note.name);
  }

  @override
  void dispose() {
    _noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Not Detay"),
        leading: IconButton(
          onPressed: () => Navigator.of(context).popUntil((route) => route.isFirst),
          icon: const Icon(Icons.keyboard_backspace_sharp),
        ),
        backgroundColor: Colors.green.shade800,
      ),
      body: Center(
        child: SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          child: NoteEditorCard(
            controller: _noteController,
            buttonLabel: "Güncelle",
            onPressed: () {
              final homeCubit = context.read<HomeCubit>();
              context
                  .read<NoteDetailCubit>()
                  .update(widget.note.id, _noteController.text)
                  .then((_) => homeCubit.loadNotes());
              Navigator.of(context).popUntil((route) => route.isFirst);
            },
          ),
        ),
      ),
    );
  }
}
