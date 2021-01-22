import 'package:flutter/material.dart';
import 'package:product/product.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var _formKey = GlobalKey<FormState>();
  var _idController = new TextEditingController(text: "");
  var _nameController = new TextEditingController(text: "");
  List<Product> _products = [];
  Product _product = new Product();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: _idController,
                  decoration: InputDecoration(hintText: "Enter id"),
                  onSaved: (value) => _product.id = int.parse(value),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: _nameController,
                  decoration: InputDecoration(hintText: "Enter Name"),
                  onSaved: (value) => _product.name = value,
                ),
              ),
              RaisedButton(
                onPressed: () {
                  _formKey.currentState.save();
                  _products.add(_product);
                  _product = new Product();
                  _idController.clear();
                  _nameController.clear();
                  setState(() {});
                },
                child: Text("Submit"),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 20,
                    bottom: 5,
                    right: 20,
                  ),
                  child: ListView.separated(
                    itemCount: _products.length,
                    separatorBuilder: (context, index) => Divider(),
                    itemBuilder: (context, i) {
                      return Container(
                        color: Colors.grey,
                        padding: EdgeInsets.all(8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            InkWell(
                                child: Text(_products[i].name),
                                onTap: () {
                                  _idController.text =
                                      _products[i].id.toString();
                                  _nameController.text = _products[i].name;
                                  _products.removeWhere(
                                      (p) => p.id == _products[i].id);
                                  setState(() {});
                                }),
                            IconButton(
                              icon: Icon(
                                Icons.delete,
                                color: Colors.red,
                              ),
                              onPressed: () {
                                _products.removeWhere(
                                    (p) => p.id == _products[i].id);
                                setState(() {});
                              },
                            )
                          ],
                        ),
                      );
                    },
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
