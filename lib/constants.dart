 import 'dart:ui';

import 'package:flutter/material.dart';

String wiki_pedia_api = "https://en.wikipedia.org//w/api.php?action=query&format=json&prop=pageimages%7Cpageterms&generator=prefixsearch&redirects=1&formatversion=2&piprop=thumbnail&pithumbsize=50&pilimit=10&wbptterms=description&gpssearch=%s+T&gpslimit=10";
String wiki_pedia_page = "https://en.wikipedia.org/wiki/%s";
const String searchhint = "Search on wikipedia";
const double h1=32;
const double h2=24;
const double h3=18.72;
const double h4 = 16;
const double h5 = 13.28;
const double h6 = 10.72;
const MaterialColor light_blue = MaterialColor(0xff00036c,const <int, Color>{
 50: const Color(0xff00036c),
 100: const Color(0xff00036c),
 200: const Color(0xff00036c),
 300: const Color(0xff00036c),
 400: const Color(0xff00036c),
 500: const Color(0xff00036c),
 600: const Color(0xff00036c),
 700: const Color(0xff00036c),
 800: const Color(0xff00036c),
 900: const Color(0xff00036c)
} )
 ;

