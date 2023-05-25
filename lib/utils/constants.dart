import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final txtFieldDecoration = InputDecoration(
  errorStyle: GoogleFonts.lato(
      fontSize: 18, color: Colors.red.shade700, fontWeight: FontWeight.bold),
  focusedErrorBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.red.shade600, width: 2),
  ),
  errorBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.red.shade600, width: 2),
  ),
  labelStyle: GoogleFonts.lato(
      fontSize: 18, color: Colors.black, fontWeight: FontWeight.w500),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.grey.shade300),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.grey.shade300),
  ),
);

var token = '';
var onboard = false;
var name = '';
