import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import '../Utils/SizeConfig.dart';
import '../Utils/constants.dart';

class DialogBoxRequest extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Dialog(
      elevation: 200,
      insetPadding: EdgeInsets.symmetric(
        horizontal: SizeConfig.screenWidth * 16 / 414,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(SizeConfig.screenWidth * 20 / 414),
      ),
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        Container(
          margin: EdgeInsets.symmetric(
            vertical: SizeConfig.screenHeight * 20 / 814,
          ),
          padding: EdgeInsets.symmetric(
            horizontal: SizeConfig.screenWidth * 22 / 414,
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Icon(
                      Icons.close,
                      color: gc,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: SizeConfig.screenHeight * 17 / 896,
              ),
              Container(
                height: SizeConfig.screenHeight * 140 / 896,
                width: SizeConfig.screenWidth * 140 / 414,
                decoration: BoxDecoration(
                  color: gc,
                  boxShadow: [
                    BoxShadow(
                      color: gc.withOpacity(0.7),
                      blurRadius: 20,
                      spreadRadius: 7,
                      offset: Offset(0, 6),
                    ),
                  ],
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  MdiIcons.bookmarkOutline,
                  color: Colors.white,
                  size: SizeConfig.screenWidth * 80 / 414,
                ),
              ),
              SizedBox(
                height: SizeConfig.screenHeight * 47 / 896,
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: SizeConfig.screenWidth * 36 / 414,
                ),
                child: Text(
                  'Thanks a lot for your request! Your request has been approved and we will send you an invoice soon ',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: textColor,
                    fontSize: SizeConfig.screenWidth * 16 / 414,
                  ),
                ),
              ),
              SizedBox(
                height: SizeConfig.screenHeight * 54 / 896,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  MaterialButton(
                    elevation: 5,
                    color: gc,
                    padding: EdgeInsets.zero,
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    minWidth: SizeConfig.screenWidth * 97 / 414,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        SizeConfig.screenWidth * 36 / 414,
                      ),
                    ),
                    child: Text(
                      'Close',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                        fontSize: SizeConfig.screenWidth * 16 / 414,
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: SizeConfig.screenHeight * 54 / 896,
              ),
            ],
          ),
        ),
      ]),
    );
  }
}

void dialogBoxRequest(BuildContext context) {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return DialogBoxRequest();
      });
}
