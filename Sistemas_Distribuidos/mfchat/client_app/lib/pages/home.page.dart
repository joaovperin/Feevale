import 'package:client_app/pages/chatroom-with-ads.page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  static const routeName = '/';
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late TextEditingController _textController;
  late FocusNode _focusNode;
  // final Key<Form> _formKey;

  @override
  void initState() {
    super.initState();
    _textController = TextEditingController();
    _focusNode = FocusNode();
  }

  @override
  void dispose() {
    _textController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _goToChatroom() {
    Navigator.of(context).pushNamed(ChatRoomWithAdsPage.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MfChat - Client'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Container(
            width: 480,
            height: 320,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black, width: 2),
            ),
            child: Column(
              children: <Widget>[
                const SizedBox(height: 16),
                Text(
                  'Welcome Back!',
                  style: Theme.of(context).textTheme.headline4,
                ),
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Form(
                    child: Column(
                      children: [
                        TextFormField(
                          controller: _textController,
                          focusNode: _focusNode,
                          maxLength: 20,
                          validator: (String? value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your nickname';
                            }
                            if (value.length < 4) {
                              return 'Nickname must be at least 4 characters long';
                            }
                            return null;
                          },
                          onFieldSubmitted: (value) {},
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Nickname',
                            counterText: '',
                            counterStyle: TextStyle(height: double.minPositive),
                          ),
                        ),
                        const SizedBox(height: 16),
                        SizedBox(
                          height: 48,
                          width: double.infinity,
                          child: ElevatedButton(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Text('Join Chat'),
                                SizedBox(width: 8),
                                Icon(Icons.login),
                              ],
                            ),
                            onPressed: _goToChatroom,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const Spacer(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
