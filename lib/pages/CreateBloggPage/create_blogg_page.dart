import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CreateBloggPage extends StatefulWidget {
  const CreateBloggPage({super.key});

  @override
  State<CreateBloggPage> createState() => _CreateBloggPageState();
}

class _CreateBloggPageState extends State<CreateBloggPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: 60,
            ),
            Text(
              "Create Your Post",
              style: GoogleFonts.poppins(
                fontSize: 25,
                fontWeight: FontWeight.w500,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
