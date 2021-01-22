import 'dart:ui';

import 'package:flutter/material.dart';

class Globals {
  static const PRIMARY_COLOR = Color.fromRGBO(23, 50, 77, 1);

  static const Map<int, Color> PRIMARY_COLOR_SWATCH = {
    50: Color.fromRGBO(23, 50, 77, .1),
    100: Color.fromRGBO(23, 50, 77, .2),
    200: Color.fromRGBO(23, 50, 77, .3),
    300: Color.fromRGBO(23, 50, 77, .4),
    400: Color.fromRGBO(23, 50, 77, .5),
    500: Color.fromRGBO(23, 50, 77, .6),
    600: Color.fromRGBO(23, 50, 77, .7),
    700: Color.fromRGBO(23, 50, 77, .8),
    800: Color.fromRGBO(23, 50, 77, .9),
    900: Color.fromRGBO(23, 50, 77, 1)
  };
  static const PRIMARY_COLOR_MATERIAL =
      MaterialColor(0xff17324d, PRIMARY_COLOR_SWATCH);

  static String getAreaName(String area) {
    switch (area) {
      case 'ITA':
        return "Italy";
      case 'ABR':
        return "Abruzzo";
      case 'BAS':
        return "Basilicata";
      case 'CAL':
        return "Calabria";
      case 'CAM':
        return "Campania";
      case 'EMR':
        return "Emilia-Romagna";
      case 'FVG':
        return "Friuli Venezia Giulia";
      case 'LAZ':
        return "Lazio";
      case 'LIG':
        return "Liguria";
      case 'LOM':
        return "Lombardia";
      case 'MAR':
        return "Marche";
      case 'MOL':
        return "Molise";
      case 'PAB':
        return "P.A. Bolzano";
      case 'PAT':
        return "P.A. Trento";
      case 'PIE':
        return "Piemonte";
      case 'PUG':
        return "Puglia";
      case 'SAR':
        return "Sardegna";
      case 'SIC':
        return "Sicilia";
      case 'TOS':
        return "Toscana";
      case 'UMB':
        return "Umbria";
      case 'VDA':
        return "Valle d'Aosta";
      case 'VEN':
        return "Veneto";
      default:
        return area;
    }
  }
}
