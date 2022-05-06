import 'package:dhis2_flutter_ui/dhis2_flutter_ui.dart'
    show CircularProcessLoader, InputField, InputFieldContainer, SearchInput, SelectInputField;
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text(
                'You have pushed the button this many times:',
              ),
              InputFieldContainer(
                inputField:
                    InputField(id: 'id', name: 'name', valueType: 'EMAIL'),
                onInputValueChange: (String id, dynamic value) =>
                    print("$id => $value"),
                hiddenInputFieldOptions: const {},
                dataObject: const {},
                mandatoryFieldObject: const {},
                hiddenFields: const {},
              ),
          
              const SearchInput(
                onSearch: null,
              ),
              const CircularProcessLoader(
                color: Colors.blue,
                size: 5,
              ),
            ],
          ),
        ));
  }
}
