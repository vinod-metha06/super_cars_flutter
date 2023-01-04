import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:super_cars_/Service/service.dart';

class WishList extends StatefulWidget {
  const WishList({super.key});

  @override
  State<WishList> createState() => _WishListState();
}

class _WishListState extends State<WishList> {
  Service _service = Service();
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 1,
      child: StreamBuilder<QuerySnapshot>(
          stream: _service.wishlistCarStream,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return const Text('Something went wrong');
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Text("ooooo");
            }
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: ((context, index) {
                var data = snapshot.data!.docs;
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
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
                            leading: Image.network(data[index]["image"]),
                            title: Text(
                              data[index]["name"],
                              style: const TextStyle(
                                  fontSize: 18, color: Colors.black),
                            ),
                            subtitle: Text(
                              "\$" + data[index]["price"].toString(),
                              style: const TextStyle(
                                  fontSize: 18, color: Colors.black),
                            ),
                            trailing: IconButton(
                              icon: Icon(
                                Icons.delete,
                                color: Colors.red,
                              ),
                              onPressed: () async {
                                await _service.deleteWish(
                                    data[index]["id"], context);
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }),
            );
          }),
    );
  }
}
