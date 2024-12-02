import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

import 'widgetrendered.dart';

class DynamicUI extends StatefulWidget {
  @override
  _DynamicUIState createState() => _DynamicUIState();
}

class _DynamicUIState extends State<DynamicUI> {
  List<dynamic>? _widgetsConfig;

  @override
  void initState() {
    super.initState();
    _loadConfig();
  }

  Future<void> _loadConfig() async {
    String jsonString = await rootBundle.loadString('assets/ui_config.json');
    setState(() {
      _widgetsConfig = json.decode(jsonString)['widgets'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        title: const Text('Dynamic UI'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: IconButton(
              icon: const CircleAvatar(
                backgroundImage: NetworkImage(
                  'https://i.pinimg.com/originals/83/10/ab/8310ab709f70727b92fa1a6917897c82.jpg', 
                ),
              ),
              onPressed: () {
              Navigator.pushNamed(context, '/profile');
              },
            ),
          ),
        ],
      
        
        ),
      body: _widgetsConfig == null
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Column(
                children: _widgetsConfig!
                    .map((config) => DynamicWidgetBuilder.buildWidget(config))
                    .toList(),
              ),
            ),
    );
  }
}
