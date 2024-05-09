A design system that's used to allow widget sharing between the different micro services of the
MAERSK E-Fulfilment project.

## Features

This package includes:

- Text styles
- Colors
- Buttons
- Icon Buttons
- Switches
- Dialog Pop-ups
- Bullet Point lists
- Radio Buttons
- Side Overlays
- Tabs
- Snack-bars
- Pager
- Tags
- Input Field
- Data Tables
- List View

## Getting started

To use this in a flutter project add the following dependency to the `pubspec.yaml` file and
run `flutter pub get`.

```yaml
  design_system:
    git:
      url: https://github.com/FEUP-MEIC-DS-2022-1MEIC01/design-system.git
      ref: main
      path: design_system
```

## Usage

1. Import the design system

```dart
import 'package:design_system/design_system.dart';
```

2. Use one of the available widgets

### TextStyles

```dart
TextStyle style = BoxText.displayLarge("Text here");
```

```dart
TextStyle style = BoxText.displayMedium("Text here");
```

```dart
TextStyle style = BoxText.displaySmall("Text here");
```

```dart
TextStyle style = BoxText.headlineLarge("Text here");
```

```dart
TextStyle style = BoxText.headlineMedium("Text here");
```

```dart
TextStyle style = BoxText.headlineSmall("Text here");
```

```dart
TextStyle style = BoxText.titleLarge("Text here");
```

```dart
TextStyle style = BoxText.titleMedium("Text here");
```

```dart
TextStyle style = BoxText.titleSmall("Text here");
```

```dart
TextStyle style = BoxText.labelLarge("Text here");
```

```dart
TextStyle style = BoxText.labelMedium("Text here");
```

```dart
TextStyle style = BoxText.labelSmall("Text here");
```

```dart
TextStyle style = BoxText.bodyLarge("Text here");
```

```dart
TextStyle style = BoxText.bodyMedium("Text here");
```

```dart
TextStyle style = BoxText.bodySmall("Text here");
```
### Colors

```dart

Color color = appPrimaryColor;
```

```dart

Color color = appSecondaryColor;
```

```dart

Color color = appWarning;
```

```dart

Color color = appDarkColor;
```

```dart

Color color = appMediumGreyColor;
```

```dart

Color color = appMediumToLightGreyColor;
```

```dart

Color color = appDisableGrey;
```

```dart

Color color = appLightGreyColor;
```

```dart

Color color = appVeryLightGreyColor;
```

```dart

Color color = appDialogBackgroundColor;
```

```dart

Color color = appFocusColor;
```

### Buttons

#### Primary Button

``` dart
Widget primaryButton = PrimaryButton(
          title: 'Primary Button With Leading',
          width: 300,
          leading: const Icon(
            Icons.exit_to_app,
            color: appVeryLightGreyColor,
          ),
          onPressed: () => {},
        ),
```

#### Secondary Button

``` dart
Widget secondaryButton = SecondaryButton(
          title: 'Secondary Button With Leading',
          width: 300,
          leading: const Icon(
            Icons.exit_to_app,
            color: appVeryLightGreyColor,
          ),
          onPressed: () => {},
        );
```

#### Tertiary Button

``` dart
Widget tertiaryButton = TertiaryButton(
          title: 'Tertiary Button With Leading',
          width: 300,
          leading: const Icon(
            Icons.exit_to_app,
            color: appPrimaryColor,
          ),
          onPressed: () => {},
          disabled: false,
        );
```

#### Ghost Button

``` dart
Widget ghostButton = GhostButton(
          title: 'Ghost Button With Leading',
          width: 300,
          leading: const Icon(
            Icons.exit_to_app,
            color: appDarkColor,
          ),
          onPressed: () => {},
          disabled: false,
        );
```

### Icon Buttons

#### Primary Icon Button

``` dart
Widget primaryIconButton = PrimaryIconButton(
          icon: Icons.add,
          onPressed: () => {},
        );
```

#### Secondary Icon Button

``` dart
Widget secondaryIconButton = SecondaryIconButton(
          icon: Icons.add,
          onPressed: () => {},
        );
```

#### Tertiary Icon Button

``` dart
Widget tertiaryIconButton = TertiaryIconButton(
          icon: Icons.add,
          onPressed: () => {},
        );
```

#### Ghost Icon Button

``` dart
Widget GhostIconButton(
          icon: Icons.add,
          onPressed: () => {},
        );
```

### Switch Button

```dart

Widget switchButton = SwitchButton(
  onChanged: (val) {
    setState(() {
      switch1Selected = val;
    });
  },
  value: switch1Selected,
);
```

### Dialog Pop-up

```dart

Widget dialogPopUp = SecondaryButton(
    width: 200,
    title: 'Show Dialog',
    onPressed: () {
      showDialog(
        context: context,
        builder: (dialogContext) {
          return GenericDialog(
            title: "This is a popup",
            content: const Text(
              "This is an example text\n"
                  "The dialog supports multiple lines\n"
                  "And different actions too!",
              style: bodyStyle,
            ),
            actions: [
              GhostButton(
                width: 90,
                height: 37,
                onPressed: () {
                  Navigator.pop(context);
                },
                title: "Sure",
              ),
              const SizedBox(
                width: 10,
              ),
              SecondaryButton(
                width: 100,
                height: 37,
                onPressed: () {
                  Navigator.pop(context);
                },
                title: "Got it!",
              ),
            ],
          );
        },
      );
    });
```

### Bullet List

