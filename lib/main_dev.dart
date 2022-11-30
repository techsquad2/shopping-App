import 'dart:async';
import 'dart:convert';

//import 'dart:math';
import 'package:flutter/material.dart';
//import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "My products",
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const Homepage(),
    );
  }
}

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);
  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  List<Product> productList = [];
  Future<List<Product>> getProduct() async {
    final response =
        await http.get(Uri.parse("https://fakestoreapi.com/products"));

    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      for (Map i in data) {
        Product product = Product(
            title: i['title'],
            id: i['id'],
            
            description: i['description'],
            category: i['category'],
            image: i['image']);
        productList.add(product);
      }
      return productList;
    } else {
      return productList;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('search'),
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
                future: getProduct(),
                builder: (context, AsyncSnapshot<List<Product>> snapshot) {
                  return ListView.builder(
                      itemCount: productList.length,
                      itemBuilder: (context, index) {
                        return Card(
                          child: ListTile(
                         leading :Container(child: Image.network(
                              snapshot.data![index].image.toString()),
                              width: 100,
                              height: 100,
                              padding: EdgeInsets.symmetric(),
                              
                              decoration: BoxDecoration(
                              
                              border: Border.all(
                              width:2,
                              color: Colors.grey),
                              
                                
                                  
                                  
                                  
                             
                            


                              ),),
                          
                         subtitle : Text(snapshot.data![index].description.toString()),
                         title: Text(snapshot.data![index].title.toString(),
                         textScaleFactor: 1.0,
                         style: TextStyle(
                          color: Colors.indigo,
                          fontWeight: FontWeight.w300,)

                         ),

                         
                        ));
                      });
                }),
          ),
        ],
      ),
    );
  }
}

class Product {
  int? id;
  String? title;
  
  String? description;
  String? category;
  String? image;
  Product({this.id, this.title, this.description, this.category, this.image});
  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
        title: json['title'].toString(),
        description: json['description'],
        category: json['category'].toString(),
        image: json['image'].toString());
  }
}
