import 'package:flutter/material.dart';
import 'package:hive_crud_api_model/models/model.dart';
import 'package:hive_flutter/hive_flutter.dart';

class DarftPage extends StatefulWidget {
  const DarftPage({super.key});

  @override
  State<DarftPage> createState() => _DarftPageState();
}

class _DarftPageState extends State<DarftPage> {
  List<Model> myDarftList = [];

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      
      myDarftList = Hive.box<Model>('DarftData').values.toList().cast<Model>();
      setState(() {});
    });

    print(Hive.box<Model>('DarftData').values.toList());
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('DarftData'),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
              child: ListView.builder(
                  itemCount: myDarftList.length,
                  itemBuilder: (context, index) {
                    return Card(
                      child: ExpansionTile(
                        title: Text(myDarftList[index].title),
                        leading: SizedBox(
                            height: 71,
                            width: 71,
                            child: Card(
                                child: Image.network(
                              myDarftList[index].image,
                              fit: BoxFit.cover,
                            ))),
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  IconButton(onPressed: (){
                               
                           
                                      setState(() {
                                      deletRxMedicinItem(myDarftList[index].id);
                                        
                                      });
                                    
                             


                                  }, icon: Icon(Icons.delete)),
                                  IconButton(onPressed: (){
                                    Navigator.pop(context);
                                  }, icon: Icon(Icons.details)),
                                ],
                              )
                            ],
                      ),
                    );
                  }))
        ],
      ),
    );
  }
   deletRxMedicinItem(int id) {
    final box =Hive.box<Model>('DarftData');

    final Map<dynamic, Model> deliveriesMap = box.toMap();
    dynamic desiredKey;
    deliveriesMap.forEach((key, value) {
      if (value.id == id){
          
         desiredKey = key;
           
        
         }
    });
    
    box.delete(desiredKey);

    print(desiredKey);
      
    
  }
}
