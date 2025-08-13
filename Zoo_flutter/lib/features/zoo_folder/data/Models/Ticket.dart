class Ticket {
  String id;
  String name;
  String price;

  Ticket({required this.id, required this.name, required this.price});

  factory Ticket.fromJson(Map<String, dynamic> json) {
    return Ticket(
      id: json['id'].toString(),
      name: json['name'].toString(),
      price: json['price'].toString(),
    );
  }
}