import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:super_cars_/Screens/CarDetails.dart';
import 'package:super_cars_/Service/service.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int _focusedIndex = 0;
  Service _service = Service();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 5, vsync: this);
  }

  void _onItemFocus(int index) {
    setState(() {
      _focusedIndex = index;
    });
  }

  Widget _buildListItem(BuildContext context, int index) {
    //horizontal
    return Container(
      width: 200,
      color: Colors.lightBlueAccent,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            height: 100,
            width: 25,
            color: Colors.lightBlueAccent,
            child: Text("ijnhbhjb"),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    int _current = 0;
    return SizedBox(
      height: MediaQuery.of(context).size.height * 1,
      child: Column(
        children: [
          Container(
            margin:
                const EdgeInsets.only(left: 0, right: 0, top: 14, bottom: 4),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  height: 50,
                  width: MediaQuery.of(context).size.width * 0.7,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(40),
                      border: Border.all(
                        width: 2,
                        color: Colors.pink,
                      )),
                  child: const TextField(
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(8),
                        border: InputBorder.none,
                        suffixIcon: Icon(Icons.search)),
                  ),
                ),
                Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Colors.yellow,
                  ),
                  child: const Icon(
                    EvaIcons.options,
                    color: Colors.black,
                  ),
                )
              ],
            ),
          ),
          TabBar(
            isScrollable: true,
            controller: _tabController,
            tabs: const <Widget>[
              Tab(
                child: Text(
                  "All",
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
              ),
              Tab(
                child: Text(
                  "Economy",
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
              ),
              Tab(
                child: Text(
                  "Luxury",
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
              ),
              Tab(
                child: Text(
                  "Suv",
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
              ),
              Tab(
                child: Text(
                  "Sports",
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
              ),
            ],
          ),
          Expanded(
            child: TabBarView(controller: _tabController, children: [
              ListView(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                children: [
                  Container(
                    color: Colors.blue,
                    height: 200,
                    child: Text("hj"),
                  ),
                  Container(
                    color: Colors.blue,
                    height: 700,
                    child: Text("hj"),
                  )
                ],
              ),
              ListView(children: [
                SizedBox(
                  height: 300,
                  child: CarouselSlider.builder(
                    options: CarouselOptions(
                      height: 280,
                      pageSnapping: true,
                      aspectRatio: 16 / 9,
                      viewportFraction: 0.7,
                      initialPage: 0,
                      enableInfiniteScroll: false,
                      reverse: false,
                      autoPlay: false,
                      autoPlayInterval: const Duration(seconds: 3),
                      autoPlayAnimationDuration:
                          const Duration(milliseconds: 800),
                      autoPlayCurve: Curves.fastOutSlowIn,
                      enlargeCenterPage: true,
                      enlargeFactor: 0.3,
                      scrollDirection: Axis.horizontal,
                      onPageChanged: (index, C) {
                        setState(() {
                          _current = index;
                          print(_current);
                        });
                      },
                    ),
                    itemCount: 5,
                    itemBuilder: (context, index, realIndex) {
                      return Container(
                        width: MediaQuery.of(context).size.width,
                        padding: const EdgeInsets.all(12.0),
                        margin: const EdgeInsets.symmetric(horizontal: 5.0),
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(40),
                        ),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Container(
                                    decoration: BoxDecoration(
                                        color: Colors.amber,
                                        borderRadius:
                                            BorderRadius.circular(40)),
                                    child: const Icon(Icons.add))
                              ],
                            ),
                            // Container(
                            //   height: 160,
                            //   width: 200,
                            //   decoration: BoxDecoration(
                            //     color: Colors.amber,
                            //     borderRadius: BorderRadius.circular(40),
                            //   ),
                            // ),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8.0),
                              child: Image.network(
                                'https://www.seekpng.com/png/full/250-2500018_car-white-background-pics-car-image-png-hd.png',
                                height: 150.0,
                                width: 100.0,
                              ),
                            ),
                            const Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text("BWM"),
                            )
                          ],
                        ),
                      );
                    },
                    // items: [1, 2, 3, 4, 5].map((i) {
                    //   return Builder(
                    //     builder: (BuildContext context) {
                    //       return Container(
                    //         width: MediaQuery.of(context).size.width,
                    //         padding: const EdgeInsets.all(12.0),
                    //         margin: const EdgeInsets.symmetric(horizontal: 5.0),
                    //         decoration: BoxDecoration(
                    //           color: Colors.grey[200],
                    //           borderRadius: BorderRadius.circular(40),
                    //         ),
                    //         child: Column(
                    //           children: [
                    //             Row(
                    //               mainAxisAlignment: MainAxisAlignment.end,
                    //               children: [
                    //                 Container(
                    //                     decoration: BoxDecoration(
                    //                         color: Colors.amber,
                    //                         borderRadius:
                    //                             BorderRadius.circular(40)),
                    //                     child: const Icon(Icons.add))
                    //               ],
                    //             ),
                    //             Container(
                    //               height: 180,
                    //               width: 200,
                    //               decoration: BoxDecoration(
                    //                 color: Colors.amber,
                    //                 borderRadius: BorderRadius.circular(40),
                    //               ),
                    //             ),
                    //             Text("BWM")
                    //           ],
                    //         ),
                    //       );
                    //     },
                    //   );
                    // }).toList(),
                  ),
                ),
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Text(
                            "Top",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          Icon(Icons.more_horiz)
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 160,
                      child: StreamBuilder<QuerySnapshot>(
                          stream: _service.luxuryCarStream,
                          builder: (context, snapshot) {
                            if (snapshot.hasError) {
                              return const Text('Something went wrong');
                            }

                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const Text("Loading");
                            }
                            var data = snapshot.data!.docs;
                            return ListView.separated(
                                separatorBuilder: (context, index) =>
                                    const SizedBox(
                                      width: 10,
                                    ),
                                scrollDirection: Axis.horizontal,
                                shrinkWrap: true,
                                itemCount: snapshot.data!.docs.length,
                                itemBuilder: (context, index) {
                                  return GestureDetector(
                                    onTap: () => Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => DetailsPage(
                                          data: data[index],
                                        ),
                                      ),
                                    ),
                                    child: Container(
                                      height: 120,
                                      width: 200,
                                      decoration: BoxDecoration(
                                        color: Colors.grey.shade200,
                                        borderRadius: BorderRadius.circular(40),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          // Container(
                                          //   height: 100,
                                          //   width: 100,
                                          //   decoration: BoxDecoration(
                                          //     color: Colors.blue,
                                          //     borderRadius: BorderRadius.circular(20),
                                          //   ),
                                          // ),
                                          ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                            child: Image.network(
                                              data[index]["image"].toString(),
                                              height: 150.0,
                                              width: 100.0,
                                            ),
                                          ),
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(data[index]["name"]),
                                              Text("\$" +
                                                  data[index]["price"]
                                                      .toString())
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  );
                                });
                          }),
                    )
                  ],
                )
              ])
            ]),
          ),
        ],
      ),
    );
  }
}
