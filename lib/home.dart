import 'package:crud/detail.dart';
import 'package:crud/response/list.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'dart:async';

import 'model/model_list.dart';

Timer _debounce;

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Future<List<Result>> futureListReseps;
  // List<Result> _search = [];
  String searchString = "";

  TextEditingController controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    futureListReseps = fetchListResep();
  }

  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }

  Future<void> refreshCollectionItems() async {
    setState(() {
      futureListReseps = fetchListResep();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Padding(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.10,
                    left: 8,
                    right: 8,
                    bottom: 8),
                child: FutureBuilder<List<Result>>(
                    future: futureListReseps,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return (snapshot.data.length > 0)
                            ? Container(
                                child: RefreshIndicator(
                                  onRefresh: refreshCollectionItems,
                                  child: ListView.builder(
                                    itemBuilder: (BuildContext context, index) {
                                      return InkWell(
                                          child: Column(
                                            children: [
                                              Stack(
                                                children: [
                                                  Container(
                                                    child: Image.network(
                                                        snapshot
                                                            .data[index].thumb,
                                                        width: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width /
                                                            1),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      0.010),
                                              Text(snapshot.data[index].title),
                                            ],
                                          ),
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) => Detail(
                                                      keys: snapshot
                                                          .data[index].key),
                                                ));
                                          });
                                    },
                                    itemCount: snapshot.data.length,
                                  ),
                                ),
                              )
                            : Container(
                                padding: EdgeInsets.only(
                                    top:
                                        MediaQuery.of(context).size.height / 6),
                                child: ListView(
                                  children: [
                                    Image.asset('images/404.png'),
                                    Center(
                                      child: Text(
                                        'Pencarian Kamu Tidak DiTemukan',
                                        style: TextStyle(fontSize: 20),
                                      ),
                                    )
                                  ],
                                ),
                              );
                      } else {
                        return ListView.builder(
                          itemBuilder: (BuildContext context, index) {
                            return Center(
                                child: Shimmer.fromColors(
                              baseColor: Colors.grey[300],
                              highlightColor: Colors.grey[100],
                              child: Container(
                                margin: EdgeInsets.only(bottom: 10),
                                color: Colors.green,
                                height: 200,
                              ),
                            ));
                          },
                          itemCount: 10,
                        );
                      }
                    })),
          ),
          Container(
            padding: EdgeInsets.only(
                top: MediaQuery.of(context).size.height * 0.040,
                left: 8,
                right: 8,
                bottom: 8),
            child: Card(
              child: TextField(
                controller: controller,
                onChanged: (value) {
                  if (_debounce?.isActive ?? false) _debounce.cancel();
                  _debounce = Timer(const Duration(milliseconds: 500), () {
                    setState(() {
                      if (value.isNotEmpty) {
                        futureListReseps = fetchSearchResep(value);
                      } else {
                        print('Loading');
                        futureListReseps = fetchListResep();
                        Center(child: CircularProgressIndicator());
                      }
                    });
                  });
                },

                // controller: controller,
                decoration: InputDecoration(
                  hintText: 'Cari Apa Hayuk',
                  prefixIcon: Icon(Icons.search),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
