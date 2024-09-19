import 'dart:convert';

import 'package:flutter/material.dart';

import 'widgets/list_of_items.dart';
import 'package:http/http.dart' as http;


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
 List<dynamic>data =[];
@override
  void initState() {
    
    super.initState();
    getData();
  }
  
void getData()async {
final Uri uri= Uri.parse('https://fakestoreapi.com/products');
final res=await http.get(uri);
if(res.statusCode==200)
{
  final List<dynamic> list=json.decode(res.body);
  setState(() {
    data=list;
  });
  
}
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
      title: const Text('Home '),
    ),
    body:data.isEmpty? const Center(child: CircularProgressIndicator(),):  ListOfItems(data),

);
  }
}
// 