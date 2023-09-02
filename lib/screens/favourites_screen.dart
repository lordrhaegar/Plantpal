import 'package:flutter/material.dart';
import '../constants.dart';


class FavouriteScreen extends StatefulWidget {
  @override
  _FavouriteScreenState createState() => _FavouriteScreenState();
}

class _FavouriteScreenState extends State<FavouriteScreen> {
  final TextEditingController _feedbackController = TextEditingController();
  String? _selectedRating;

  final List<String> _ratings = ['Excellent', 'Good', 'Neutral', 'Poor'];

  @override
  void initState() {
    super.initState();
    _selectedRating = _ratings[0];
  }

  @override
  void dispose() {
    _feedbackController.dispose();
    super.dispose();
  }

  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 40.0),
                      child: Column(
                        children: [
                          Text(
                            'Feedback Form',
                            style: TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF184A2C),
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            'We value your opinion!',
                            style: TextStyle(
                              fontSize: 16,
                              color: kGreyColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'How was your experience?',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF184A2C),
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      color: Color(0xFFC1DFCB).withOpacity(0.5),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: DropdownButtonFormField<String>(
                      value: _selectedRating,
                      hint: Text('Select a rating'),
                      onChanged: (value) {
                        setState(() {
                          _selectedRating = value;
                        });
                      },
                      items: _ratings.map((rating) {
                        return DropdownMenuItem<String>(
                          value: rating,
                          child: Text(
                            rating,
                            style: TextStyle(color: Color(0xFF184A2C)),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Additional Feedback:',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF184A2C),
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      color: Color(0xFFC1DFCB).withOpacity(0.5),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: TextFormField(
                      controller: _feedbackController,
                      maxLines: 5,
                      decoration: InputDecoration(
                        hintText: 'Enter your feedback here',
                        border: InputBorder.none,
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Color(0xFF184A2C)),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      // Implement your feedback submission logic here
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Color(0xFF184A2C),
                      onPrimary: Colors.white,
                    ),
                    child: Text('Submit'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

