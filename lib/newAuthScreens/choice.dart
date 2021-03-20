import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:gur/newAuthScreens/signup.dart';
import '../Utils/SizeConfig.dart';
import '../Utils/constants.dart';

class Choice extends StatefulWidget {
  _ChoiceState createState() => _ChoiceState();
}

class _ChoiceState extends State<Choice> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    var b = SizeConfig.screenWidth / 414;
    var h = SizeConfig.screenHeight / 896;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: b * 35),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                'You are',
                style: TextStyle(
                  color: mc,
                  fontWeight: FontWeight.w700,
                  fontSize: b * 40,
                ),
              ),
              sh(35),
              Container(
                height: h * 65,
                width: b * 345,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(b * 10),
                  border: Border.all(color: mc, width: b * 1),
                ),
                child: MaterialButton(
                  splashColor: Colors.orange[800],
                  onPressed: () {
                    Navigator.of(context).pop();
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) {
                      return SignUp('0');
                    }));
                  },
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(b * 10),
                  ),
                  elevation: 0,
                  child: Text(
                    'NGO',
                    style: txtS(mc, 20, FontWeight.w700),
                  ),
                ),
              ),
              sh(20),
              Container(
                height: h * 65,
                width: b * 345,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(b * 10),
                  border: Border.all(color: mc, width: b * 1),
                ),
                child: MaterialButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) {
                      return SignUp('1');
                    }));
                  },
                  splashColor: Colors.orange[800],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(b * 10),
                  ),
                  elevation: 0,
                  child: Text(
                    'Donor',
                    style: txtS(mc, 20, FontWeight.w700),
                  ),
                ),
              ),
              sh(45),
            ],
          ),
        ),
      ),
    );
  }

  TextStyle txtS(Color col, double siz, FontWeight wg) {
    return TextStyle(
      color: col,
      fontWeight: wg,
      fontSize: SizeConfig.screenWidth * siz / 414,
    );
  }

  SizedBox sh(double h) {
    return SizedBox(height: SizeConfig.screenHeight * h / 896);
  }
}
