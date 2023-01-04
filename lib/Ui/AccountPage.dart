import 'package:flutter/material.dart';

class Account extends StatefulWidget {
  const Account({super.key});

  @override
  State<Account> createState() => _AccountState();
}

class _AccountState extends State<Account> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
          child: ListView(
        padding: const EdgeInsets.all(8.0),
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        children: [
          Container(
            width: width,
            height: height * 0.3,
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(40.0),
            ),
            child: Column(children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.network(
                  "https://www.seekpng.com/png/full/250-2500018_car-white-background-pics-car-image-png-hd.png",
                  height: 150.0,
                  width: 100.0,
                ),
              ),
              Text(
                "Vinod Metha",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Vinod Metha",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              Card(
                color: Colors.grey[100],
                shape: RoundedRectangleBorder(
                  side: BorderSide(color: Colors.white70, width: 1),
                  borderRadius: BorderRadius.circular(40),
                ),
                //  margin: EdgeInsets.all(20.0),
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.9,
                  height: 100,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      ListTile(
                        leading:const Icon(
                            Icons.logout,
                            color: Colors.red,
                          ),
                        title:const Text(
                          "hhh",
                          style: const TextStyle(
                              fontSize: 18, color: Colors.black),
                        ),
                        trailing: IconButton(
                          icon: Icon(
                            Icons.delete,
                            color: Colors.red,
                          ),
                          onPressed: () {},
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ]),
          ),
        ],
      )),
    );
  }
}
