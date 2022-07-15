
<h3 align="center">DHIS2 FLUTTER  UI </h3>



---

<p align="center"> This Library support  common components in Dhis2 used in Flutter 
    <br> 
</p>

##  Table of Contents

- [About](#about)
- [Getting Started](#getting_started)
- [Supported Components](#deployment)

##  About <a name = "about"></a>

DHIS2 Flutter UI is a library combine different UI experience used to in DHIS2 to deliver solution.It is consists of different form components ,common components and models that support dhis2 api data structure with reference to their metadata.


### Supported Components

The following are list of supported components and models in the packages.
### i. Input Components

```
list of input components 

```
| components  |  props |
|---|---|
|  SearchInput |   |
|  RadioInputFieldContainer |   |
|  BooleanInputFieldContainer |   |
|  CheckBoxInputField |   |
|  CoordinateInputFieldContainer |   |
|  DateInputFieldContainer |   |
|  InputClearIcon |   |
|  NumericalInputFieldContainer |   |
|  SelectInputField |   |
|  TextInputFieldContainer |  |
|  TrueOnlyInputFieldContainer |   |
|  InputFieldContainer |   |
|  PercentageInputFieldContainer |   |
|  TimeInputFieldContainer |   |
|  FormFieldInputIcon |   |
### ii. Generic Components

```
list of generic components 

```
| components  |  props |
|---|---|
|  CircularProcessLoader |   |
|  MaterialCard |   |
|  LineSeparator |   |
|  CustomButton |   |
### iii. Models Supported

```
list of models  

```
| Models  |  props |
|---|---|
|  Application |    String id; String label ; String iconPath; List<String> userGroups;
  Dhis2Option |  String? id;String? name;String? code; String? optionSet;  int? sortOrder;
|  DataElement | String? id;  String? valueType;  String? optionSet;  List<Dhis2Option>? options;|
|  Dhis2EventDataValue |  String? id;  String? event; String? dataElement;String? value;  |
|  InputField |   String id;String name; String? translatedName;String? description; String? translatedDescription;  String valueType;  Color? labelColor;  Color? inputColor; Color? background;  bool? renderAsRadio;  bool? isReadOnly;  bool? isPasswordField;  bool? shouldCapitalize;bool? allowFuturePeriod;  bool? showCountryLevelTree;  bool? disablePastPeriod;  bool? hasError;  int? minAgeInYear;  int? maxAgeInYear;  int? numberOfMonth;  bool? shouldUserCustomAgeLimit; String? suffixLabel;  String? hint;  String? translatedHint;  List<InputFieldOption>? options;  bool? hasSubInputField;  InputField? subInputField;  List<int>? allowedSelectedLevels;List<String>? filteredPrograms;|
 |  InputFieldOption |     String name; String? translatedName; dynamic code;|
|  Dhis2Event |   String? id;  String? event;  String? eventDate;  String? orgUnit;  String? program;  String? programStage;  String? storedBy;  String? completedDate;  String? status;  String? syncStatus;List<Dhis2EventDataValue>? dataValues; |   
 |  MetadataSyncItem |   String? id;  String? name; String? progressPercentage;  bool? isDefault; bool? isCompleted; List<MetadataSyncItem>? subItems;|
 |  OrganisationUnit |  String? id;  String? name;  String? parent;  String? code;  String? path;  int? level;List<String>? dataSets; List<String>? programs;  List<String>? children;|
 |  ProgramIndicator |   String? id; String? aggregationType;  String? expression;  String? filter;  String? program;|
|  ProgramRuleAction |  String? id;  String? programRule;  String? data;  String? content;  String? programRuleActionType;  String? location;  String? dataElement;  String? trackedEntityAttribute;String? programStageSection; String? programStage;|
|  ProgramRule |   String? id; String? condition; String? program;  List<ProgramRuleAction>? programRuleActions;  |
|  ProgramRuleVariable  |   String? id;   String? name;  String? programRuleVariableSourceType; String? program;  String? dataElement;  String? trackedEntityAttribute; String? programStageSection;String? programStage; |
| SystemInfo |   String? contextPath;  String? systemId;  String? systemName;  String? userAgent;  String? calendar;  String? dateFormat;  String? lastAnalyticsTableSuccess;  String? lastAnalyticsTableRuntime;  String? revision;  String? jasperReportsVersion;  String? environmentVariable;  String? fileStoreProvider;  String? readOnlyMode;  String? javaVersion;  String? osName;  String? osArchitecture;  String? osVersion; String? memoryInfo;  String? cpuCores; |

### iv. Utils Supported
```
 List of Utils
```

Name | Functions |
|--|--|
FormValidator | ``Validators.pattern('regex','message')``
InputMask | `` InputMask(pattern:'xxxx-xxx-xxx',separator:'-')``

##  Getting Started <a name = "getting_started"></a>

These instructions will get you a copy of the project up and running on your local machine for development and testing purposes. See [deployment](#deployment) for notes on how to deploy the project on a live system.

```
 git clone <github_repository_url>
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

