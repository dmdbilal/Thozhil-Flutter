import 'package:flutter/material.dart';
import 'package:thozhil_flutter_app/screens/drawer.dart';

class InternshipsScreen extends StatefulWidget {
  const InternshipsScreen({super.key});

  @override
  State<InternshipsScreen> createState() => _InternshipsScreenState();
}

class _InternshipsScreenState extends State<InternshipsScreen> {
  @override
  Widget build(BuildContext context) {
    var assetsImage = const AssetImage('assets/thozhil_logo.png');
    var image = Image(image: assetsImage, fit: BoxFit.cover, height: 30);

    return Scaffold(
        appBar: AppBar(
          leading: Builder(
            builder: (context) {
              return IconButton(
                  onPressed: () {
                    Scaffold.of(context).openDrawer();
                  },
                  icon: const Icon(Icons.menu, color: Colors.blue, size: 35)
              );
            },
          ),
          title: Container(
            color: Colors.white,
            child: Center(
              child: image,
            ),
          ),
          centerTitle: true,
          backgroundColor: Colors.white,
          elevation: 0,
          actions: [
            IconButton(
                onPressed: (){},
                icon: const Icon(Icons.notifications, color: Colors.blue, size: 30)
            )
          ],
        ),
        drawer: getDrawer(context, 3),
        backgroundColor: Colors.white,
        body: Text("Internships Screen")
    );
  }
}