```dart

Widget bulletList = BulletList(
  itemPadding: const EdgeInsets.only(bottom: 15),
  items: const [
    Text("This is item list has different paddings"),
    Text("Check it out!")
  ],
)

```

### Radio

```dart

bool radioGroup1 = 0 // variable belonging to a stateful widget

Widget radioButton = RadioButton<int>(
  size: 40,
  onChanged: (val) {
    setState(() {
      radioGroup1 = val;
    });
  },
  value: 0,
  groupValue: radioGroup1,
)
,
```

### Side Overlay

``` dart
PrimaryButton(
            title: 'Open side overlay',
            width: 300,
            onPressed: () => TitledOverlay.showTitledOverlay(
                  context,
                  'Overlay Title',
                  Center(child: BoxText.body('Overlay Content')),
                )),

```

### Tab Bar

```dart

Widget switchButton = DefaultTabController(
  length: myTabs.length,
  child: Scaffold(
    appBar: AppTabBar(
      tabs: myTabs,
    ),
    body: TabBarView(children: [
      content(context),
      const Center(child: BoxText.headingThree("Tab2"))
    ]),
  ),
);
```

### Menu Tab

```dart

int tabSelected = 0;

onPressedTab(idx) {
  setState(() {
    tabSelected = idx;
  });
}

Widget menuTab = MenuTab(
  text: "Tab 2",
  selected: tabSelected == 1,
  onPressed: () => onPressedTab(1),
  right: Padding(
    padding: const EdgeInsets.only(right: 10),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.end,
      mainAxisSize: MainAxisSize.max,
      children: const [
        Icon(Icons.more_vert),
      ],
    ),
  ),
)
,
```

### Snack-bars

#### Loaded

```dart
PrimaryButton
(
width: 200
,
title: '
Loaded snack-bar
'
,
onPressed: () {
ScaffoldMessenger.of(context).hideCurrentSnackBar();
ScaffoldMessenger.of(context).showSnackBar(CustomSnackBarLoaded(context, "Something has finished running!"));
});
```

#### Loading

```dart
PrimaryButton
(
width: 200
,
title: '
Loading snack-bar
'
,
onPressed: () {
ScaffoldMessenger.of(context).hideCurrentSnackBar();
ScaffoldMessenger.of(context).showSnackBar(CustomSnackBarLoading(context));
});
```

#### Information

```dart
PrimaryButton
(
width: 200
,
title: '
Information snack-bar
'
,
onPressed: () {
ScaffoldMessenger.of(context).hideCurrentSnackBar();
ScaffoldMessenger.of(context).showSnackBar(CustomSnackBarInformation(context, "This is some information!"));
});
```

#### Error

```dart
PrimaryButton
(
width: 200
,
title: '
Error snack-bar
'
,
onPressed: () {
ScaffoldMessenger.of(context).hideCurrentSnackBar();
ScaffoldMessenger.of(context).showSnackBar(CustomSnackBarError(context, "This is an error!"));
});
```

### Tag

```dart

Widget tag = Tag(text: "Cancelled", backgroundColor: cancelledPo, textColor: appDarkColor); 
```

### Pager

```dart

int _selectedPage = 1; // variable belonging to a stateful widget

return Pager
(
onPageChanged: (
idx) {
setState(() {
_selectedPage = idx;
});
},
totalPages: 25
,
numberOfVisiblePages: 8
,
);
```

### Menu Tab

```dart

int tabSelected = 0;

onPressedTab(idx) {
  setState(() {
    tabSelected = idx;
  });
}

Widget menuTab = MenuTab(
  text: "Tab 2",
  selected: tabSelected == 1,
  onPressed: () => onPressedTab(1),
  right: Padding(
    padding: const EdgeInsets.only(right: 10),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.end,
      mainAxisSize: MainAxisSize.max,
      children: const [
        Icon(Icons.more_vert),
      ],
    ),
  ),
)
,
```


### List View

```dart

ColorCaption colorCaption = ColorCaption(statusColors);

Wiget list = ListView.builder(
    itemCount: itemCount + 1,
    itemBuilder: (context, index) {
      if (index == 0) return colorCaption;
      return SmallCard(
          textFlexParam: 2,
          barColor: (index % 2 == 0) ? appPrimaryColor : appWarning,
          onTap: () => {},
          textContent: const ['It has a title', 'And some content'],
          widgetContent: const [
            Chip(
              label: Text('Label'),
            ),
            Icon(
              Icons.exit_to_app,
              color: appVeryLightGreyColor,
            )
          ]);
    }); 
```
### Dropdown

```dart
Widget dropdownButton = const AppDropdownButton<String>(
    width: 300,
    required: true,
    hintText: "Select option",
    items: ["First", "Second", "Third"]);
```
### Data Table

```dart
AppDataTable(onRowTap: (idx) => {}, columnNames: const [
      "Name",
      "Description",
      "Seller"
    ], rows: const [
      [Text("Trainers"), Text("A nice product indeed")],
      [
        Text("Trousers"),
        Text("Warm for the winter"),
        Text("Levi's"),
        Text("Ignored text (no column)"),
        // there can be any type of widget here, including action buttons
      ]
    ]);
```


### Input Fields

```dart

Widget inputField = FormInputField(
    textDescription: "Description",
    name: "name",
    label: "Label",
    hint: "I am a hint",
    validators: [
      FormBuilderValidators.required(
          errorText: "This field is required")
    ],
    icon: editIcon);
```