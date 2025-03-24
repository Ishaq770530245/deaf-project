
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'dart:math';

class SignLanguageController extends GetxController {


  var isresetPassord = false;
  // Observables
  var isProcessing = false.obs;
  var detectedSign = "No Sign Detected".obs;





  Rx<TextStyle> selectedFont = GoogleFonts.roboto().obs;

  Rx<Color> selectedColor = Colors.black.obs;

  // Function to update the font color
  void changeColor(Color color) {
    
    selectedColor.value = color;
    selectedColor.refresh();
    selectedFont.value = selectedFont.value.copyWith(color: selectedColor.value);
  }

  // Update the selected font based on user selection
  void changeFont(String fontName) {
    switch (fontName) {
      case 'Roboto':
        selectedFont.value = GoogleFonts.roboto(color: selectedColor.value);
        break;
      case 'Montserrat':
        selectedFont.value = GoogleFonts.montserrat(color:  selectedColor.value);
        break;
      case 'OpenSans':
        selectedFont.value = GoogleFonts.openSans(color:  selectedColor.value);
        break;
      default:
        selectedFont.value = GoogleFonts.roboto(color:  selectedColor.value);
    }
  }






}
