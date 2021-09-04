import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:polling_app/models/complain.dart';
import 'package:polling_app/models/polling.dart';

class DetailScreen extends StatefulWidget {
  final Polling args;
  DetailScreen(this.args);

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  final _commentController = TextEditingController();
  final List<String> images = [
    'assets/images/polling1.jpeg',
    'assets/images/polling2.jpeg',
    'assets/images/polling3.jpeg',
    'assets/images/vote6.jpg',
    'assets/images/vote7.jpg',
    'assets/images/polling5.png',
    'assets/images/polling6.png',
    'assets/images/vote2.jpeg',
    'assets/images/polling1.jpeg',
    'assets/images/polling2.jpeg',
    'assets/images/polling3.jpeg',
    'assets/images/vote6.jpg',
    'assets/images/vote7.jpg',
    'assets/images/polling5.png',
    'assets/images/polling6.png',
    'assets/images/vote2.jpeg',
    'assets/images/polling1.jpeg',
    'assets/images/polling2.jpeg',
    'assets/images/polling3.jpeg',
    'assets/images/vote6.jpg',
    'assets/images/vote7.jpg',
    'assets/images/polling5.png',
    'assets/images/polling6.png',
    'assets/images/vote2.jpeg',
    'assets/images/polling1.jpeg',
    'assets/images/polling2.jpeg',
    'assets/images/polling3.jpeg',
    'assets/images/vote6.jpg',
    'assets/images/vote7.jpg',
    'assets/images/polling5.png',
    'assets/images/polling6.png',
    'assets/images/vote2.jpeg',
    'assets/images/polling1.jpeg',
    'assets/images/polling2.jpeg',
    'assets/images/polling3.jpeg',
    'assets/images/vote6.jpg',
    'assets/images/vote7.jpg',
    'assets/images/polling5.png',
    'assets/images/polling6.png',
    'assets/images/vote2.jpeg',
    'assets/images/polling1.jpeg',
    'assets/images/polling2.jpeg',
    'assets/images/polling3.jpeg',
    'assets/images/vote6.jpg',
    'assets/images/vote7.jpg',
    'assets/images/polling5.png',
    'assets/images/polling6.png',
    'assets/images/vote2.jpeg',
    'assets/images/polling1.jpeg',
    'assets/images/polling2.jpeg',
    'assets/images/polling3.jpeg',
    'assets/images/vote6.jpg',
    'assets/images/vote7.jpg',
    'assets/images/polling5.png',
    'assets/images/polling6.png',
    'assets/images/vote2.jpeg',
  ];

  final List<Complain> complain = [
    Complain("Alayu", "This is comment"),
    Complain("biruk", "This is comment"),
    Complain("Deginet", "This is comment")
  ];

  void comment() {
    final newComment = Complain("Somebody", _commentController.text);

    setState(() {
      complain.add(newComment);
    });
  }

  @override
  Widget build(BuildContext context) {
    final textFieldDecoration = InputDecoration(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.0),
        borderSide: BorderSide(color: Colors.red),
      ),
    );
    return Scaffold(
      appBar: AppBar(
        title: Text("Detail"),
      ),
      body: SingleChildScrollView(
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Details',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "${this.widget.args.title}",
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text("${this.widget.args.description}"),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                        "Starting Date: ${DateFormat.yMd().format(this.widget.args.startDate)}"),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                        "Final Date: ${DateFormat.yMd().format(this.widget.args.finalDate)}"),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  height: 300,
                  child: ListView.builder(
                    itemCount: complain.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        child: Card(
                          elevation: 0,
                          child: ListTile(
                            leading: CircleAvatar(
                              child: ClipRRect(
                                child: Image.asset(images[index]),
                                borderRadius: BorderRadius.circular(50.0),
                              ),
                            ),
                            title: Text(
                              "${complain[index].commentorName}",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            subtitle: Text("${complain[index].comment}"),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        controller: _commentController,
                        maxLines: 5,
                        decoration: textFieldDecoration.copyWith(
                          hintText: "Write your complain...",
                          hintStyle: TextStyle(color: Colors.black),
                        ),
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.emailAddress,
                      ),
                    ),
                    Positioned(
                      right: 20,
                      bottom: 20,
                      child: ElevatedButton(
                        onPressed: () {
                          comment();
                        },
                        child: Text("Add Complain"),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
