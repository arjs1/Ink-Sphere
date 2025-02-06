import 'package:flutter/material.dart';

class CategoryBox extends StatefulWidget {
  final String categoryName;
  const CategoryBox({
    super.key,
    required this.categoryName,
  });

  @override
  State<CategoryBox> createState() => _CategoryBoxState();
}

class _CategoryBoxState extends State<CategoryBox> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        color: Theme.of(context).colorScheme.primary,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text(widget.categoryName),
        ),
      ),
    );
  }
}
