import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:polling_app/routes/routes.dart';

// ignore: must_be_immutable
class HomeScreen extends StatefulWidget {
  PollingArgumet args;
  HomeScreen(this.args);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Polling> polling = [
    Polling(1, "Football", "Best game", "op1", DateTime.now(), DateTime.now()),
    Polling(2, "Java", "Best Programming language", "op2", DateTime.now(),
        DateTime.now()),
    Polling(3, "Flutter", "Best front end frame work", "op3", DateTime.now(),
        DateTime.now()),
    Polling(4, "volleyball", "Best game ever", "op4", DateTime.now(),
        DateTime.now()),
  ];
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
  ];

  @override
  Widget build(BuildContext context) {
    void addPolling() {
      final newpoll = Polling(
          widget.args.id,
          widget.args.title,
          widget.args.description,
          widget.args.options!,
          widget.args.startDate!,
          widget.args.finalDate!);
      setState(() {
        polling.insert(0, newpoll);
      });
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pushNamed(context, '/addpolling');
              },
              icon: Icon(Icons.add))
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 200.0,
              width: double.infinity,
              child: Carousel(
                dotSpacing: 15.0,
                dotSize: 6.0,
                dotIncreasedColor: Colors.red,
                dotBgColor: Colors.transparent,
                indicatorBgPadding: 10.0,
                dotPosition: DotPosition.topCenter,
                images: images
                    .map(
                      (item) => Container(
                        child: Image.asset(
                          item,
                          fit: BoxFit.cover,
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),
            Container(
              height: 400,
              child: ListView.builder(
                itemCount: polling.length,
                itemBuilder: (BuildContext context, int index) {
                  return Dismissible(
                    background: Container(color: Colors.red),
                    direction: DismissDirection.endToStart,
                    key: ValueKey(polling[index]),
                    confirmDismiss: (DismissDirection direction) async {
                      return await showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text("Confirm"),
                            content: const Text(
                                "Are you sure you wish to delete this item?"),
                            actions: <Widget>[
                              ElevatedButton(
                                  onPressed: () =>
                                      Navigator.of(context).pop(true),
                                  child: const Text("Yes")),
                              ElevatedButton(
                                onPressed: () =>
                                    Navigator.of(context).pop(false),
                                child: const Text("No"),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    onDismissed: (DismissDirection direction) {
                      Scaffold.of(context).showSnackBar(
                          SnackBar(content: Text("Items Deleted")));
                      setState(() {
                        polling.removeAt(index);
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(12, 0, 12, 25),
                      child: ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                        child: Container(
                          margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border(
                                left:
                                    BorderSide(width: 10.0, color: Colors.teal),
                              ),
                              boxShadow: [
                                BoxShadow(
                                    color: Color(0xffA22447).withOpacity(.05),
                                    offset: Offset(0, 0),
                                    blurRadius: 20,
                                    spreadRadius: 3)
                              ]),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.of(context).pushNamed(
                                  '/detail',
                                  arguments: polling.elementAt(index),
                                );
                              },
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ListTile(
                                    leading: CircleAvatar(
                                      child: ClipRRect(
                                        child: Image.asset(images[index]),
                                        borderRadius:
                                            BorderRadius.circular(50.0),
                                      ),
                                    ),
                                  ),
                                  Text(
                                    "${polling[index].title}",
                                    style: TextStyle(
                                        fontSize: 30,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text("${polling[index].description}"),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                          "Starting Date: ${DateFormat.yMd().format(polling[index].startDate)}"),
                                      Text(
                                          "Final Date: ${DateFormat.yMd().format(polling[index].finalDate)}"),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
      drawer: Drawer(
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,

          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: Text("alayu"),
              accountEmail: Text("email"),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.orange,
                child: Text(
                  "A",
                  style: TextStyle(fontSize: 40.0),
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text("Home"),
              onTap: () {
                addPolling();
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.edit),
              title: Text("Change Password"),
              onTap: () {
                Navigator.pushNamed(context, '/changepassword');
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.delete),
              title: Text("Delete Account"),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (ctx) => AlertDialog(
                    title: Text('Are you sure?'),
                    content: Text(
                      'Do you want to delete account?',
                    ),
                    actions: <Widget>[
                      ElevatedButton(
                        child: Text('No'),
                        onPressed: () {
                          Navigator.of(ctx).pop(false);
                        },
                      ),
                      ElevatedButton(
                        child: Text('Yes'),
                        onPressed: () {
                          Navigator.pushNamed(context, '/');
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text("Log Out"),
              onTap: () {
                Navigator.pushNamed(
                  context,
                  '/',
                );
              },
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          print("${widget.args.id}");
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
