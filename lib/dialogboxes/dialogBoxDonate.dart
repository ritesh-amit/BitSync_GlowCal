import 'package:flutter/material.dart';
import 'package:gur/dialogboxes/dialogBoxRemark.dart';
import '../Utils/SizeConfig.dart';
import '../Utils/constants.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';

class DialogBoxDonate extends StatefulWidget {
  _DialogBoxDonateState createState() => _DialogBoxDonateState();
}

class _DialogBoxDonateState extends State<DialogBoxDonate> {
  TextEditingController manualAmountController = TextEditingController();
  List weight = [false, false, false, false];
  List weightGap = ["5-10", "10-15", "15-20", "Above 20"];
  ScrollController _scrollController = ScrollController();

  void toNavigate(double qwer) {
    _scrollController.animateTo(SizeConfig.screenHeight * qwer / 896,
        curve: Curves.easeOut, duration: const Duration(microseconds: 100));
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    bool amit = true;
    var b = SizeConfig.screenWidth / 414;
    var h = SizeConfig.screenHeight / 896;
    return Dialog(
      insetPadding: EdgeInsets.only(top: h * 200),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(b * 30),
          topRight: Radius.circular(b * 30),
        ),
      ),
      child: SingleChildScrollView(
        controller: _scrollController,
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          Container(
            margin: EdgeInsets.symmetric(vertical: h * 26),
            padding: EdgeInsets.symmetric(horizontal: b * 20),
            child: Column(
              children: [
                Text(
                  'Select Food Amount',
                  textAlign: TextAlign.center,
                  style: txtS(textColor, 22, FontWeight.w600),
                ),
                sh(9),
                Text(
                  'Weight/Volume',
                  textAlign: TextAlign.center,
                  style: txtS(rc, 22, FontWeight.w500),
                ),
                sh(24),
                ListView.builder(
                    shrinkWrap: true,
                    physics: BouncingScrollPhysics(),
                    padding: EdgeInsets.zero,
                    itemCount: 4,
                    itemBuilder: (BuildContext ctxt, int index) {
                      return Column(children: [
                        InkWell(
                          onTap: () {
                            if (mounted)
                              setState(() {
                                if (index == 0) {
                                  weight[0] = !weight[0];
                                  weight[1] = false;
                                  weight[2] = false;
                                  weight[3] = false;
                                } else if (index == 1) {
                                  weight[1] = !weight[1];
                                  weight[0] = false;
                                  weight[2] = false;
                                  weight[3] = false;
                                } else if (index == 2) {
                                  weight[2] = !weight[2];
                                  weight[0] = false;
                                  weight[1] = false;
                                  weight[3] = false;
                                } else if (index == 3) {
                                  weight[3] = !weight[3];
                                  weight[0] = false;
                                  weight[2] = false;
                                  weight[1] = false;
                                }
                              });
                          },
                          child: Container(
                            alignment: Alignment.center,
                            height: h * 68,
                            decoration: BoxDecoration(
                              color: weight[index] == true ? mc : Colors.white,
                              border: Border.all(
                                color: Color(0xffff9104).withOpacity(0.31),
                                width: b * 2,
                              ),
                              borderRadius: BorderRadius.circular(b * 18),
                            ),
                            child: Text(
                              '${weightGap[index]} Kg',
                              style: txtS(
                                  weight[index] == false
                                      ? Color(0xff828282)
                                      : Colors.white,
                                  18,
                                  FontWeight.w600),
                            ),
                          ),
                        ),
                        sh(19),
                      ]);
                    }),
                sh(8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(color: rc, height: h * 1, width: b * 130),
                    Text(
                      'Or',
                      style: txtS(rc, 14, FontWeight.w500),
                    ),
                    Container(color: rc, height: h * 1, width: b * 130),
                  ],
                ),
                sh(33),
                Container(
                  alignment: Alignment.center,
                  height: h * 68,
                  width: b * 371,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Color(0xffff9104).withOpacity(0.31),
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(b * 18),
                  ),
                  child: Container(
                    alignment: Alignment.center,
                    width: b * 150,
                    child: TextFormField(
                      controller: manualAmountController,
                      onFieldSubmitted: (String qwert) {
                        toNavigate(0);
                      },
                      onTap: () {
                        toNavigate(500);
                        if (mounted)
                          setState(() {
                            print(amit);
                            weight[0] = false;
                            weight[1] = false;
                            weight[2] = false;
                            weight[3] = false;
                          });
                      },
                      style: txtS(textColor, 16, FontWeight.w600),
                      decoration: InputDecoration(
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        hintText: "Enter it Manually",
                        hintStyle: txtS(Color(0xff828282), 16, FontWeight.w600),
                        isDense: true,
                        contentPadding: EdgeInsets.symmetric(vertical: h * 9),
                      ),
                    ),
                  ),
                ),
                sh(30),
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                    String foodWeightCode;
                    if (weight[0] == true)
                      foodWeightCode = "5-10 Kg";
                    else if (weight[1])
                      foodWeightCode = "10-15 Kg";
                    else if (weight[2])
                      foodWeightCode = "15-20 Kg";
                    else if (weight[3])
                      foodWeightCode = "Above 20 Kg";
                    else
                      foodWeightCode = manualAmountController.text;

                    dialogBoxRemark(context, foodWeightCode);
                  },
                  child: Container(
                    height: h * 50,
                    alignment: Alignment.center,
                    width: b * 371,
                    decoration: BoxDecoration(
                      color: mc,
                      borderRadius: BorderRadius.circular(b * 46),
                    ),
                    child: Text(
                      'Continue',
                      style: txtS(Colors.white, 16, FontWeight.w700),
                    ),
                  ),
                ),
                sh(350),
              ],
            ),
          ),
        ]),
      ),
    );
  }

  SizedBox sh(double h) {
    return SizedBox(height: SizeConfig.screenHeight * h / 896);
  }

  TextStyle txtS(Color col, double siz, FontWeight wg) {
    return TextStyle(
      color: col,
      fontWeight: wg,
      fontSize: SizeConfig.screenWidth * siz / 414,
    );
  }
}

void dialogBoxDonate(BuildContext context) {
  showAnimatedDialog(
    context: context,
    barrierDismissible: true,
    builder: (BuildContext context) {
      return DialogBoxDonate();
    },
    animationType: DialogTransitionType.slideFromBottomFade,
    curve: Curves.fastOutSlowIn,
    duration: Duration(milliseconds: 250),
  );
}
