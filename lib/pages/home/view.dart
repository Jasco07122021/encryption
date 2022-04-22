import 'package:encryption/pages/home/provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void dispose() {
    // TODO: implement dispose
    HomeProvider().textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => HomeProvider(),
      builder: (context, child) => _buildPage(context),
    );
  }

  Widget _buildPage(BuildContext context) {
    final provider = context.watch<HomeProvider>();

    return Scaffold(
      appBar: AppBar(),
      body: Stack(
        children: [
          if (provider.isLoading) const LinearProgressIndicator(),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("result : " + provider.checkResponse),
              const SizedBox(height: 50),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: TextField(
                  controller: provider.textController,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  MaterialButton(
                    onPressed: () {
                      provider.encryptionPK();
                    },
                    child: Text("Send"),
                    color: Colors.blue,
                  ),
                  SizedBox(width: 20),
                  MaterialButton(
                    onPressed: () {
                      provider.clearResult();
                    },
                    child: Text("Delete"),
                    color: Colors.red,
                  ),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
