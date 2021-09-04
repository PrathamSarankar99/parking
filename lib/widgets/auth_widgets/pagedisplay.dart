import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PageDisplay extends StatelessWidget {
  const PageDisplay({Key key, this.assetPath, this.text}) : super(key: key);
  final String assetPath;
  final String text;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        SizedBox(
          height: 225,
          child: Image.asset(
            assetPath,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
            left: 20,
            bottom: 30,
            right: 80,
          ),
          child: Text(text,
              style: GoogleFonts.poppins(
                fontSize: 17,
                fontWeight: FontWeight.w500,
              )),
        ),
      ],
    );
  }
}
