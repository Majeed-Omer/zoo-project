import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../Services/Services_crud.dart';
import '../../data/Models/Ticket.dart';

class ticket_sell extends StatefulWidget {
  ticket_sell() : super();

  final String title = "Flutter Laravel CRUD";

  @override
  ticket_sellState createState() => ticket_sellState();
}

class ticket_sellState extends State<ticket_sell> {
  late List<Ticket> _tickets;
  late GlobalKey<ScaffoldState> _scaffoldKey;
  late TextEditingController _nameController;
  late TextEditingController _priceController;
  late Ticket _selectedTicket;
  late bool _isUpdating;

  @override
  void initState() {
    super.initState();
    _tickets = [];
    _isUpdating = false;
    _scaffoldKey = GlobalKey();
    _nameController = TextEditingController();
    _priceController = TextEditingController();
    _getTickets();
  }

  _addTicket() {
    if (_nameController.text.trim().isEmpty ||
        _priceController.text.trim().isEmpty) {
      print("Empty fields");
      return;
    }
    Services.addTicket(_nameController.text, _priceController.text)
        .then((result) {
      if (result) {
        _getTickets();
      }
      _clearValues();
    });
  }

  _getTickets() {
    Services.getTickets().then((tickets) {
      setState(() {
        _tickets = tickets;
      });
      //_showProgress(widget.title);
      print("Length: ${tickets.length}");
    });
  }

  _deleteTicket(Ticket ticket) {
    Services.deleteTicket(ticket.id).then((result) {
      if (result) {
        setState(() async {
          SharedPreferences preferences = await SharedPreferences.getInstance();
          preferences.setString("tname", ticket.name);
          preferences.setString("price", ticket.price);
          _tickets.remove(ticket);
        });
        _getTickets();
      }
    });
  }

  _updateTicket(Ticket ticket) {
    Services.updateTicket(
        ticket.id, _nameController.text, _priceController.text)
        .then((result) {
      if (result) {
        _getTickets();
        setState(() {
          _isUpdating = false;
        });
        _nameController.text = '';
        _priceController.text = '';
      }
    });
  }

  // _setValues(Ticket ticket) {
  //   _nameController.text = ticket.name;
  //   _priceController.text = ticket.price;
  //   setState(() {
  //     _isUpdating = true;
  //   });
  // }

  _clearValues() {
    _nameController.text = '';
    _priceController.text = '';
  }

  // showSnackBar(context, message) {
  //   _scaffoldKey.currentState!.showSnackBar(SnackBar(
  //     content: Text(message),
  //   ));
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        elevation: 0.0,
        title: Text("Buy a ticket"),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text("Add Ticket"),
                  content: SizedBox(
                    height: 150,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        TextField(
                          controller: _nameController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Enter Name Here',
                          ),
                          autofocus: false,
                        ),
                        TextField(
                          controller: _priceController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Enter Price Here',
                          ),
                          autofocus: false,
                        )
                      ],
                    ),
                  ),
                  actions: [
                    TextButton(
                        onPressed: (() => Navigator.pop(context)),
                        child: Text("CANCEL")),
                    TextButton(
                        onPressed: (() {
                          _addTicket();
                          Navigator.pop(context);
                        }),
                        child: Text("OK"))
                  ],
                ),
              );
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: _tickets.length,
        itemBuilder: (context, index) => Card(
          margin: EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 0.0),
          child: ListTile(
            onLongPress: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text("Edit Ticket"),
                  content: SizedBox(
                    height: 150,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        TextFormField(
                          initialValue: _tickets[index].name,
                          //controller: _nameController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Enter Name Here',
                          ),
                          autofocus: false,
                        ),
                        TextFormField(
                          initialValue: _tickets[index].price,
                          //controller: _priceController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Enter Price Here',
                          ),
                          autofocus: false,
                        )
                      ],
                    ),
                  ),
                  actions: [
                    TextButton(
                        onPressed: (() => Navigator.pop(context)),
                        child: Text("CANCEL")),
                    TextButton(
                        onPressed: (() {
                          Navigator.pop(context);
                        }),
                        child: Text("OK"))
                  ],
                ),
              );
            },
            leading: Image.asset('assets/regular.png'),
            title: Text(
              _tickets[index].name,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            subtitle: Text(_tickets[index].price),
            trailing: TextButton(
              onPressed: () {
                _deleteTicket(_tickets[index]);
              },
              child: Text(
                "Sold",
                style: TextStyle(color: Colors.red),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
