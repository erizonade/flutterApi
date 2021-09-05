import 'package:crud/model/model_detail.dart';
import 'package:crud/response/list.dart';
import 'package:flutter/material.dart';

class Detail extends StatefulWidget {
  final String keys;
  Detail({
    this.keys,
  });

  @override
  _DetailState createState() => _DetailState();
}

class _DetailState extends State<Detail> {
  Future<Details> fetchDetailResep;

  @override
  void initState() {
    super.initState();
    fetchDetailResep = fetchDetailReseps(widget.keys);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Detail Resep')),
      body: FutureBuilder(
        future: fetchDetailResep,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Column(
              children: [
                Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        Text(snapshot.data.results.title),
                        Image.network(snapshot.data.results.thumb ??
                            'https://pertaniansehat.com/v01/wp-content/uploads/2015/08/default-placeholder.png')
                      ],
                    )),
              ],
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
