import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_icons/line_icons.dart';
import 'package:sugar_cubes/helper/help_func.dart';
import 'package:sugar_cubes/screens/auth/login_screen.dart';
import 'package:sugar_cubes/screens/home_screen.dart';
import 'package:sugar_cubes/service/auth_service.dart';
import 'package:sugar_cubes/shared/app_styles.dart';
import 'package:sugar_cubes/widgets/widgets.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool _isLoading = false;
  final formKey = GlobalKey<FormState>();
  String email = "";
  String password = "";
  String sugarname = "";

  AuthService authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Styles.sakura,
      body: _isLoading ? Center(child: CircularProgressIndicator(color: Styles.aqua,),) : SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 70),
              child: Form(
                key: formKey, 
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Register Here',
                      style: GoogleFonts.josefinSans(
                        fontSize: 40,
                        fontWeight: FontWeight.w700,
                        color: Styles.sugar
                      ),
                    ),

                    const SizedBox(height: 40),

                    Container(
                      height: 120,
                      decoration: const BoxDecoration(
                        image: DecorationImage(image: AssetImage('assets/images/sc_trans.png'), fit: BoxFit.fitHeight),
                      ),
                    ),
                      
                    const SizedBox(height: 40,),
                      
                    TextFormField(
                      textAlignVertical: TextAlignVertical.bottom,
                      style: GoogleFonts.josefinSans(
                        color: Styles.sugar,
                        fontSize: 16,
                        fontWeight: FontWeight.w300,
                      ),

                      onChanged: (value) {
                        setState(() {
                          sugarname = value;
                        });
                      },
                      validator: (value) {
                        return RegExp(r'^[a-zA-Z0-9_\\.;]+$').hasMatch(value!) ? null : "Only characters, . and _ are allowed";
                      },

                      cursorColor: Styles.aqua,
                      cursorRadius: const Radius.circular(20),
                      cursorWidth: 2,
                      cursorHeight: 16,

                      decoration: Styles.textInputDecoration.copyWith(
                        contentPadding: const EdgeInsets.only(bottom: 16, right: 20),
                        alignLabelWithHint: true,

                        hintText: 'Username',
                        hintStyle: GoogleFonts.josefinSans(
                            fontSize: 16,
                            fontWeight: FontWeight.w300,
                            color: Styles.sugar,
                        ),
                        prefixIcon: Icon(
                          LineIcons.user,
                          color: Styles.sugar,
                          size: 16,
                        ),
                        fillColor: Styles.cloud,
                        filled: true,
                      ),
                    ),
                      
                    const SizedBox(height: 7),
                      
                    TextFormField(
                      textAlignVertical: TextAlignVertical.bottom,
                      style: GoogleFonts.josefinSans(
                        color: Styles.sugar,
                        fontSize: 16,
                        fontWeight: FontWeight.w300,
                      ),

                      onChanged: (value) {
                        setState(() {
                          email = value;
                        });
                      },
                      validator: (value) {
                        return RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(value!) ? null : "Please enter an email xài được";
                      },

                      cursorColor: Styles.aqua,
                      cursorRadius: const Radius.circular(20),
                      cursorWidth: 2,
                      cursorHeight: 16,

                      decoration: Styles.textInputDecoration.copyWith(
                        contentPadding: const EdgeInsets.only(bottom: 16, right: 20),
                        alignLabelWithHint: true,

                        hintText: 'Email',
                        hintStyle: GoogleFonts.josefinSans(
                            fontSize: 16,
                            fontWeight: FontWeight.w300,
                            color: Styles.sugar,
                        ),
                        prefixIcon: Icon(
                          LineIcons.envelope,
                          color: Styles.sugar,
                          size: 16,
                        ),
                        fillColor: Styles.cloud,
                        filled: true,
                      ),
                    ),
                      
                    const SizedBox(height: 7),
                      
                    TextFormField(
                      textAlignVertical: TextAlignVertical.bottom,
                      style: GoogleFonts.josefinSans(
                        color: Styles.sugar,
                        fontSize: 16,
                        fontWeight: FontWeight.w300,
                      ),

                      obscureText: true,

                      onChanged: (value) {
                        password = value;
                      },

                      validator: (value) {
                        return RegExp(r'^.{8,}$').hasMatch(value!) ? null : "Please enter mật khẩu 8 ký tự";
                      },

                      cursorColor: Styles.aqua,
                      cursorRadius: const Radius.circular(20),
                      cursorWidth: 2,
                      cursorHeight: 16,

                      decoration: Styles.textInputDecoration.copyWith(
                        contentPadding: const EdgeInsets.only(bottom: 16, right: 20),
                        alignLabelWithHint: true,

                        hintText: 'Password',
                        hintStyle: GoogleFonts.josefinSans(
                            fontSize: 16,
                            fontWeight: FontWeight.w300,
                            color: Styles.sugar,
                        ),
                        prefixIcon: Icon(
                          LineIcons.lock,
                          color: Styles.sugar,
                          size: 16,
                        ),
                        fillColor: Styles.cloud,
                        filled: true,
                      ),
                    ),

                    const SizedBox(height: 15),

                    SizedBox(
                      width: 120,
                      height: 42,
                      child: ElevatedButton(
                        onPressed: () {
                          register();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Styles.aqua,
                          foregroundColor: Styles.cloud,
                          elevation: 0,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(50)),
                          )
                        ),
                        child: Text(
                          'Sign Up',
                          style:  GoogleFonts.josefinSans(
                            fontSize: 21,
                            fontWeight: FontWeight.w500,
                            color: Styles.cloud,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 21),

                    Text.rich(
                      TextSpan(
                        text: "Already be a sugar cube? ",
                        style: GoogleFonts.josefinSans(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Styles.sugar,
                        ),
                        children: [
                          TextSpan(
                            text: "Sugar logs",
                            style: GoogleFonts.josefinSans(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: Styles.sugar,
                              fontStyle: FontStyle.italic
                            ),
                            recognizer: TapGestureRecognizer()..onTap = () {
                              nextScreen(context, const LoginScreen());
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  register() async {
    if (formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      await authService.registerUserWithEmailPassword(sugarname, email, password).then((value) async  {
        if (value == true) {
          await HelperFunction.saveUserLogInStatus(true);
          await HelperFunction.saveUserName(sugarname);
          await HelperFunction.saveUserEmail(email);

          // ignore: use_build_context_synchronously
          nextScreenReplace(context, const HomeScreen());
        } else {
          showSnackBar(context, Styles.aqua, value);
          _isLoading = false;
        }
      });
    }
  }
}