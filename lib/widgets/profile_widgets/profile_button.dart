import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileButton extends StatelessWidget {
  const ProfileButton(
      {Key key, this.onPressed, this.text, this.topPadding = 25})
      : super(key: key);
  final VoidCallback onPressed;
  final String text;
  final double topPadding;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 20, right: 20, top: topPadding),
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(Colors.blue),
          fixedSize: MaterialStateProperty.all(
            Size(MediaQuery.of(context).size.width, 48),
          ),
          overlayColor: MaterialStateProperty.all(
            Colors.white.withOpacity(0.1),
          ),
        ),
        onPressed: onPressed,
        child: Text(
          text,
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontWeight: FontWeight.w500,
            fontSize: 23,
          ),
        ),
      ),
    );
  }
}
