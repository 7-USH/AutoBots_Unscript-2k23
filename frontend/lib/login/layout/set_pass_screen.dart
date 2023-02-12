import 'package:flutter/material.dart';
import 'package:unscript_app/login/layout/succes_pass_screen.dart';
import 'package:unscript_app/login/models/reset_pass_model.dart';
import 'package:unscript_app/login/service/login_service.dart';
import 'package:unscript_app/utils/unscript_theme.dart';

class SetPassScreen extends StatefulWidget {
  const SetPassScreen({super.key});

  @override
  State<SetPassScreen> createState() => _SetPassScreenState();
}

class _SetPassScreenState extends State<SetPassScreen> {
  final TextEditingController _newpassController = TextEditingController();
  final TextEditingController _confirmPassController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  LoginService service = LoginService();

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: UnScriptTheme.backgroundColor,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          foregroundColor: UnScriptTheme.backgroundColor,
          elevation: 0.0,
        ),
        body: Padding(
          padding: const EdgeInsets.all(25),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Create new password",
                  style: UnScriptTheme.screenText(
                      size: MediaQuery.of(context).size.width / 14,
                      weight: FontWeight.w600,
                      isShadow: true),
                ),
                const SizedBox(
                  height: 15,
                ),
                Text(
                  "Your new password must be unique from those previously used.",
                  style: UnScriptTheme.screenText(
                      size: screenWidth / 23,
                      weight: FontWeight.w500,
                      isShadow: true,
                      color: UnScriptTheme.bgTextColor2.withOpacity(0.6)),
                ),
                const SizedBox(
                  height: 30,
                ),
                TextFormField(
                  autofocus: true,
                  controller: _newpassController,
                  style: UnScriptTheme.screenText(
                      size: 16, weight: FontWeight.w500),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter new password";
                    } else if (value.length < 8) {
                      return "Password should be atleast 8 characters long";
                    }
                    return null;
                  },
                  decoration: UnScriptTheme.faInputDecoration(
                    hint: "New Password",
                    fontSize: 16,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: _confirmPassController,
                  style: UnScriptTheme.screenText(
                      size: 16, weight: FontWeight.w500),
                  autofocus: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter password";
                    } else if (value.length < 8) {
                      return "Password should be atleast 8 characters long";
                    } else if (_newpassController.text !=
                        _confirmPassController.text) {
                      return "Your password and confirmation password do not match";
                    }
                    return null;
                  },
                  decoration: UnScriptTheme.faInputDecoration(
                    hint: "Confirm Password",
                    fontSize: 16,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Center(
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          setState(() {
                            _isLoading = true;
                          });
                          service
                              .resetPassword(
                                  model: ResetPassModel(
                                      newPassword: _confirmPassController.text),
                                  context: context)
                              .then((value) {
                            if (value != null) {
                              setState(() {
                                _isLoading = false;
                              });
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (_) {
                                return const SuccessPassScreen();
                              }));
                            } else {
                              setState(() {
                                _isLoading = false;
                              });
                            }
                          });
                        }
                      },
                      style: UnScriptTheme.buttonStyle(
                          backColor: UnScriptTheme.bgTextColor2),
                      child: _isLoading
                          ? Center(
                              child: SizedBox(
                                height: screenWidth / 20,
                                width: screenWidth / 20,
                                child: const CircularProgressIndicator(
                                  color: UnScriptTheme.backgroundColor,
                                  strokeWidth: 3,
                                ),
                              ),
                            )
                          : Text(
                              "Reset Password",
                              style: UnScriptTheme.screenText(
                                  size: screenWidth / 21,
                                  color: UnScriptTheme.backgroundColor,
                                  weight: FontWeight.bold),
                            ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
    ;
  }
}
