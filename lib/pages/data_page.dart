import 'package:flutter/material.dart';
import '../models/customer.dart';
import '../services/api_service.dart';
import '../widgets/customer_card.dart';

class DataPage extends StatefulWidget {
  @override
  _DataPageState createState() => _DataPageState();
}

class _DataPageState extends State<DataPage> {
  final ApiService _apiService = ApiService();
  late Future<List<Customer>> _customers;

  @override
  void initState() {
    super.initState();
    _customers = _apiService.fetchCustomers();
  }

  void _refreshList() {
    setState(() {
      _customers = _apiService.fetchCustomers();
    });
  }

  void _editCustomer(Customer customer) async {
    TextEditingController nameController = TextEditingController(text: customer.name);
    TextEditingController emailController = TextEditingController(text: customer.email);
    TextEditingController phoneController = TextEditingController(text: customer.phone);

    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Edit Customer'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: InputDecoration(labelText: 'Name'),
              ),
              TextField(
                controller: emailController,
                decoration: InputDecoration(labelText: 'Email'),
              ),
              TextField(
                controller: phoneController,
                decoration: InputDecoration(labelText: 'Phone'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () async {
                customer.name = nameController.text;
                customer.email = emailController.text;
                customer.phone = phoneController.text;

                try {
                  await _apiService.updateCustomer(customer.id, customer);
                  _refreshList(); 
                  Navigator.of(context).pop();
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Failed to update customer: $e'),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              },
              child: Text('Save'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Customer Data')),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/pic.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: FutureBuilder<List<Customer>>(
          future: _customers,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error fetching data'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Center(child: Text('No data available'));
            } else {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  final customer = snapshot.data![index];
                  return CustomerCard(
                    customer: customer,
                    onDelete: () async {
                      try {
                        await _apiService.deleteCustomer(customer.id);
                        _refreshList(); 
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Failed to delete customer: $e'),
                            backgroundColor: Colors.red,
                          ),
                        );
                      }
                    },
                    onEdit: () {
                      _editCustomer(customer);
                    },
                    editIconColor: Colors.blue,
                    deleteIconColor: Colors.red,
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}
