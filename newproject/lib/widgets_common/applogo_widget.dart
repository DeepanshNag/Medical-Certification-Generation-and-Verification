import 'package:newproject/consts/consts.dart';

Widget applogoWidget() {
  //using velocity x here
  return Image.asset(icAppLogo)
      .box
      .white
      .size(177, 177)
      .padding(const EdgeInsets.all(8))
      .rounded
      .make();
}
