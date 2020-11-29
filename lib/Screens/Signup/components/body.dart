import 'package:emergencyfeedback/Screens/MainScreen/MainScreen.dart';
import 'package:emergencyfeedback/services/firebase-service.dart';
import 'package:flutter/material.dart';
import 'package:emergencyfeedback/Screens/Login/login_screen.dart';
import 'package:emergencyfeedback/Screens/Signup/components/background.dart';
import 'package:emergencyfeedback/Screens/Signup/components/or_divider.dart';
import 'package:emergencyfeedback/Screens/Signup/components/social_icon.dart';
import 'package:emergencyfeedback/components/already_have_an_account_acheck.dart';
import 'package:emergencyfeedback/components/rounded_button.dart';
import 'package:emergencyfeedback/components/rounded_input_field.dart';
import 'package:emergencyfeedback/components/rounded_password_field.dart';
import 'package:flutter_svg/svg.dart';

class Body extends StatefulWidget {
  Body({Key key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  // @override
//   Widget build(BuildContext context) {
//     return Container(
//        child: child,
//     );
//   }
// }

// class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String name = "nmae",
        email = "email",
        contact = "contact",
        password = "pass";
    Size size = MediaQuery.of(context).size;
    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "SIGNUP",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: size.height * 0.03),
            // SvgPicture.asset(
            //   "assets/icons/signup.svg",
            //   height: size.height * 0.35,
            // ),
            RoundedInputField(
              hintText: "Your Name",
              onChanged: (value) {
                name = value;
              },
            ),
            RoundedInputField(
              hintText: "Your Email",
              onChanged: (value) {
                email = value;
              },
              icon: Icons.email_outlined,
            ),
            RoundedInputField(
              hintText: "Your Contact No.",
              onChanged: (value) {
                contact = value;
              },
              icon: Icons.call,
            ),
            RoundedPasswordField(
              onChanged: (value) {
                // setState(() {
                password = value;
                // print(password);
                // });
              },
            ),
            RoundedButton(
              text: "SIGNUP",
              press: () async {
                // await createUserWithEmailPassword();
                // print(name + email + contact + password);
                await addUser(email, contact, name, password);
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => MainScreen()),
                  // ModalRoute.withName('/'),
                );
              },
            ),
            SizedBox(height: size.height * 0.03),
            AlreadyHaveAnAccountCheck(
              login: false,
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return LoginScreen();
                    },
                  ),
                );
              },
            ),
            OrDivider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SocalIcon(
                  iconSrc: "assets/icons/facebook.svg",
                  press: () {},
                ),
                SocalIcon(
                  iconSrc: "assets/icons/twitter.svg",
                  press: () {},
                ),
                SocalIcon(
                  iconSrc: "assets/icons/google-plus.svg",
                  press: () {},
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
