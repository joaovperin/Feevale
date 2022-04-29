import 'package:client_app/application/ui/app_loading_service.dart';
import 'package:client_app/domain/settings/app_settings_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SettingsPage extends StatefulWidget {
  static const routeName = '/settings';
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  late TextEditingController _addressController;
  late TextEditingController _portController;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    final _oldSettings = AppSettingsProvider.of(context).settings;

    _addressController = TextEditingController()..text = _oldSettings.address;
    _portController = TextEditingController()
      ..text = _oldSettings.port.toString();
  }

  @override
  void dispose() {
    _addressController.dispose();
    _portController.dispose();
    super.dispose();
  }

  void _saveSettingsAndGoBack() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final address = _addressController.text.trim();
    final port = int.parse(_portController.text.trim());

    final _loader = AppLoading.show(context);
    AppSettingsProvider.of(context).updateSettings(address, port).then((_) {
      _loader.close();
      Navigator.of(context).pop();
    }).catchError((err) {
      _loader.close();
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
                  'Settings',
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
                          controller: _addressController,
                          autofocus: true,
                          maxLength: 80,
                          textInputAction: TextInputAction.next,
                          validator: (String? value) {
                            if (value == null ||
                                value.isEmpty ||
                                value.length < 4) {
                              return 'Please enter the server address';
                            }
                            return null;
                          },
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Address',
                            counterText: '',
                            counterStyle: TextStyle(height: double.minPositive),
                          ),
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: _portController,
                          autofocus: true,
                          maxLength: 5,
                          keyboardType: TextInputType.number,
                          textInputAction: TextInputAction.next,
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                          ],
                          validator: (String? value) {
                            if (value == null ||
                                value.isEmpty ||
                                value.length > 5) {
                              return 'Please enter the server port';
                            }
                            return null;
                          },
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Port',
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
                                Text('Save'),
                                SizedBox(width: 8),
                                Icon(Icons.save),
                              ],
                            ),
                            onPressed: _saveSettingsAndGoBack,
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
