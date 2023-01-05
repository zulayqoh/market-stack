import 'package:flutter/material.dart';
import 'package:market_stack/dio_network/dio_client.dart';

import 'company_model.dart';

// //
// Future<void> main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   List<Company> companies = await DioClient().getData();
//   runApp(const MyApp());
// }

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isLoading = false;
  late List<Company> companies;
  TextEditingController searchSymbol = TextEditingController();

  void returnData() async {
    isLoading = true;
    companies = await DioClient().getData(searchSymbol.text);
    isLoading = false;
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    WidgetsFlutterBinding.ensureInitialized();
    returnData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(onPressed: (){showSearch(context: context, delegate: MySearchDelegate());}, icon: Icon(Icons.search))
        ],
        // leading: Row(
        //   children: [
        //     Icon(Icons.search),
        //     TextField(controller: searchSymbol,),
        //   ],
        // ),
        title: const Center(
          child: Text('Market Stack..'),
        ),
      ),
      backgroundColor: Colors.white,
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Column(
            children: [
              Container(
                margin: EdgeInsets.all(16),
                child: TextField(
                  controller: searchSymbol,
                  decoration: InputDecoration(
                    prefixIcon: IconButton(icon: Icon(Icons.search), onPressed: () {  },),
                        hintText: 'Search',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(color: Colors.brown)
                    )
                  ),
                ),
              ),
              ListView.builder(
                  itemCount: companies.length,
                  itemBuilder: (context, index) {
                    Company company = companies[index];
                    return ListTile(
                      title: Text(company.name),
                      subtitle: Text(company.symbol),
                    );
                  },
                ),
            ],
          ),
    );
  }
  void searchField(String query){}
}



class MySearchDelegate extends SearchDelegate {
  @override
  List<Widget>? buildActions(BuildContext context) {
    // TODO: implement buildActions
    throw UnimplementedError();
  }

  @override
  Widget? buildLeading(BuildContext context) {
    // TODO: implement buildLeading
    throw UnimplementedError();
  }

  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults
    throw UnimplementedError();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // TODO: implement buildSuggestions
    throw UnimplementedError();
  }
}

