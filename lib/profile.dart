import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

import 'widgetrendered.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  List<dynamic>? _widgetsConfig;

  @override
  void initState() {
    super.initState();
    _loadConfig();
  }

  Future<void> _loadConfig() async {
    String jsonString = await rootBundle.loadString('assets/profile_ui.json');
    setState(() {
      _widgetsConfig = json.decode(jsonString)['widgets'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      appBar: AppBar(
        title: const Text('Profile'),
        backgroundColor: Colors.black,
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
