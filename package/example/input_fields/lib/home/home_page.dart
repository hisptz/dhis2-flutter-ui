import 'package:dhis2_flutter_ui/dhis2_flutter_ui.dart'
    show InputField, InputFieldContainer, InputMask, SearchInput, Validators;
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  void onInputValueChange(String id, dynamic value) {
    debugPrint("$id => $value");
  }

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Container(
          margin: const EdgeInsets.symmetric(
            vertical: 20,
            horizontal: 30.0,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text(
                'You have pushed the button this many times:',
              ),
              InputFieldContainer(
                inputField: InputField(
                  id: 'id-email',
                  name: 'name',
                  valueType: 'EMAIL',
                ),
                onInputValueChange: onInputValueChange,
                hiddenInputFieldOptions: const {},
                dataObject: const {},
                mandatoryFieldObject: const {},
                hiddenFields: const {},
              ),
               InputFieldContainer(
                inputField: InputField(
                  id: 'id-date',
                  name: 'datepicker',
                  valueType: 'DATE',
                  minDate: DateTime(2022,4,01),
                  maxDate: DateTime(2022,10,26)
                ),
                onInputValueChange: onInputValueChange,
                hiddenInputFieldOptions: const {},
                dataObject: const {},
                mandatoryFieldObject: const {},
                hiddenFields: const {},
              ),
              Form(
                  key: _formKey,
                  child: InputFieldContainer(
                    inputField: InputField(
                        id: 'id-formatted',
                        name: 'name',
                        valueType: 'TEXT',
                        prefixLabel: "T—",
                        hint: "XXXX—XXXX—XXX—X"),
                    onInputValueChange: onInputValueChange,
                    hiddenInputFieldOptions: const {},
                    dataObject: const {},
                    mandatoryFieldObject: const {},
                    hiddenFields: const {},
                    validators: [
                      Validators.pattern("[0-9]{4}—[0-9]{4}—[0-9]{2}",
                          "Enter Valid ID number. "),
                    ],
                    inputFormaters: [
                      InputMask(pattern: "XXXX—XXXX—XXX—X", separator: "—"),
                    ],
                    onError: (err) => {},
                  )),
              ElevatedButton(
                  onPressed: () => _formKey.currentState!.validate(),
                  child: const Text("Submit")),
              const SearchInput(
                onSearch: null,
              ),
            ],
          ),
        ));
  }
}
