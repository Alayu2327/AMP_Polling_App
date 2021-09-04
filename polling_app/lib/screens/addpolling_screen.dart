import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:polling_app/routes/routes.dart';

class AddPollingScreen extends StatefulWidget {
  @override
  AddPollingState createState() => AddPollingState();
}

class AddPollingState extends State<AddPollingScreen> {
  final _titleController = TextEditingController();
  final opTitleController = TextEditingController();
  final _opDescriptionController = TextEditingController();
  final _descriptionController = TextEditingController();
  DateTime? _startDate;
  DateTime? _finalDate;
  void _startNewPolling(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (_) {
          return GestureDetector(
            onTap: () {},
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                child: Column(
                  children: [
                    Text(
                      'add options',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextField(
                      controller: opTitleController,
                      decoration: InputDecoration(hintText: 'Title'),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextField(
                      decoration: InputDecoration(hintText: 'Description'),
                      controller: _opDescriptionController,
                      maxLines: 5,
                      // onChanged: (val) => amountInput = val,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                      child: Text('Add Polling Option'),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                ),
              ),
            ),
            behavior: HitTestBehavior.opaque,
          );
        });
  }
  
  void startDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2019),
      lastDate: DateTime.now(),
    )..then((pickedDate) {
        if (pickedDate == null) {
          return;
        }
        setState(() {
          _startDate = pickedDate;
        });
      });
    print('...');
  }

  void finalDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2019),
      lastDate: DateTime(DateTime.now().year + 1),
    )..then((pickedDate) {
        if (pickedDate == null) {
          return;
        }
        setState(() {
          _finalDate = pickedDate;
        });
      });
    print('...');
  }

  void _submitData() {
    if (_descriptionController.text.isEmpty) {
      return;
    }
    final enteredTitle = _titleController.text;
    final enteredDescription = double.parse(_descriptionController.text);

    if (enteredTitle.isEmpty || enteredDescription <= 0) {
      return;
    }

    print(enteredDescription);
    print(_startDate);
    print(_finalDate);
    print(opTitleController.text);
    print(_opDescriptionController.text);

        Navigator.of(context)
      .pushNamed(
        '/home',
        arguments: PollingArgumet(1, opTitleController.text,
            _opDescriptionController.text, opTitleController.text,_startDate,_finalDate),
      );
  }


  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Polling Screen"),
        centerTitle: true,
      ),
      body: Card(
        elevation: 5,
        child: Container(
          padding: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                'Create new poll',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              TextField(
                decoration: InputDecoration(hintText: 'Title'),
                controller: _titleController,
                onSubmitted: (_) => _submitData(),
                // onChanged: (val) {
                //   titleInput = val;
                // },
              ),
              TextField(
                decoration: InputDecoration(hintText: 'Description'),
                maxLines: 5,
                controller: _descriptionController,
                keyboardType: TextInputType.number,
                onSubmitted: (_) => _submitData(),
                // onChanged: (val) => amountInput = val,
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'Add option',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              Container(
                height: 70,
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        _startDate == null
                            ? 'No Date Chosen!'
                            : 'Picked Date: ${DateFormat.yMd().format(_startDate!)}',
                      ),
                    ),
                    TextButton(
                      child: Text(
                        'Choose Start Date',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      onPressed: startDatePicker,
                    ),
                  ],
                ),
              ),
              Container(
                height: 70,
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        _finalDate == null
                            ? 'No Date Chosen!'
                            : 'Picked Date: ${DateFormat.yMd().format(_finalDate!)}',
                      ),
                    ),
                    TextButton(
                      child: Text(
                        'Choose Final Date',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      onPressed: finalDatePicker,
                    ),
                  ],
                ),
              ),
              GestureDetector(
                    onTap: (){
                       opTitleController.text = '';
                  _opDescriptionController.text = '';
                  return _startNewPolling(context);
                    },
                    child: Container(
                      width: double.infinity,
                      height: 50.0,
                      decoration: BoxDecoration(
                        color: Colors.teal,
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        "Create Options",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 22.0,
                        ),
                      ),
                    ),
                  ),
              SizedBox(
                height: 20,
              ),
              GestureDetector(
                    onTap: _submitData,
                    child: Container(
                      width: double.infinity,
                      height: 50.0,
                      decoration: BoxDecoration(
                        color: Colors.teal,
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        "Add Polling",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 22.0,
                        ),
                      ),
                    ),
                  ),
            ],
          ),
        ),
      ),
    );
  }
}
