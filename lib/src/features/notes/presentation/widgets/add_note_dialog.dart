import 'package:flutter/material.dart';
import '../../../../core/utils/app_spacing.dart';
import '../../domain/entities/note.dart';
import '../cubit/notes_cubit.dart';

class AddNoteDialog extends StatefulWidget {
  final Note? existingNote;
  final NotesCubit notesCubit;

  const AddNoteDialog({super.key, this.existingNote, required this.notesCubit});

  @override
  State<AddNoteDialog> createState() => _AddNoteDialogState();
}

class _AddNoteDialogState extends State<AddNoteDialog> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.existingNote != null) {
      _titleController.text = widget.existingNote!.title;
      _contentController.text = widget.existingNote!.content;
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      if (widget.existingNote != null) {
        // Update existing note
        final updatedNote = widget.existingNote!.copyWith(
          title: _titleController.text.trim(),
          content: _contentController.text.trim(),
          updatedAt: DateTime.now(),
        );
        widget.notesCubit.updateNote(updatedNote);
      } else {
        // Create new note
        widget.notesCubit.addNote(
          title: _titleController.text.trim(),
          content: _contentController.text.trim(),
        );
      }
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.existingNote != null ? 'Edit Note' : 'Add Note'),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: _titleController,
              decoration: const InputDecoration(
                labelText: 'Title',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Please enter a title';
                }
                return null;
              },
            ),
            SizedBox(height: AppSpacing.heightMd),
            TextFormField(
              controller: _contentController,
              decoration: const InputDecoration(
                labelText: 'Content',
                border: OutlineInputBorder(),
              ),
              maxLines: 4,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Please enter content';
                }
                return null;
              },
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: _submitForm,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.deepPurple,
            foregroundColor: Colors.white,
          ),
          child: Text(widget.existingNote != null ? 'Update' : 'Add'),
        ),
      ],
    );
  }
}
