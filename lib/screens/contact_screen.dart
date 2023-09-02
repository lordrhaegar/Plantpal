import 'package:flutter/material.dart';
import '../constants.dart';

class ContactUsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20.0),
                  child: Text(
                    'Contact Us',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: kDarkGreenColor,
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  'We\'re here to assist you!',
                  style: TextStyle(
                    fontSize: 18,
                    color: kGreyColor,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            SizedBox(height: 40),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                color: kSpiritedGreen,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    spreadRadius: 5,
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.email,
                          color: kDarkGreenColor,
                        ),
                        SizedBox(width: 10),
                        Text(
                          'Email Us',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: kDarkGreenColor,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    Text(
                      'Have a question or feedback? We\'d love to hear from you!',
                      style: TextStyle(
                        fontSize: 16,
                        color: kGreyColor,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 30),
                    ElevatedButton.icon(
                      onPressed: () {
                        // Implement email functionality here
                      },
                      style: ElevatedButton.styleFrom(
                        primary: kDarkGreenColor,
                        onPrimary: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        padding: EdgeInsets.symmetric(
                            horizontal: 40, vertical: 15),
                      ),
                      icon: Icon(Icons.email),
                      label: Text(
                        'Send Email',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: Icon(
                    Icons.facebook,
                    color: kSpiritedGreen,
                    size: 30,
                  ),
                  onPressed: () {
                    // Implement Instagram link functionality here
                  },
                ),
                IconButton(
                  icon: Icon(
                    Icons.snapchat,
                    color: kSpiritedGreen,
                    size: 30,
                  ),
                  onPressed: () {
                    // Implement Facebook link functionality here
                  },
                ),
                IconButton(
                  icon: Icon(
                    Icons.messenger,
                    color: kSpiritedGreen,
                    size: 30,
                  ),
                  onPressed: () {
                    // Implement Twitter link functionality here
                  },
                ),
              ],
            ),
            SizedBox(height: 20),
            Text(
              'Find us on social media for more updates and gardening inspiration!',
              style: TextStyle(
                fontSize: 16,
                color: kGreyColor,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

