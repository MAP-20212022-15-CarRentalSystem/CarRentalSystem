import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';
import 'package:vehicle_sharing_app/screens/login_page.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/widgets.dart';

class ForgetPassword extends StatefulWidget {
  @override
  _ForgetPasswordState createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  bool isLoading = false;
  final txtEmail = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    final header = width * 0.45;
    var shortestSide = MediaQuery.of(context).size.shortestSide;
    var isMobileLayout = shortestSide < 600;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          height: height,
          color: Theme.of(context).primaryColorLight,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(top: height * 0.04),
                height: header,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Container(
                      child: ClipOval(
                        child: Image(
                          height:
                              isMobileLayout ? header * 0.65 : header * 0.65,
                          width: isMobileLayout ? header * 0.65 : header * 0.65,
                          image:
                              AssetImage('images/ToyFaces_Colored_BG_47.jpg'),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(width * 0.06),
                      topRight: Radius.circular(width * 0.06),
                    ),
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(top: width * 0.05),
                          height: width * 0.1,
                          width: width * 0.9,
                          alignment: Alignment.centerLeft,
                          child: IconButton(
                            icon: Icon(
                              Icons.arrow_back_ios,
                              color: Theme.of(context).primaryColor,
                              size: width * 0.08,
                            ),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: width * 0.06),
                          width: width * 0.82,
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Reset Password",
                            style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontWeight: FontWeight.w700,
                              fontSize: width * 0.09,
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: width * 0.06),
                          width: width * 0.8,
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Enter your email to reset your password and authenticate. We will send you an email after confirmation that you will be able to change your password",
                            style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontWeight: FontWeight.w500,
                              fontSize: width * 0.036,
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: width * 0.025),
                          child: CustomTextField(
                            hint: "Email",
                            textEditingController: txtEmail,
                            textInputType: TextInputType.emailAddress,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              isLoading = true;
                            });
                            FirebaseAuth.instance
                                .sendPasswordResetEmail(email: txtEmail.text)
                                .then((value) {
                              setState(() {
                                isLoading = false;
                              });
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) {
                                  return LoginPage();
                                }),
                              );
                            }).catchError((e) {
                              setState(() {
                                isLoading = false;
                              });

                              Toast.show(
                                'Failed',
                                context,
                                textColor: Colors.white,
                                backgroundColor: Colors.red,
                              );
                            });
                          },
                          child: isLoading
                              ? Container(
                                  width: 30,
                                  height: 30,
                                  margin: EdgeInsets.only(top: width * 0.085),
                                  child: CircularProgressIndicator(),
                                )
                              : Container(
                                  width: width * 0.8,
                                  margin: EdgeInsets.only(top: width * 0.085),
                                  child: CustomButton(
                                    text: "SEND",
                                  ),
                                ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
