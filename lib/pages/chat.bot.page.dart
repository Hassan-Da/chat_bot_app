import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ChatBotPage extends StatefulWidget {
  const ChatBotPage({super.key});

  @override
  State<ChatBotPage> createState() => _ChatBotPageState();
}

List messages = [
  {"message": "hello", "type": "user"},
  {"message": "how can i help you", "type": "bot"},
];
TextEditingController messageControllers = TextEditingController();
ScrollController scrollController = ScrollController();

class _ChatBotPageState extends State<ChatBotPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "chat bot",
            style: TextStyle(fontSize: 25, color: Colors.white70),
          ),
          backgroundColor: Colors.amber,
        ),
        body: Column(
          children: [
            Expanded(
                child: ListView.builder(
                    controller: scrollController,
                    itemCount: messages.length,
                    itemBuilder: (context, index) {
                      bool isUser = messages[index]["type"] == "user";
                      return Column(
                        children: [
                          ListTile(
                            trailing: isUser ? Icon(Icons.person) : null,
                            leading: !isUser ? Icon(Icons.adb) : null,
                            title: Row(children: [
                              SizedBox(
                                width: isUser ? 100 : 0,
                              ),
                              Expanded(
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(15),
                                  child: Container(
                                    child: Text(messages[index]["message"]),
                                    color: isUser
                                        ? Colors.amber
                                        : Colors.amberAccent,
                                    padding: EdgeInsets.all(10),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: isUser ? 0 : 100,
                              ),
                            ]),
                          ),
                        ],
                      );
                      Text(messages[index]["message"]);
                    })),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Row(children: [
                Expanded(
                  child: TextFormField(
                    controller: messageControllers,
                    decoration: InputDecoration(
                        suffixIcon: Icon(Icons.search),
                        border: OutlineInputBorder(
                            borderSide: BorderSide(width: 2),
                            borderRadius: BorderRadius.circular(20))),
                  ),
                ),
                IconButton(
                    onPressed: () {
                      String query = messageControllers.text;
                      var openApiUri = Uri.https(
                          "api.groq.com", "/openai/v1/chat/completions");
                      Map<String, String> headers = {
                        "Content-Type": "application/json",
                        "Authorization":
                            "Bearer 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"
                      };
                      var prompt = {
                        "model": "mixtral-8x7b-32768",
                        "messages": [
                          {"role": "user", "content": query}
                        ],
                        "temperature": 0
                      };
                      http
                          .post(openApiUri,
                              headers: headers, body: json.encode(prompt))
                          .then((res) {
                        var responseBody = res.body;
                        var llmResponse = jsonDecode(responseBody);
                        String responseContent =
                            llmResponse["choices"][0]["message"]["content"];
                        setState(() {
                          messages.add({"message": query, "type": "user"});
                          messages
                              .add({"message": responseContent, "type": "bot"});
                          scrollController.jumpTo(
                              scrollController.position.maxScrollExtent + 500);
                          messageControllers.clear();
                        });
                      }, onError: (error) {
                        print("-------------ERROR--------------");
                        print(error);
                      });
                    },
                    icon: Icon(Icons.send))
              ]),
            ),
          ],
        ));
  }
}
