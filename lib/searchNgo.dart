import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'Utils/SizeConfig.dart';
import 'Utils/constants.dart';

class SearchScreen extends StatelessWidget {
  TextEditingController titleController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    var b = SizeConfig.screenWidth / 414;
    var h = SizeConfig.screenHeight / 896;
    return Container(
      child: Column(children: [
        //sh(110),
        Container(
          padding: EdgeInsets.symmetric(horizontal: b * 23),
          height: h * 50,
          width: 374 * b,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(b * 50),
          ),
          child: TextField(
            textAlign: TextAlign.center,
            controller: titleController,
            style: txtS(textColor, 18, FontWeight.w500),
            decoration: dec('Enter the Ngo Name'),
          ),
        ),
        sh(30),
        Container(
          height: h * 400,
          margin: EdgeInsets.symmetric(horizontal: b * 20),
          padding: EdgeInsets.symmetric(horizontal: b * 10, vertical: h * 0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(b * 13),
            color: Colors.white,
          ),
          child: ListView.builder(
            shrinkWrap: true,
            physics: BouncingScrollPhysics(),
            itemCount: 25,
            itemBuilder: (context, index) => Column(
              children: <Widget>[
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    margin: EdgeInsets.only(
                        top: index == 0 ? h * 0 : h * 12, bottom: h * 12),
                    height: h * 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(b * 20),
                      color: Color(0xffff1f1f1),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: h * 97,
                          width: b * 97,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(b * 13),
                            color: Color(0xff785758),
                          ),
                        ),
                        SizedBox(width: b * 15),
                        Container(
                          width: b * 230,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              sh(7),
                              Container(
                                width: b * 144,
                                child: Text(
                                  'Raam Puri NGO ',
                                  overflow: TextOverflow.ellipsis,
                                  style: txtS(textColor, 20, FontWeight.w600),
                                ),
                              ),
                              Row(
                                children: [
                                  Container(
                                    alignment: Alignment.center,
                                    width: b * 16,
                                    height: h * 16,
                                    decoration: BoxDecoration(
                                      color: mc,
                                      boxShadow: [
                                        BoxShadow(
                                          color: Color(0xffff9001),
                                          blurRadius: 24,
                                          spreadRadius: -9,
                                          offset: Offset(0, 8),
                                        ),
                                      ],
                                      borderRadius:
                                          BorderRadius.circular(b * 4),
                                    ),
                                    child: Icon(Icons.food_bank,
                                        color: Colors.white, size: b * 10),
                                  ),
                                  SizedBox(width: b * 10),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        '12',
                                        style: txtS(
                                            textColor, 12, FontWeight.w500),
                                      ),
                                      Text(
                                        'Packages Delivered',
                                        style: txtS(rc, 10, FontWeight.w400),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              sh(2),
                              Row(
                                children: [
                                  Container(
                                    alignment: Alignment.center,
                                    width: b * 16,
                                    height: h * 16,
                                    decoration: BoxDecoration(
                                      color: gc,
                                      boxShadow: [
                                        BoxShadow(
                                          color: gc,
                                          blurRadius: 24,
                                          spreadRadius: -9,
                                          offset: Offset(0, 8),
                                        ),
                                      ],
                                      borderRadius:
                                          BorderRadius.circular(b * 4),
                                    ),
                                    child: Icon(Icons.verified,
                                        color: Colors.white, size: b * 8),
                                  ),
                                  SizedBox(width: b * 10),
                                  Text(
                                    'Verified',
                                    style: txtS(textColor, 12, FontWeight.w500),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    'Working Since 2018',
                                    style: txtS(textColor, 12, FontWeight.w500),
                                  ),
                                ],
                              ),
                              sh(3),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ]),
    );
  }

  InputDecoration dec(String txt) {
    return InputDecoration(
      enabledBorder: InputBorder.none,
      focusedBorder: InputBorder.none,
      hintText: txt,
      hintStyle: TextStyle(
        color: textColor,
        fontSize: SizeConfig.screenWidth * 18 / 412,
        fontWeight: FontWeight.w400,
      ),
      isDense: true,
      contentPadding:
          EdgeInsets.symmetric(vertical: SizeConfig.screenHeight * 15 / 896),
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
