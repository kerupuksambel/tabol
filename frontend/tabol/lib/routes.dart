import 'dart:js';

import 'package:flutter/material.dart';
import 'package:tabol/main.dart';
import 'package:tabol/customer/tenant_service.dart';
import 'package:tabol/customer/tenant_detail.dart';
import 'package:tabol/customer/tenant_order.dart';
import 'package:tabol/customer/order_list.dart';
import 'package:tabol/model/service.dart';
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
        return MaterialPageRoute(builder: (context) => UndefinedView(err: 'Parameter invalid.'));
      }
    case '/tenant/service/':
      final args = settings.arguments;
      if(args is int){
        return MaterialPageRoute(builder: (context) => TenantService(id: args));
      }else{
        print(args);
        return MaterialPageRoute(builder: (context) => UndefinedView(err: 'Parameter invalid.'));
      }
    case '/tenant/order/':
      final args = settings.arguments;
      
      if(args is Service){
        return MaterialPageRoute(builder: (context) => TenantOrder(service: args));
      }else{
        print(args);
        return MaterialPageRoute(builder: (context) => UndefinedView(err: 'Parameter invalid.'));
      }
    case '/order/list/':
        return MaterialPageRoute(builder: (context) => OrderList());
    default:
      return MaterialPageRoute(builder: (context) => UndefinedView(err: 'Halaman tidak ditemukan.'));
  }
}