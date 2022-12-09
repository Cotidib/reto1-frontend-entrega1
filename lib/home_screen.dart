import 'dart:convert' as cnv;
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'data_model.dart';


class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  late Future<List<DataModel>> dataModels;
  late Future<DataModel> oneDataModel;
  
  @override
  void initState() {
    dataModels = fetchData();
    oneDataModel = fetchOneData();
    //print(dataModels);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Fetch Demo")),
      body: Center(
          child: FutureBuilder<List<DataModel>>(
            future: dataModels,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView.separated(
                  padding: const EdgeInsets.all(8),
                  itemCount: snapshot.data!.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Card(
                      child: Padding(
                        padding: EdgeInsets.all(25.0),
                        child: Center(
                          child: Column(
                            children: <Widget>[
                              snapshot.data![index].id == "" ? Text("[No Id]") : Text('${snapshot.data![index].id}'),
                              snapshot.data![index].title == "" ? Text("[No Title]") :Text('Title: ${snapshot.data![index].title}'),
                              snapshot.data![index].img == "" ? Text("[No Image]") : Image.network(snapshot.data![index].img,fit:BoxFit.fitWidth),
                              snapshot.data![index].desc == "" ? Text("[No Description]") : Text('${snapshot.data![index].desc}'),
                            ],
                          )
                        ),
                      )
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) => const Divider(),
                );
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }

              // By default, show a loading spinner.
              return const CircularProgressIndicator();
            },
          ),
        )
    );
  }
}

Future<List<DataModel>> fetchData() async {
  final response = await http
      .get(Uri.parse('https://www.reddit.com/search.json?q=ocean&type=sr'));

  if(response.statusCode == 200){
    List<DataModel> dataModelsAux = [];
    List<dynamic> childrens = cnv.jsonDecode(response.body)['data']['children'];
    childrens.forEach((item) {
      DataModel dataModel = DataModel.fromJson(item["data"]);
      dataModelsAux.add(dataModel);
    });

    return dataModelsAux;

  } else {
    throw Exception('Failed to load data');
  }
}

Future<DataModel> fetchOneData() async {
  final response = await http
      .get(Uri.parse('https://www.reddit.com/search.json?q=ocean&type=sr'));

  if(response.statusCode == 200){
    var children = cnv.jsonDecode(response.body)['data']['children'][0];
    DataModel dataModel = DataModel.fromJson(children["data"]);
    //print(children);
    return dataModel;

  } else {
    throw Exception('Failed to load data');
  }
}