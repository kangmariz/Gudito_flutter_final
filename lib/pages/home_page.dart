import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/pic.jpg'), 
            fit: BoxFit.cover, 
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton.icon(
                  icon: Icon(
                    Icons.person,
                    semanticLabel: 'Go to Profile',
                  ),
                  label: Text('Go to Profile'),
                  onPressed: () => Navigator.pushNamed(context, '/profile'),
                ),
                SizedBox(height: 16),
                ElevatedButton.icon(
                  icon: Icon(
                    Icons.data_usage,
                    semanticLabel: 'Go to Data',
                  ),
                  label: Text('Go to Data'),
                  onPressed: () => Navigator.pushNamed(context, '/data'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
