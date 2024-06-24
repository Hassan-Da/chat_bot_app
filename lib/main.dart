import 'package:chat_bot_app/pages/chat.bot.page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chat boot',
      routes: {"/chat-bot": (context) => ChatBotPage()},
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.amber),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    TextEditingController loginControllers = TextEditingController();
    TextEditingController passwordControllers = TextEditingController();

    return Scaffold(
        appBar: AppBar(
          title: Text(
            "LogIn page",
            style: TextStyle(fontSize: 25, color: Colors.white70),
          ),
          backgroundColor: Colors.amber,
        ),
        body: Center(
          child: Container(
            alignment: Alignment.center,
            width: 400,
            height: 500,
            color: Colors.amber,
            child: Card(
              color: Colors.white,
              child: Padding(
                padding: EdgeInsetsDirectional.fromSTEB(20, 0, 20, 0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image(
                      image: AssetImage("images/logo.jpeg"),
                      height: 200,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: loginControllers,
                      decoration: InputDecoration(
                          suffixIcon: Icon(Icons.lock),
                          border: OutlineInputBorder(
                              borderSide: BorderSide(width: 2),
                              borderRadius: BorderRadius.circular(20))),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: passwordControllers,
                      obscureText: true,
                      decoration: InputDecoration(
                          suffixIcon: Icon(Icons.remove_red_eye),
                          border: OutlineInputBorder(
                              borderSide: BorderSide(width: 2),
                              borderRadius: BorderRadius.circular(20))),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          String username = loginControllers.text;
                          String password = passwordControllers.text;
                          if (username == "admin" && password == "1234") {
                            Navigator.of(context).pop();
                            Navigator.pushNamed(context, "/chat-bot");
                          }
                        },
                        child: Text(
                          "Log in",
                          style: TextStyle(color: Colors.black, fontSize: 22),
                        ),
                        style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.all(20),
                            backgroundColor: Colors.amber),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
