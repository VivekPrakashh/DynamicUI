import 'dart:convert';

import 'package:demoproject/WidgetRendered.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class LoginUI extends StatefulWidget {
  const LoginUI({super.key});

  @override
  State<LoginUI> createState() => _LoginUIState();
}

class _LoginUIState extends State<LoginUI> {
  List<dynamic>? _widgetsConfig;

  @override
  void initState() {
    super.initState();
    _loadConfig();
  }

  Future<void> _loadConfig() async {
    String jsonString = await rootBundle.loadString('assets/login_ui.json');
    setState(() {
      _widgetsConfig = json.decode(jsonString)['widgets'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      appBar: AppBar(
        title: const Text('Login UI'),
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
