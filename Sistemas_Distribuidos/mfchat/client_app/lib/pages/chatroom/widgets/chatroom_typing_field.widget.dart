import 'package:flutter/material.dart';

class ChatroomTypingFieldWidget extends StatefulWidget {
  const ChatroomTypingFieldWidget({
    Key? key,
    required this.onSubmit,
    required FocusNode focusNode,
  })  : _focusNode = focusNode,
        super(key: key);

  final ValueChanged<String> onSubmit;
  final FocusNode _focusNode;

  @override
  State<ChatroomTypingFieldWidget> createState() =>
      _ChatroomTypingFieldWidgetState();
}

class _ChatroomTypingFieldWidgetState extends State<ChatroomTypingFieldWidget> {
  late TextEditingController _textController;

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

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black, width: 2),
      ),
      child: Form(
        child: TextFormField(
          controller: _textController,
          focusNode: widget._focusNode,
          onFieldSubmitted: (value) {
            widget.onSubmit.call(_textController.text.trim());
            _textController.clear();
          },
          decoration: InputDecoration(
            border: const OutlineInputBorder(),
            labelText: 'Enter text',
            suffix: IconButton(
              icon: const Icon(Icons.send),
              tooltip: 'Send',
              onPressed: () {
                widget.onSubmit.call(_textController.text.trim());
                _textController.clear();
              },
            ),
          ),
        ),
      ),
    );
  }
}
