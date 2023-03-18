import 'dart:convert';
import 'package:http/http.dart' as http;
import '../data/Models/Ticket.dart';

class Services {
  static const ROOT = 'http://192.168.100.80:8000/api/tickets/';
  static const _CREATE_TABLE_ACTION = 'CREATE_TABLE';
  static const _GET_ALL_ACTION = 'GET_ALL';
  static const _ADD_EMP_ACTION = 'ADD_EMP';
  static const _UPDATE_EMP_ACTION = 'UPDATE_EMP';
  static const _DELETE_EMP_ACTION = 'DELETE_EMP';


  static Future<List<Ticket>> getTickets() async {
    try {
      var map = Map<String, dynamic>();
      map['action'] = _GET_ALL_ACTION;
      final response = await http.get(Uri.parse(ROOT));
      print('getTickets Response: ${response.body}');
      print(response.statusCode);
      print(200 == response.statusCode);
      if (200 == response.statusCode) {
        List<Ticket> list = parseResponse(response.body);
        print(list.length);
        return list;
      } else {
        return <Ticket>[];
      }
    } catch (e) {
      return <Ticket>[];
    }
  }

  static List<Ticket> parseResponse(String responseBody) {
    final parsed = json.decode(responseBody);
    print(parsed);
    return parsed.map<Ticket>((json) => Ticket.fromJson(json)).toList();
  }


  static Future<bool> addTicket(String name, String price) async {
    try {
      var map = Map<String, dynamic>();
      map['action'] = _ADD_EMP_ACTION;
      map['name'] = name;
      map['price'] = price;
      final response = await http.post(Uri.parse(ROOT), body: map);
      print('addTicket Response: ${response.body}');
      if (200 == response.statusCode) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }


  static Future<bool> updateTicket(String tkId, String name,
      String price) async {
    try {
      var map = Map<String, dynamic>();
      map['action'] = _UPDATE_EMP_ACTION;
      map['id'] = tkId;
      map['name'] = name;
      map['price'] = price;
      final response = await http.put(Uri.parse(ROOT + tkId), body: map);
      print('updateTicket Response: ${response.body}');
      if (200 == response.statusCode) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }


  static Future<bool> deleteTicket(String tkId) async {
    try {
      final response = await http.delete(Uri.parse(ROOT + tkId));
      print('deleteTicket Response: ${response.body}');
      if (200 == response.statusCode) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }
}