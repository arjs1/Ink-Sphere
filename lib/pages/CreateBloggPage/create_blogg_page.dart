import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ink_sphere/core/api/blog_api.dart';
import 'package:ink_sphere/pages/CreateBloggPage/widgets/category_box.dart';
import 'package:ink_sphere/pages/CreateBloggPage/widgets/text_editing_blog.dart';

class CreateBloggPage extends StatefulWidget {
  const CreateBloggPage({super.key});

  @override
  State<CreateBloggPage> createState() => _CreateBloggPageState();
}

class _CreateBloggPageState extends State<CreateBloggPage> {
  final titleController = TextEditingController();
  final contentController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final apiCreateData = ApiFetchBlog();
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            // mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: 60,
              ),
              Text(
                "Create Your Post",
                style: GoogleFonts.poppins(
                  fontSize: 35,
                  fontWeight: FontWeight.w500,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 20,
                children: [
                  SizedBox(
                    height: 5,
                  ),
                  TextEditingBlog(
                    controller: titleController,
                    hintText: "Your Title",
                    maxLines: 2,
                  ),
                  SizedBox(
                    height: 300,
                    child: TextEditingBlog(
                      controller: contentController,
                      hintText: "Your Content...",
                      maxLines: 10,
                    ),
                  ),
                  CategoryBox(categoryName: "health"),
                ],
              ),
              MaterialButton(
                onPressed: () {
                  ApiFetchBlog().createBlog(titleController.text,
                      contentController.text, "health", context);
                },
                child: Text("Publish"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
