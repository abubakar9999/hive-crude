import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:hive_crud_api_model/constant/api.dart';
import 'package:hive_crud_api_model/models/model.dart';
import 'package:hive_crud_api_model/pages/darft.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Model> data = [];
  Map<String, bool> isClick = {};
  int correntindex = 1;
  List<Model> tamplist = [];

  @override
  void initState() {
    getdata();
    // TODO: implement initState

    super.initState();
  }

  getdata() async {
    data = await Api().fatchData();
    setState(() {});

    data.forEach((element) {
      isClick[element.id.toString()] = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("This is Hive Crud"),
      ),
      body: data.isNotEmpty
          ? Column(
              children: <Widget>[
                Expanded(
                    child: ListView.builder(
                        itemCount: data.length,
                        itemBuilder: ((context, index) {
                          final istrue = isClick[data[index].id.toString()];
                          return Card(
                            color: istrue == true
                                ? Color.fromARGB(255, 165, 234, 241)
                                : Colors.white,
                            child: ListTile(
                              onTap: () {
                                isClick[data[index].id.toString()] = !istrue!;
                                if (istrue == true) {
                                  tamplist.add(data[index]);
                                  print("Added:$tamplist");
                                } else {
                                  tamplist.remove(data[index]);
                                }

                                setState(() {});
                              },
                              leading: SizedBox(
                                  height: 71,
                                  width: 71,
                                  child: Card(
                                      child: Image.network(
                                    data[index].image,
                                    fit: BoxFit.cover,
                                  ))),
                              title: Text(data[index].title),
                            ),
                          );
                        })))
              ],
            )
          : Center(child: CircularProgressIndicator()),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: correntindex,
        onTap: _ontatb,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(
                Icons.add_box,
              ),
              label: "SaveDarft"),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
              ),
              label: "Home"),
        ],
      ),
    );
  }

  _ontatb(var index) {
    if (index == 0) {
      print("Tis is index isssssssssssss::::$index");
      var box = Hive.box<Model>('DarftData');
      tamplist.forEach((element) {
        box.add(element);
        print('dadsafsdafsdafsdaf :::${element}');
        print('dadsafsdafsdafsdaf :::${tamplist}');
      });
      // Navigator.push(
      //     context, MaterialPageRoute(builder: (context) => DarftPage()));
    }

    setState(() {
      correntindex = index;
      print(index);
    });
  }
}
