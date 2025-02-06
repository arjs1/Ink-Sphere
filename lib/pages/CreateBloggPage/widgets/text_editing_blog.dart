import 'package:flutter/material.dart';

class TextEditingBlog extends StatefulWidget {
  final TextEditingController? controller;
  final String hintText;
  int maxLines;
  TextEditingBlog(
      {super.key,
      required this.controller,
      required this.hintText,
      required this.maxLines});

  @override
  State<TextEditingBlog> createState() => _TextEditingBlogState();
}

class _TextEditingBlogState extends State<TextEditingBlog> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      // validator: widget.validator,
      autocorrect: true,
      maxLines: widget.maxLines,
      cursorColor: Colors.white,
      decoration: InputDecoration(
        hintText: widget.hintText,
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.secondary,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.tertiary,
          ),
        ),
        fillColor: Theme.of(context).colorScheme.primary,
        filled: true,
      ),
    );
  }
}
