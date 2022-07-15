import 'package:dhis2_flutter_ui/dhis2_flutter_ui.dart'
    show
        CircularProcessLoader,
        InputField,
        InputFieldContainer,
        InputMask,
        Mask,
        SearchInput,
        SelectInputField,
        Validators;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
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
                onInputValueChange: (String id, dynamic value) => {},
                hiddenInputFieldOptions: const {},
                dataObject: const {},
                mandatoryFieldObject: const {},
                hiddenFields: const {},
              ),
              Form(
                  key: _formKey,
                  child: InputFieldContainer(
                    inputField:
                        InputField(id: 'id', name: 'name', valueType: 'TEXT'),
                    onInputValueChange: (String id, dynamic value) => {},
                    hiddenInputFieldOptions: const {},
                    dataObject: const {},
                    mandatoryFieldObject: const {},
                    hiddenFields: const {},
                    validators: [
                      Validators.pattern("T—[\\d+\$]{4}—[\\d+\$]{4}",
                          "Enter Valid ID number. "),
                    ],
                    inputFormaters: [
                      InputMask(pattern: "X—XXXX—XXXX", separator: "—"),
                    ],
                    onError: (err) => {},
                  )),
              ElevatedButton(
                  onPressed: () => _formKey.currentState!.validate(),
                  child: const Text("Submit")),
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
