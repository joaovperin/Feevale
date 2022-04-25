import 'package:client_app/application/ui/app_dialogs.dart';
import 'package:client_app/domain/auth/auth_provider.dart';
import 'package:client_app/pages/chatroom/chatroom.page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  static const routeName = '/';
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late TextEditingController _textController;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _textController = TextEditingController();
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  void _goToChatroom() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final nickname = _textController.text.trim();
    AppAuthProvider.of(context).loginViaNickname(nickname).then((_) {
      Navigator.of(context).pushNamed(ChatroomPage.routeName);
    }).catchError((err) {
      // AppDialogs.showErrorDialog(context, err.toString());
      // todo: fix msg
      AppDialogs.error(
        context,
        message: 'Username already taken!! Please choose another.',
      );
    });
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
                    key: _formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          controller: _textController,
                          autofocus: true,
                          maxLength: 20,
                          validator: (String? value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your nickname';
                            }
                            if (value.length < 4) {
                              return 'Nickname must be at least 4 characters long';
                            }
                            if (const ['all'].contains(value)) {
                              return 'Nickname "$value" is not allowed!';
                            }
                            return null;
                          },
                          onFieldSubmitted: (_) => _goToChatroom(),
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
