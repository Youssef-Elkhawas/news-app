import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/cubits/fetch_news_cubit/fetch_news_cubit.dart';
import 'package:news_app/pages/news_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Globe",
              style: TextStyle(
                fontSize: 24,
                // fontWeight: FontWeight.bold,
                color: Colors.blue.shade700,
              ),
            ),
            Text(
              "Pulse",
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Color(0xFFF97316),
              ),
            ),
          ],
        ),
      ),
      backgroundColor: Colors.white,

      body: Center(
        child: Container(
          width: 380,
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Sign In"),
                TextFormField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    label: Text("Email"),
                    hint: Text("please enter your email"),
                  ),
                ),

                SizedBox(height: 16),

                TextFormField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    label: Text("Password"),
                    hint: Text("please enter your password"),
                  ),
                ),

                SizedBox(height: 16),

                ElevatedButton(
                  onPressed: () {
                    BlocProvider.of<FetchNewsCubit>(
                      context,
                    ).fetchNews(category: "General");
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => NewsPage()),
                    );
                  },
                  child: Text("LogIn"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
