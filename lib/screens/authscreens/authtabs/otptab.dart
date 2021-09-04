import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class OTPTab extends StatefulWidget {
  const OTPTab({
    Key key,
    this.onPop,
    this.phoneNo,
    this.verifyOtp,
  }) : super(key: key);
  final Function(String) verifyOtp;
  final String phoneNo;
  final VoidCallback onPop;
  @override
  _OTPTabState createState() => _OTPTabState();
}

class _OTPTabState extends State<OTPTab> with SingleTickerProviderStateMixin {
  List<TextEditingController> controllers;
  List<FocusNode> focusNodes;
  @override
  void initState() {
    focusNodes = List.generate(6, (index) => FocusNode());
    controllers = List.generate(6, (index) => TextEditingController());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            widget.onPop();
          },
          icon: const Icon(Icons.arrow_back),
        ),
        title: Text(
          'Verify mobile number',
          style: GoogleFonts.poppins(
            color: Colors.black,
            fontSize: 17,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            alignment: Alignment.center,
            height: 140,
            padding: const EdgeInsets.only(top: 20),
            child: Image.asset('assets/images/security.png'),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: RichText(
              textAlign: TextAlign.start,
              text: TextSpan(
                text: 'Please enter the OTP send to ',
                style: GoogleFonts.poppins(
                  color: Colors.black,
                ),
                children: [
                  TextSpan(
                    text: widget.phoneNo,
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  TextSpan(
                      text: '  Edit',
                      style: GoogleFonts.poppins(
                        color: Colors.blue,
                        fontWeight: FontWeight.w600,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          widget.onPop();
                        })
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 15, left: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                OtpTextBox(
                  controller: controllers[0],
                  focusNode: focusNodes[0],
                  index: 0,
                  setOnChange: onChanged,
                ),
                OtpTextBox(
                  controller: controllers[1],
                  focusNode: focusNodes[1],
                  index: 1,
                  setOnChange: onChanged,
                ),
                OtpTextBox(
                  controller: controllers[2],
                  focusNode: focusNodes[2],
                  index: 2,
                  setOnChange: onChanged,
                ),
                OtpTextBox(
                  controller: controllers[3],
                  focusNode: focusNodes[3],
                  index: 3,
                  setOnChange: onChanged,
                ),
                OtpTextBox(
                  controller: controllers[4],
                  focusNode: focusNodes[4],
                  index: 4,
                  setOnChange: onChanged,
                ),
                OtpTextBox(
                  controller: controllers[5],
                  focusNode: focusNodes[5],
                  index: 5,
                  setOnChange: onChanged,
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 20,
              left: 20,
              right: 20,
            ),
            child: ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(
                    getOTP().length != 6 ? Colors.grey.shade400 : Colors.blue),
                fixedSize: MaterialStateProperty.all(
                    Size(MediaQuery.of(context).size.width, 45)),
              ),
              onPressed: getOTP().length != 6
                  ? null
                  : () {
                      widget.verifyOtp(getOTP());
                    },
              child: Text(
                'Submit OTP',
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontSize: 18,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  String getOTP() {
    String otp = '';
    for (var i = 0; i < controllers.length; i++) {
      otp += controllers[i].text;
    }
    return otp;
  }

  onChanged(String value, int index) {
    setState(() {
      if (value.length == 1) {
        if (index != controllers.length - 1) {
          focusNodes[index + 1].requestFocus();
        }
      } else {
        if (index != 0) {
          focusNodes[index - 1].requestFocus();
        }
      }
    });
  }
}

class OtpTextBox extends StatelessWidget {
  const OtpTextBox(
      {Key key, this.index, this.controller, this.focusNode, this.setOnChange})
      : super(key: key);
  final int index;
  final TextEditingController controller;
  final FocusNode focusNode;
  final Function(String, int) setOnChange;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45,
      width: 45,
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: const BorderRadius.all(
          Radius.circular(8),
        ),
      ),
      child: TextField(
        focusNode: focusNode,
        onChanged: (value) {
          setOnChange(value, index);
        },
        controller: controller,
        cursorColor: Colors.grey.shade700,
        keyboardType: TextInputType.phone,
        inputFormatters: [
          LengthLimitingTextInputFormatter(1),
        ],
        style: GoogleFonts.poppins(
          fontWeight: FontWeight.w600,
          color: Colors.black.withOpacity(0.7),
        ),
        textAlign: TextAlign.center,
        decoration: const InputDecoration(
          contentPadding: EdgeInsets.zero,
          border: InputBorder.none,
        ),
      ),
    );
  }
}
