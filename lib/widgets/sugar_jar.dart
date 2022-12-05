import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sugar_cubes/screens/chat_screen.dart';
import 'package:sugar_cubes/shared/app_styles.dart';
import 'package:sugar_cubes/widgets/widgets.dart';

class SugarJarView extends StatefulWidget {
  final String sugarname;
  final String sugarJarId;
  final String sugarJar;

  const SugarJarView({required this.sugarname, required this.sugarJarId, required this.sugarJar, super.key});

  @override
  State<SugarJarView> createState() => _SugarJarViewState();
}

class _SugarJarViewState extends State<SugarJarView> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        nextScreen(context, ChatScreen(
          sugarname: widget.sugarname, 
          sugarJarId: widget.sugarJarId, 
          sugarJar: widget.sugarJar
        ));
      },
      child: ListTile(
        title: Text(
          widget.sugarJarId,
          style: GoogleFonts.josefinSans(
            fontSize: 16,
            color: Styles.sugar
          ),
        ),
          subtitle: Text(
          widget.sugarJar,
          style: GoogleFonts.josefinSans(
            fontSize: 14,
            color: Styles.sugar
          ),
        ),
      )
    );
  }
}