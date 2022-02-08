import 'dart:html' as html;

import 'package:flutter/material.dart';

void changeTheme(String theme) {
  ThemeData.dark();
  final primaryColor = theme == 'dark' ? '#212121' : '#2196f3';
  final backgroundColor = theme == 'dark' ? '#303030' : '#fafafa';
  _setMeta('theme-color', primaryColor);
  _setMeta('msapplication-navbutton-color', primaryColor);
  html.document.body?.style.backgroundColor = backgroundColor;
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
