<h3 align="center">DHIS2 FLUTTER  UI </h3>

---

<p align="center"> This Library support  common components in Dhis2 used in Flutter 
    <br> 
</p>

## Table of Contents

- [About](#about)
- [Project Structure](#structure)
- [Getting Started](#getting_started)
- [Supported Components](#deployment)
- [Usage](#usage)
- [Built Using](#built_using)

## About <a name = "about"></a>

DHIS2 Flutter UI is a library combine different UI experience used to in DHIS2 to deliver solution.It is consists of different form components ,common components and models that support dhis2 api data structure with reference to their metadata.

## <a name='structure'></a>Project Structure

The implementation of this project was based on [**Flutter and Dart**](https://flutter.dev/).

The structure of this project folders is as summarized bellow:

```
|-package
|  |-lib
|      |-dhis2_flutter_ui.dart
|      |-src
|        |-main_directive.dart
|        |-ui
|          |-components
|          |-core
|          |-models
|          |-utils
|
```

### Supported Components

The following are list of supported components and models in the packages.

### i. Input Components

```
list of input components

```

| components                    | props |
| ----------------------------- | ----- |
| SearchInput                   |       |
| RadioInputFieldContainer      |       |
| BooleanInputFieldContainer    |       |
| CheckBoxInputField            |       |
| CoordinateInputFieldContainer |       |
| DateInputFieldContainer       |       |
| InputClearIcon                |       |
| NumericalInputFieldContainer  |       |
| SelectInputField              |       |
| TextInputFieldContainer       |       |
| TrueOnlyInputFieldContainer   |       |
| InputFieldContainer           |       |
| PercentageInputFieldContainer |       |
| TimeInputFieldContainer       |       |
| FormFieldInputIcon            |       |

### ii. Generic Components

```
list of generic components

```

| components            | props |
| --------------------- | ----- |
| CircularProcessLoader |       |
| MaterialCard          |       |
| LineSeparator         |       |

### iii. Models Supported

```
list of models

```

| Models           | props                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     |
| ---------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Application      | String id; String label ; String iconPath; List<String> userGroups;                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| InputField       | String id;String name; String? translatedName;String? description; String? translatedDescription; String valueType; Color? labelColor; Color? inputColor; Color? background; bool? renderAsRadio; bool? isReadOnly; bool? isPasswordField; bool? shouldCapitalize;bool? allowFuturePeriod; bool? showCountryLevelTree; bool? disablePastPeriod; bool? hasError; int? minAgeInYear; int? maxAgeInYear; int? numberOfMonth; bool? shouldUserCustomAgeLimit; String? suffixLabel; String? hint; String? translatedHint; List<InputFieldOption>? options; bool? hasSubInputField; InputField? subInputField; List<int>? allowedSelectedLevels;List<String>? filteredPrograms; |
| InputFieldOption | String name; String? translatedName; dynamic code;                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |

### iv. Utils Supported

```
 List of Utils
```

| Name          | Functions                                          |
| ------------- | -------------------------------------------------- |
| FormValidator | `Validators.pattern('regex','message')`            |
| InputMask     | ` InputMask(pattern:'xxxx-xxx-xxx',separator:'-')` |

## Getting Started <a name = "getting_started"></a>

These instructions will get you a copy of the project up and running on your local machine for development and testing purposes. See [deployment](#deployment) for notes on how to deploy the project on a live system.

```
 git clone <github_repository_url>
```

### How to Deploy

The following are step by step instruction that will help you deploy this package.

### Login into you local environment (terminal)

```
 dart pub login

```

This will create a link to redirect you into supported web browser ,then login through your supported email you have used in <a href="https://pub.dev/"> pubdev</a>

### Dry run to format package before deploy

This will run and check best practice that recommended by pub dev , it will check formats , file structure , required content of pubspec.yalm file , package size and version of the package control.
Use the following command for dry run of your package.

```
 dart pub publish -n

```

or

```
 dart pub publish --dry-run

```

### Publish package

Use the following command to publish package into <a href="https://pub.dev/"> pubdev<a/>

```
 dart pub publish

```

## 🔧 Running the tests <a name = "tests"></a>

Explain how to run the automated tests for this system.

### Break down into end to end tests

Explain what these tests test and why

```
Give an example
```

### And coding style tests

Explain what these tests test and why

```
Give an example
```
