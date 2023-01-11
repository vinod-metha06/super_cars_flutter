import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:super_cars_/Service/service.dart';

class DetailsPage extends StatefulWidget {
  DetailsPage({super.key, @required this.data});
  var data;

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  bool flag = true;
  Service _service = Service();
  @override
  Widget build(BuildContext context) {
    var text = widget.data["about"];
    return Scaffold(
      appBar: AppBar(
        actions: const [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(Icons.shopping_cart),
          )
        ],
      ),
      body: Column(
        children: [
          Container(
            // color: Colors.red,
            height: MediaQuery.of(context).size.height * 0.8,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(40.0),
                    child: Image.network(
                      widget.data["image"].toString(),
                      height: MediaQuery.of(context).size.height * 0.3,
                      width: MediaQuery.of(context).size.width * 0.8,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                widget.data["type"],
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w300),
                              ),
                            ),
                            Text(
                              widget.data["name"],
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                  fontSize: 22, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        GestureDetector(
                          onTap: (() async {
                            _service.addWishlist(
                                widget.data["name"],
                                widget.data["image"],
                                widget.data["price"].toString(),
                                widget.data["id"],
                                context);
                          }),
                          child: Container(
                            padding: EdgeInsets.all(8.0),
                            decoration: BoxDecoration(
                              color: Colors.amber,
                              borderRadius: BorderRadius.circular(40),
                            ),
                            child: const Icon(EvaIcons.heart),
                          ),
                        )
                      ],
                    ),
                  ),
                  text.length > 200
                      ? Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              flag
                                  ? Text(
                                      text.toString().substring(0, 200) + "...",
                                      textAlign: TextAlign.justify,
                                      style: TextStyle())
                                  : Text(
                                      text,
                                      textAlign: TextAlign.justify,
                                    ),
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    InkWell(
                                      onTap: (() => setState(() {
                                            flag = !flag;
                                          })),
                                      child: flag
                                          ? const Text(
                                              "more...",
                                              style: TextStyle(
                                                color: Colors.blue,
                                                fontSize: 16,
                                                fontWeight: FontWeight.w300,
                                              ),
                                            )
                                          : const Text(
                                              "less...",
                                              style: TextStyle(
                                                color: Colors.blue,
                                                fontSize: 16,
                                                fontWeight: FontWeight.w300,
                                              ),
                                            ),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        )
                      : Text(text),
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        "Specs",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        widget.data["specs"],
                        textAlign: TextAlign.justify,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: () async {
              _service.addToCart(widget.data["name"], widget.data["image"],
                  widget.data["price"].toString(), widget.data["id"], context);
            },
            child: Container(
              color: Colors.white10,
              height: MediaQuery.of(context).size.height * 0.08,
              child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                Container(
                  height: 80,
                  padding: EdgeInsets.all(12),
                  width: MediaQuery.of(context).size.width * 0.5,
                  decoration: const BoxDecoration(
                    color: Colors.amber,
                    borderRadius:
                        BorderRadius.only(topLeft: Radius.circular(80)),
                  ),
                  child: Text(
                    "\$" + widget.data["price"].toString(),
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                ),
              ]),
            ),
          ),
        ],
      ),
    );
  }
}
