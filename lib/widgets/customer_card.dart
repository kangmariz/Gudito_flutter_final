import 'package:flutter/material.dart';
import '../models/customer.dart';

class CustomerCard extends StatelessWidget {
  final Customer customer;
  final VoidCallback onEdit;
  final VoidCallback onDelete;
  final Color editIconColor;
  final Color deleteIconColor;

  CustomerCard({
    required this.customer,
    required this.onEdit,
    required this.onDelete,
    this.editIconColor = Colors.blue,
    this.deleteIconColor = Colors.red,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: ListTile(
        title: Text(customer.name),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(customer.email),
            Text(customer.phone),
          ],
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: Icon(Icons.edit),
              color: editIconColor,
              onPressed: () {
                print('Edit button pressed for ${customer.name}');
                onEdit();
              },
            ),
            IconButton(
              icon: Icon(Icons.delete),
              color: deleteIconColor,
              onPressed: () {
                print('Delete button pressed for ${customer.name}');
                onDelete();
              },
            ),
          ],
        ),
      ),
    );
  }
}
