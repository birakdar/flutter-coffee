import 'package:coffee/screens/home/coffee_tile.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:coffee/models/coffee.dart';


class CoffeeList extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return new _CoffeeList();
  }
}


class _CoffeeList extends State<CoffeeList>{


  @override
  Widget build(BuildContext context) {
    final coffee = Provider.of<List<Coffee>>(context) ?? [];

    return ListView.builder(
        itemCount: coffee.length,
        itemBuilder: (context, index){
          return CoffeeTile(coffee: coffee[index]);
        }
    );
  }

}
