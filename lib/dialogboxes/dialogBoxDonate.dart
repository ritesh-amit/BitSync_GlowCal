import 'package:flutter/material.dart';
import 'package:gur/dialogboxes/dialogBoxRemark.dart';
import '../Utils/SizeConfig.dart';
import '../Utils/constants.dart';

class DialogBoxDonate extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Dialog(
      elevation: 200,
      insetPadding: EdgeInsets.only(
        top: SizeConfig.screenHeight * 255 / 896,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(SizeConfig.screenWidth * 30 / 414),
          topRight: Radius.circular(SizeConfig.screenWidth * 30 / 414),
        ),
      ),
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
                'Select Food Amount',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: textColor,
                  fontSize: SizeConfig.screenWidth * 22 / 414,
                ),
              ),
              SizedBox(
                height: SizeConfig.screenHeight * 4 / 896,
              ),
              Text(
                'Weight/Volume',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: rc,
                  fontSize: SizeConfig.screenWidth * 22 / 414,
                ),
              ),
              SizedBox(
                height: SizeConfig.screenHeight * 24 / 896,
              ),
              Container(
                alignment: Alignment.center,
                height: SizeConfig.screenHeight * 68 / 896,
                width: SizeConfig.screenWidth * 350 / 414,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Color(0xffff9104).withOpacity(0.31),
                    width: 2,
                  ),
                  borderRadius:
                      BorderRadius.circular(SizeConfig.screenWidth * 18 / 414),
                ),
                child: Text(
                  '10-15 Kg',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Color(0xff828282),
                    fontSize: SizeConfig.screenWidth * 18 / 414,
                  ),
                ),
              ),
              SizedBox(
                height: SizeConfig.screenHeight * 19 / 896,
              ),
              Container(
                alignment: Alignment.center,
                height: SizeConfig.screenHeight * 68 / 896,
                width: SizeConfig.screenWidth * 350 / 414,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Color(0xffff9104).withOpacity(0.31),
                    width: 2,
                  ),
                  borderRadius:
                      BorderRadius.circular(SizeConfig.screenWidth * 18 / 414),
                ),
                child: Text(
                  '15-20 Kg',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Color(0xff828282),
                    fontSize: SizeConfig.screenWidth * 18 / 414,
                  ),
                ),
              ),
              SizedBox(
                height: SizeConfig.screenHeight * 19 / 896,
              ),
              Container(
                alignment: Alignment.center,
                height: SizeConfig.screenHeight * 68 / 896,
                width: SizeConfig.screenWidth * 350 / 414,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Color(0xffff9104).withOpacity(0.31),
                    width: 2,
                  ),
                  borderRadius:
                      BorderRadius.circular(SizeConfig.screenWidth * 18 / 414),
                ),
                child: Text(
                  'Above 20 Kg',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Color(0xff828282),
                    fontSize: SizeConfig.screenWidth * 18 / 414,
                  ),
                ),
              ),
              SizedBox(
                height: SizeConfig.screenHeight * 27 / 896,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    color: rc,
                    height: SizeConfig.screenHeight * 1 / 896,
                    width: SizeConfig.screenWidth * 130 / 414,
                  ),
                  InkWell(
                    onTap: null,
                    child: Text(
                      'Or',
                      style: TextStyle(
                        color: rc,
                        fontWeight: FontWeight.w500,
                        fontSize: SizeConfig.screenWidth * 14 / 414,
                      ),
                    ),
                  ),
                  Container(
                    color: rc,
                    height: SizeConfig.screenHeight * 1 / 896,
                    width: SizeConfig.screenWidth * 130 / 414,
                  ),
                ],
              ),
              SizedBox(
                height: SizeConfig.screenHeight * 33 / 896,
              ),
              Container(
                alignment: Alignment.center,
                height: SizeConfig.screenHeight * 68 / 896,
                width: SizeConfig.screenWidth * 350 / 414,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Color(0xffff9104).withOpacity(0.31),
                    width: 2,
                  ),
                  borderRadius:
                      BorderRadius.circular(SizeConfig.screenWidth * 18 / 414),
                ),
                child: Text(
                  'Enter it manually',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Color(0xff828282),
                    fontSize: SizeConfig.screenWidth * 18 / 414,
                  ),
                ),
              ),
              SizedBox(
                height: SizeConfig.screenHeight * 30 / 896,
              ),
              InkWell(
                onTap: () {
                  dialogBoxRemark(context);
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
                    'Continue',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      fontSize: SizeConfig.screenWidth * 16 / 414,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ]),
    );
  }
}

void dialogBoxDonate(BuildContext context) {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return DialogBoxDonate();
      });
}
