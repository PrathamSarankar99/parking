import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:parking/utils/helpers/toast_helper.dart';
import 'package:parking/widgets/auth_widgets/pagedisplay.dart';
import 'package:parking/widgets/auth_widgets/slider_points.dart';

class LoginTab extends StatefulWidget {
  const LoginTab({
    Key key,
    @required this.onOtpRequest,
    this.isSending,
  }) : super(key: key);
  final Function(String) onOtpRequest;
  final bool isSending;
  @override
  _LoginTabState createState() => _LoginTabState();
}

class _LoginTabState extends State<LoginTab> {
  TextEditingController controller;
  PageController pageController;
  int sliderIndex;
  @override
  void initState() {
    sliderIndex = 0;
    pageController = PageController(
      initialPage: sliderIndex,
    );
    controller = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Stack(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Expanded(
                      child: PageView(
                    onPageChanged: (value) {
                      setState(() {
                        sliderIndex = value;
                      });
                    },
                    children: const [
                      PageDisplay(
                        assetPath: 'assets/images/towing.png',
                        text: 'Discover and book secure parking near you.',
                      ),
                      PageDisplay(
                        assetPath: 'assets/images/allvehicles.png',
                        text: 'Works for all vehicles.',
                      ),
                      PageDisplay(
                        assetPath: 'assets/images/buildings.png',
                        text:
                            'Hospitals, Malls or Offices, it works everywhere.',
                      ),
                    ],
                  )),
                  SliderPoints(
                    totalPoints: 3,
                    index: sliderIndex,
                  ),
                  Container(
                    height: 200,
                    padding: const EdgeInsets.fromLTRB(20, 20, 20, 50),
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 40,
                              height: 35,
                              decoration: BoxDecoration(
                                color: Colors.grey.withOpacity(0.35),
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(3),
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  '+91',
                                  style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16,
                                    color: Colors.black.withOpacity(0.7),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(left: 5),
                                child: TextField(
                                  inputFormatters: [
                                    LengthLimitingTextInputFormatter(10),
                                  ],
                                  onChanged: (value) {
                                    setState(() {});
                                  },
                                  style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16,
                                    color: Colors.black.withOpacity(0.7),
                                  ),
                                  controller: controller,
                                  keyboardType: TextInputType.phone,
                                  decoration: InputDecoration(
                                    suffixIcon: IconButton(
                                        onPressed: () {
                                          setState(() {
                                            controller.clear();
                                          });
                                        },
                                        icon: const Icon(Icons.clear)),
                                    hintText: 'Enter a phone number',
                                    hintStyle: GoogleFonts.poppins(
                                      fontWeight: FontWeight.w600,
                                      color: Colors.grey.shade500,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          alignment: Alignment.centerRight,
                          padding: const EdgeInsets.only(bottom: 10),
                          child: Text(
                            '${controller.text.toString().length} / 10',
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w600,
                              fontSize: 13,
                              color: Colors.black.withOpacity(0.4),
                            ),
                          ),
                        ),
                        ElevatedButton(
                          style: ButtonStyle(
                              fixedSize: MaterialStateProperty.all(
                                  Size(MediaQuery.of(context).size.width, 42))),
                          onPressed: () {
                            String phoneNo = '+91' + controller.text;
                            if (controller.text.length != 10) {
                              showToast('Enter full number');
                              return;
                            }
                            widget.onOtpRequest(phoneNo);
                          },
                          child: Text(
                            'Verify my number',
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
              if (widget.isSending)
                Container(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    color: Colors.black.withOpacity(0.5),
                    child: const Center(
                      child: CircularProgressIndicator(
                        color: Colors.white,
                        strokeWidth: 2,
                      ),
                    )),
            ],
          ),
        ),
      ),
    );
  }
}
