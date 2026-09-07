import 'package:flutter/material.dart';

/// Gradient card with a multi-line text field and an action button, shared by
/// the "add note" and "note detail" screens.
class NoteEditorCard extends StatelessWidget {
  final TextEditingController controller;
  final String buttonLabel;
  final VoidCallback onPressed;

  const NoteEditorCard({
    super.key,
    required this.controller,
    required this.buttonLabel,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 350,
      width: 350,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        image: const DecorationImage(
          image: AssetImage("assets/images/gradient2.png"),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(Colors.black12, BlendMode.darken),
        ),
        boxShadow: [
          BoxShadow(blurRadius: 8, color: Colors.grey.withValues(alpha: 0.5), offset: const Offset(1, 1)),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: TextField(
              controller: controller,
              keyboardType: TextInputType.name,
              maxLines: 8,
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                border: InputBorder.none,
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(width: 2, color: Colors.white),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(width: 3, color: Colors.white),
                ),
                errorBorder: OutlineInputBorder(
                  borderSide: BorderSide(width: 3, color: Colors.white),
                ),
              ),
            ),
          ),
          ElevatedButton(
            onPressed: onPressed,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.transparent,
              side: BorderSide(width: 3, color: Colors.black54.withAlpha(60)),
            ),
            child: Text(
              buttonLabel,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.w400,
                shadows: [Shadow(color: Colors.grey, blurRadius: 4, offset: Offset(-0.2, 0.3))],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
