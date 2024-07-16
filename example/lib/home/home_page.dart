import 'package:dhis2_flutter_ui/dhis2_flutter_ui.dart'
    show
        AppModalUtil,
        InputField,
        InputFieldContainer,
        InputMask,
        SearchInput,
        Validators;
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    super.key,
    required this.title,
  });

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  void onInputValueChange(String id, dynamic value) {
    debugPrint('$id => $value');
  }

  void showPopUpConfirmation(context) {
    AppModalUtil.showPopUpConfirmation(
      context,
      themColor: Colors.green,
      title: 'Title',
      confirmActionLabel: 'Confirm',
      confirmationContent: Container(
        margin: const EdgeInsets.symmetric(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.symmetric(),
              child: const Text(
                'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce convallis, urna vitae lacinia feugiat',
                style: TextStyle(color: Color(0xFF1D2B36)),
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(),
              child: const Text(
                'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce convallis, urna vitae lacinia feugiat',
                style: TextStyle(color: Color(0xFF1D2B36)),
              ),
            )
          ],
        ),
      ),
      confirmationButtomThemColor: Colors.green,
      actionButtomAlignment: MainAxisAlignment.center, // Alignment of actions
      onConfirm: () => print(
        'yeas on confirm call back',
      ), // this is called if default action has been set
      customConfirmationActionButtons: [], // If you wish to add custom action for implementation
    );
  }

  void showActionSheetContainer(BuildContext context) async {
    double maxHeightRatio = 0.85;
    double topBorderRadius = 10.0;
    var response = await AppModalUtil.showActionSheetModal(
      context: context,
      actionSheetContainer: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'action Sheet container',
              style: TextStyle(
                color: Color(0xFF1D2B36),
              ),
            ),
            TextButton(
              onPressed: () => showPopUpConfirmation(context),
              child: const Text('Show Pop Up'),
            )
          ],
        ),
      ),
      maxHeightRatio: maxHeightRatio,
      initialHeightRatio: maxHeightRatio,
      topBorderRadius: topBorderRadius,
    );
    debugPrint('response => $response');
  }

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
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
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.symmetric(
                  vertical: 5.0,
                ),
                child: TextButton(
                  onPressed: () => showPopUpConfirmation(context),
                  child: const Text('Show Pop Up'),
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(
                  vertical: 5.0,
                ),
                child: TextButton(
                  onPressed: () => showActionSheetContainer(context),
                  child: const Text(
                    'Show action Sheet',
                  ),
                ),
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
                  disablePastPeriod: true,
                  allowFuturePeriod: true,
                  minDate: DateTime(2022, 10, 05),
                  // maxDate: DateTime(2022, 10, 27),
                ),
                onInputValueChange: onInputValueChange,
                hiddenInputFieldOptions: const {},
                dataObject: const {},
                mandatoryFieldObject: const {},
                hiddenFields: const {},
              ),
              InputFieldContainer(
                inputField: InputField(
                  id: 'id-coordinate',
                  name: 'location',
                  valueType: 'COORDINATE',
                  disableLocationAutoUpdate: false,
                ),
                onInputValueChange: onInputValueChange,
                hiddenInputFieldOptions: const {},
                dataObject: const {},
                mandatoryFieldObject: const {},
                hiddenFields: const {},
              ),
              Form(
                  key: formKey,
                  child: InputFieldContainer(
                    inputField: InputField(
                        id: 'id-formatted',
                        name: 'name',
                        valueType: 'TEXT',
                        prefixLabel: 'T—',
                        hint: 'XXXX—XXXX—XXX—X'),
                    onInputValueChange: onInputValueChange,
                    hiddenInputFieldOptions: const {},
                    dataObject: const {},
                    mandatoryFieldObject: const {},
                    hiddenFields: const {},
                    validators: [
                      Validators.pattern('[0-9]{4}—[0-9]{4}—[0-9]{2}',
                          'Enter Valid ID number. '),
                    ],
                    inputFormatters: [
                      InputMask(pattern: 'XXXX—XXXX—XXX—X', separator: '—'),
                    ],
                    onError: (err) => {},
                  )),
              ElevatedButton(
                  onPressed: () => formKey.currentState!.validate(),
                  child: const Text("Submit")),
              const SearchInput(
                onSearch: null,
              ),
            ],
          ),
        ));
  }
}
