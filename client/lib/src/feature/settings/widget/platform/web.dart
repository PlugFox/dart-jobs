import 'dart:html' as html;

import 'package:flutter/material.dart';

void changeTheme(String theme) {
  ThemeData.dark();
  final color = theme == 'dark' ? '#212121' : '#2196F3';
  _setMeta('theme-color', color);
  _setMeta('msapplication-navbutton-color', color);
  html.document.body?.style.backgroundColor = color;
}

void _setMeta(String key, String value) {
  final element = html.document.querySelector('meta[name="$key"]');
  if (element == null) {
    html.document.head?.append(
      html.MetaElement()
        ..name = key
        ..content = value,
    );
  } else {
    element.setAttribute('content', value);
  }
}
