import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class EditProfileTile extends StatelessWidget {
  const EditProfileTile({Key key, this.title, this.hintText, this.controller})
      : super(key: key);
  final String title;
  final String hintText;
  final TextEditingController controller;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 20,
        left: 20,
        right: 20,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: GoogleFonts.poppins(
              fontSize: 16,
              color: Colors.grey.shade700,
            ),
          ),
          const SizedBox(height: 8),
          Container(
            width: MediaQuery.of(context).size.width,
            height: 60,
            decoration: BoxDecoration(
              color: Colors.blue.shade50,
              borderRadius: BorderRadius.circular(0),
            ),
            child: TextField(
              controller: controller,
              style: GoogleFonts.poppins(
                fontSize: 16,
              ),
              decoration: InputDecoration(
                hintText: hintText,
                contentPadding:
                    const EdgeInsets.only(left: 10, right: 10, top: 10),
                border: InputBorder.none,
              ),
            ),
          )
        ],
      ),
    );
  }
}
