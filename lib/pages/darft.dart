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
    );
  }
}
