import 'package:flutter/material.dart';
import 'package:gur/donateDoneDialog.dart';
import 'Utils/SizeConfig.dart';
import 'Utils/constants.dart';

class DialogBoxRemark extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Dialog(
      insetPadding: EdgeInsets.only(
        top: SizeConfig.screenHeight * 255 / 896,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(SizeConfig.screenWidth * 30 / 414),
          topRight: Radius.circular(SizeConfig.screenWidth * 30 / 414),
        ),
      ),
      child: SingleChildScrollView(
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          Container(
            margin: EdgeInsets.symmetric(
              vertical: SizeConfig.screenHeight * 26 / 814,
            ),
            padding: EdgeInsets.symmetric(
              horizontal: SizeConfig.screenWidth * 32 / 414,
            ),
            child: Column(
              children: [
                Text(
                  'Remarks for NGO',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: textColor,
                    fontSize: SizeConfig.screenWidth * 22 / 414,
                  ),
                ),
                SizedBox(
                  height: SizeConfig.screenHeight * 32 / 896,
                ),
                Container(
                  height: SizeConfig.screenHeight * 317 / 896,
                  width: SizeConfig.screenWidth * 350 / 414,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Color(0xffff9104).withOpacity(0.31),
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(
                        SizeConfig.screenWidth * 18 / 414),
                  ),
                  child: TextField(
                    style: TextStyle(
                      color: textColor,
                      fontSize: SizeConfig.screenWidth * 18 / 414,
                      fontWeight: FontWeight.w500,
                    ),
                    decoration: InputDecoration(
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      hintText: 'Enter Remarks',
                      hintStyle: TextStyle(
                        color: Color(0xff828282),
                        fontSize: SizeConfig.screenWidth * 18 / 414,
                        fontWeight: FontWeight.w500,
                      ),
                      contentPadding: EdgeInsets.symmetric(
                        vertical: SizeConfig.screenHeight * 9 / 896,
                        horizontal: SizeConfig.screenWidth * 23 / 414,
                      ),
                    ),
                    maxLines: null,
                  ),
                ),
                SizedBox(
                  height: SizeConfig.screenHeight * 32 / 896,
                ),
                InkWell(
                  onTap: () {
                    dialogBoxDonateDone(context);
                  },
                  child: Container(
                    height: SizeConfig.screenHeight * 48 / 896,
                    alignment: Alignment.center,
                    width: SizeConfig.screenWidth * 350 / 414,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                        color: mc,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(
                          SizeConfig.screenWidth * 46 / 414),
                    ),
                    child: Text(
                      'Skip',
                      style: TextStyle(
                        color: mc,
                        fontWeight: FontWeight.w700,
                        fontSize: SizeConfig.screenWidth * 16 / 414,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: SizeConfig.screenHeight * 32 / 896,
                ),
                InkWell(
                  onTap: () {
                    dialogBoxDonateDone(context);
                  },
                  child: Container(
                    height: SizeConfig.screenHeight * 48 / 896,
                    alignment: Alignment.center,
                    width: SizeConfig.screenWidth * 350 / 414,
                    decoration: BoxDecoration(
                      color: mc,
                      borderRadius: BorderRadius.circular(
                          SizeConfig.screenWidth * 46 / 414),
                    ),
                    child: Text(
                      'Done',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: SizeConfig.screenWidth * 16 / 414,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: SizeConfig.screenHeight * 32 / 896,
                ),
              ],
            ),
          ),
        ]),
      ),
    );
  }
}

void dialogBoxRemark(BuildContext context) {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return DialogBoxRemark();
      });
}
