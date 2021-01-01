
import 'dart:collection';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:interview_demo/Daos/PageDetails.dart';
import 'custom_widget.dart';
import 'package:http/http.dart' as http;
import 'constants.dart';
import 'package:sprintf/sprintf.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Wikipedia Search",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch:light_blue
      ),
      home: MyHomePage(title: "Wikipedia"),
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
  int _counter = 0;
  bool search = false;
  TextEditingController etSearchController = new TextEditingController();
  void _incrementCounter() {
    setState(() {

      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        title: Text(widget.title),
      ),
      body:
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            search_widget(),
           SizedBox(
             height: MediaQuery.of(context).size.height/50,
           ),

           // Search Result Layout

           search ?   search_result_widget():Container()
          ],
        ),
      )
    //   floatingActionButton: FloatingActionButton(
    //     onPressed: _incrementCounter,
    //     tooltip: 'Increment',
    //     child: Icon(Icons.add),
    //   ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

 Future<List<PageDetails>> getPageDetails(url)  async{
   var response =  await http.get(url);
  List<PageDetails> listPageDetails;
   var pageDetails =  json.decode(response.body);
   Map pages =        pageDetails['query'];
   List<dynamic> list=   pages['pages'];
try {
   listPageDetails = list.map((e) =>
  e != null ? PageDetails.fromJson(e) : PageDetails()).toList();
  return listPageDetails;
}
catch(error){
  return listPageDetails;
}

  }

  // Search widget Tree

  Widget search_widget(){
    return Container(
      decoration:BoxDecoration(
          border:Border.all(color: Colors.black,width: 1.0,style: BorderStyle.solid)
      ),
      padding: EdgeInsets.all(2),
      child:
      // Search Layout
      Row(
        children: [
          Expanded(
            flex: 18,
            child: TextField(
              textInputAction: TextInputAction.search,
              onSubmitted: (value) {
                print("search");
                setState(() {
                  search = true;
                });
              },
              decoration: InputDecoration(
                  hintText: searchhint,
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  border: InputBorder.none,
                  hintStyle: TextStyle(fontSize: h3* MediaQuery.textScaleFactorOf(context))
              ),
              style: TextStyle(
                  fontSize: h3* MediaQuery.textScaleFactorOf(context)
              ),
              controller: etSearchController,
            ),
          ),
          Expanded(
            flex: 3,
            child: Container(
              height: MediaQuery.of(context).size.height/16.5,
              decoration: BoxDecoration(
                color: light_blue
              ),
              child: InkWell(
                  onTap:() {
                    setState(() {
                      search= true;
                    });
                  },
                  child: Icon(Icons.search,color: Colors.white,size: 30,)),
            ),
          )
        ],
      ),
    );
  }

  Widget custom_widget_list_builder(List<PageDetails> data) {
   return
     ListView.builder(
     itemCount: data.length,
     itemBuilder:(context,index){
       return list_item_builder(data[index]);
       } ,
   );
  }



  Widget list_item_builder(PageDetails data) {
    return SearchItems(data);

  }

  // Search Widget

  search_result_widget() {
    return FutureBuilder<List<PageDetails>>(
      future: getPageDetails(wiki_pedia_api.replaceAll("%s", etSearchController.text)),
      builder: (context,snapdata){
        if(snapdata.hasData) {
          return Expanded(child: custom_widget_list_builder(snapdata.data));
        }
        else{
          return CircularProgressIndicator(

          );
        }
      },
    );
  }
}


