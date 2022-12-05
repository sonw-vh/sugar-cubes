import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_icons/line_icons.dart';
import 'package:sugar_cubes/helper/help_func.dart';
import 'package:sugar_cubes/screens/auth/login_screen.dart';
import 'package:sugar_cubes/service/auth_service.dart';
import 'package:sugar_cubes/service/database_service.dart';
import 'package:sugar_cubes/shared/app_styles.dart';
import 'package:sugar_cubes/widgets/sugar_jar.dart';
import 'package:sugar_cubes/widgets/widgets.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String sugarname = '';
  String email = '';
  String sugarjar = '';
  
  AuthService authService = AuthService();

  Stream? group;

  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    gettingUserData();
  }

  String getId(String res) {
    return res.substring(0, res.indexOf("_"));
  }

  String getName(String res) {
    return res.substring(res.indexOf("_") + 1);
  }

  gettingUserData() async {
    await HelperFunction.getUserEmailFromShared().then((value) {
      setState(() {
        email = value!;
      });
    });
    
    await HelperFunction.getUserNameFromShared().then((value) {
      setState(() {
        sugarname = value!;
      });
    });

    await DatabaseService(uid: FirebaseAuth.instance.currentUser!.uid).getUserGroup().then((snapshot) {
      setState(() {
        group = snapshot;
      });
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: Styles.aqua,
        title: Text(
          'Home',
          style: GoogleFonts.josefinSans(
            color: Colors.white,
            fontSize: 28,
            fontWeight: FontWeight.w500
          ),
        )
      ),

      drawer: Drawer(
        backgroundColor: Styles.cream,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(28),
          )
        ),
        width: MediaQuery.of(context).size.width * 0.75,
        child: ListView(
          padding: const EdgeInsets.symmetric(vertical: 50),
          children: [
            Container(
              height: 120,
              decoration: const BoxDecoration(
                image: DecorationImage(image: AssetImage('assets/images/sc_trans.png'), fit: BoxFit.fitHeight)
              ),
            ),

            const SizedBox(height: 28,),

            Text(
              sugarname,
              textAlign: TextAlign.center,
              style: GoogleFonts.josefinSans(
                fontSize: 21,
                fontWeight: FontWeight.w300,
                color: Styles.sugar
              ),
            ),

            const SizedBox(height: 7,),

            Container(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: SizedBox(
                height: 42,
                child: ElevatedButton(
                  onPressed: () {
                    authService.signOut().whenComplete(() {
                      nextScreenReplace(context, const LoginScreen());
                    },);
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
                    'Sign Out',
                    style:  GoogleFonts.josefinSans(
                      fontSize: 21,
                      fontWeight: FontWeight.w500,
                      color: Styles.cloud,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      backgroundColor: Styles.cloud,

      body: sugarJar(),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          popUpDialog(context);
        },

        elevation: 0,

        backgroundColor: Styles.aqua,
        child: Icon(
          LineIcons.plus,
          color: Styles.cloud,
        ),
      ),

    );
  }

  sugarJar() {
    return StreamBuilder(stream:  group, builder: (context, AsyncSnapshot snapshot) {
      if (snapshot.hasData) {
        if (snapshot.data['group'] != null) {
          if (snapshot.data['group'].length != 0) {
            return ListView.builder(
              itemCount: snapshot.data['group'].length,
              itemBuilder: (context, index) {
                return SugarJarView(
                  sugarname: snapshot.data['username'], 
                  sugarJarId: getId(snapshot.data['group'][index]), 
                  sugarJar: getName(snapshot.data['group'][index])
                );
              },
            );
          } else {
            return sugarNorConnected();
          }
        } else {
          return sugarNorConnected();
        }
      } else {
        return Center(child: CircularProgressIndicator(color: Styles.aqua,),);
      }
    },);
  }

  sugarNorConnected() {
    return const Text('No sugar jar');
  }

  popUpDialog(BuildContext context) {
    showDialog(barrierDismissible: false, context: context, builder: (context) {
      return AlertDialog(
          backgroundColor: Styles.sakura,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20))
          ),
          title: Text(
            'Find your sugar cube',
            style: GoogleFonts.josefinSans(

            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _isLoading == true ? Center(child: CircularProgressIndicator(color: Styles.aqua,),) : 
              TextField(
                textAlignVertical: TextAlignVertical.bottom,
                style: GoogleFonts.josefinSans(
                  color: Styles.sugar,
                  fontSize: 16,
                  fontWeight: FontWeight.w300,
                ),

                onChanged: (value) {
                  setState(() {
                    sugarjar = value;
                  });
                },

                cursorColor: Styles.aqua,
                cursorRadius: const Radius.circular(20),
                cursorWidth: 2,
                cursorHeight: 16,

                decoration: Styles.textInputDecoration.copyWith(
                  contentPadding: const EdgeInsets.only(bottom: 16, right: 20),
                  alignLabelWithHint: true,

                  hintText: "Sugar jar",
                  hintStyle: GoogleFonts.josefinSans(
                      fontSize: 16,
                      fontWeight: FontWeight.w300,
                      color: Styles.sugar,
                  ),
                  prefixIcon: Icon(
                    LineIcons.userCircle,
                    color: Styles.sugar,
                    size: 16,
                  ),
                  fillColor: Styles.cloud,
                  filled: true,
                ),
              ),

              const SizedBox(height: 3,),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async {
                    if (sugarjar != '') {
                      setState(() {
                        _isLoading = true;
                      });

                      DatabaseService(uid: FirebaseAuth.instance.currentUser!.uid).createGroup(sugarname, FirebaseAuth.instance.currentUser!.uid, sugarjar).whenComplete(() {
                        _isLoading = false;
                      },);

                      Navigator.of(context).pop();

                      showSnackBar(context, Styles.aqua, 'Group created successfully');
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Styles.cloud,
                    foregroundColor: Styles.cloud,
                    elevation: 0,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(50)),
                    )
                  ),
                  child: Text(
                    'Connect',
                    style:  GoogleFonts.josefinSans(
                      fontSize: 21,
                      fontWeight: FontWeight.w500,
                      color: Styles.sugar,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
    },);
  }
}