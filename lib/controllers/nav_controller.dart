import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class NavController extends GetxController {

  final _selectedIndex = 0.obs;
  get selectedindex => this._selectedIndex.value;
  set selectedindex (index) => this._selectedIndex.value = index;
}
