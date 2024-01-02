import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  List<Map<String, dynamic>> users = []; // Store user data

  @override
  void initState() {
    super.initState();
    fetchUsers(); // Fetch user data when the page is initialized
  }

  Future<void> fetchUsers() async {
    try {
      final response = await http.get(
        Uri.parse(
            'https://caku-api-test-production.up.railway.app/users'), // Replace with your API endpoint
      );

      if (response.statusCode == 200) {
        // Parse and store user data
        print("we get the user data");
        print(response.body);
        List<dynamic> responseData = json.decode(response.body) as List;
        users = List<Map<String, dynamic>>.from(responseData);
      } else {
        // Handle API error
        print('Failed to fetch users');
      }
    } catch (e) {
      // Handle network or parsing errors
      print('Error fetching users: $e');
    }
  }

  void loginUser() {
    final enteredUsername = usernameController.text;
    final enteredPassword = passwordController.text;

    // Check login credentials
    try {
      final matchingUser = users.firstWhere(
        (user) =>
            user['username'] == enteredUsername &&
            user['password'] == enteredPassword,
      );

      // Successful login logic
      usernameController.text = '';
      passwordController.text = '';
      loginSuccess('login success');
      Navigator.pushReplacementNamed(context, '/home_page');
    } catch (e) {
      // Handle login failure
      loginFailed('login Failed');
    }
  }

  void loginSuccess(String message) {
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void loginFailed(String message) {
    final snackBar = SnackBar(
      content: Text(
        message,
        style: TextStyle(color: Colors.white),
      ),
      backgroundColor: Colors.red,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

////////////////////////////////////////////////////////////////
  Widget inputFile({label, obscureText = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          label,
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w400,
            color: Colors.black87,
          ),
        ),
        SizedBox(
          height: 5,
        ),
        TextField(
          obscureText: obscureText,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey),
            ),
            border: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey),
            ),
          ),
        ),
        SizedBox(height: 10),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: 30, vertical: 80), // Adjusted padding
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Super cool login UI elements
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      Text(
                        "Login",
                        style: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 20),
                      Text(
                        "Login to your account",
                        style: TextStyle(fontSize: 15, color: Colors.grey[700]),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 40),
                    child: Column(
                      children: [
                        TextField(
                          controller:
                              usernameController, // Set the controller for the username field
                          decoration: InputDecoration(labelText: 'Username'),
                        ),
                        TextField(
                          controller:
                              passwordController, // Set the controller for the password field
                          obscureText: true,
                          decoration: InputDecoration(labelText: 'Password'),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 40),
                    child: Container(
                      padding: EdgeInsets.only(top: 3, left: 3),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        border: Border(
                          bottom: BorderSide(color: Colors.black),
                          top: BorderSide(color: Colors.black),
                          left: BorderSide(color: Colors.black),
                          right: BorderSide(color: Colors.black),
                        ),
                      ),
                      child: MaterialButton(
                        minWidth: double.infinity,
                        height: 60,
                        onPressed: () {
                          loginUser();
                        },
                        color: Color.fromARGB(255, 83, 195, 81),
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: Text(
                          "Login",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 18,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/register');
                        },
                        child: Text('Don\'t have an account? Register here.'),
                      ),
                    ],
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 100),
                    height: 200,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
