import 'package:flutter/material.dart';

class SugarMessage extends StatefulWidget {
  final String message;
  final String sender;
  final bool sendByMe;

  const SugarMessage({required this.message, required this.sender, required this.sendByMe, super.key});

  @override
  State<SugarMessage> createState() => _SugarMessageState();
}

class _SugarMessageState extends State<SugarMessage> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}