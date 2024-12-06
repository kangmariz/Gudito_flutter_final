import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/customer.dart';

class ApiService {
  final String baseUrl = 'https://jsonplaceholder.typicode.com/users'; 

  Future<List<Customer>> fetchCustomers() async {
    try {
      final response = await http.get(Uri.parse(baseUrl));
      print('Fetch response status: ${response.statusCode}');
      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        return data.map((item) => Customer.fromJson(item)).toList();
      } else {
        throw Exception('Failed to load customers. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching data: $e');
      throw Exception('Error fetching data: $e');
    }
  }

  Future<void> updateCustomer(int id, Customer updatedCustomer) async {
    try {
      final response = await http.put(
        Uri.parse('$baseUrl/$id'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode(updatedCustomer.toJson()),
      );
      print('Update response status: ${response.statusCode}');
      print('Update response body: ${response.body}');
      if (response.statusCode != 200) {
        throw Exception('Failed to update customer. Status code: ${response.statusCode}. Response: ${response.body}');
      }
    } catch (e) {
      print('Error updating data: $e');
      throw Exception('Error updating data: $e');
    }
  }

  Future<void> deleteCustomer(int id) async {
    try {
      final response = await http.delete(
        Uri.parse('$baseUrl/$id'),
      );
      print('Delete response status: ${response.statusCode}');
      print('Delete response body: ${response.body}');
      if (response.statusCode != 200 && response.statusCode != 204) {
        throw Exception('Failed to delete customer. Status code: ${response.statusCode}. Response: ${response.body}');
      }
    } catch (e) {
      print('Error deleting data: $e');
      throw Exception('Error deleting data: $e');
    }
  }
}
