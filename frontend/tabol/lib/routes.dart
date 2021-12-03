import 'dart:js';

import 'package:flutter/material.dart';
import 'package:tabol/main.dart';
import 'package:tabol/customer/tenant_detail.dart';
import 'package:tabol/undefined.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name){
    case '/':
      return MaterialPageRoute(builder: (context) => CustomerHomePage(title: 'TABOL'));
    case '/tenant/detail/':
      final args = settings.arguments;
      if(args is int){
        return MaterialPageRoute(builder: (context) => TenantDetail(id: args));
      }else{
        print(args);
        return MaterialPageRoute(builder: (context) => UndefinedView(name: 'TABOL'));
      }
    default:
      return MaterialPageRoute(builder: (context) => UndefinedView(name: 'TABOL'));
  }
}