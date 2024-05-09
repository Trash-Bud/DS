//ignore_for_file: depend_on_referenced_packages
import 'package:flutter/material.dart';
import 'package:design_system/design_system.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Widget Test',
      home: MyHomePage(title: 'Widget Test'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool switch1Selected = true;
  bool switch2Selected = false;
  bool switch3Selected = false;

  int radioGroup1 = 0;
  int radioGroup2 = 0;

  final List<Tab> myTabs = <Tab>[
    const Tab(
      icon: Icon(Icons.slideshow),
      text: "Demo",
    ),
    const Tab(icon: Icon(Icons.question_mark), text: "Test Tab"),
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: myTabs.length,
      child: Scaffold(
        appBar: AppTabBar(
          tabs: myTabs,
        ),
        body: TabBarView(children: [
          content(context),
          Center(child: BoxText.headlineLarge("Tab2"))
        ]),
      ),
    );
  }

  Widget content(BuildContext context) {
    return SingleChildScrollView(
        child: Container(
      margin: const EdgeInsets.all(15),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        ..._buildSection("Buttons", _getButtons()),
        ..._buildSection("Icon Buttons", _getIconButtons()),
        ..._buildSection("Switches", _getSwitches()),
        ..._buildSection("Radio", _getRadio()),
        ..._buildSection("Side Overlay", _getSideOverlay()),
        ..._buildSection("Bullet List", _getBulletList()),
        ..._buildSection("Popup Dialog", _getDialog()),
        ..._buildSection("Dropdown Button", _getDropdownButton()),
        ..._buildSection("Snack-bars", _getSnackBar()),
        ..._buildSection("Pager", _getPager()),
        ..._buildSection("Tag", _getTags()),
        ..._buildSection("Menu Tabs", _getMenuTabs()),
        ..._buildSection("Data Table", _getDataTable()),
        ..._buildSection("List View", _getListView()),
        ..._buildSection("Form input fields", _getFormFields()),
      ]),
    ));
  }

  List<Widget> _buildSection(title, content) {
    return [
      BoxText.headlineSmall(title),
      const SizedBox(
        height: 20,
      ),
      content
    ];
  }

  getGhostButtons() {
    return Column(
      children: [
        GhostButton(
          title: 'Ghost Button',
          onPressed: () => {},
        ),
        const SizedBox(height: 15),
        const GhostButton(
          title: 'Ghost Button Disabled',
          disabled: true,
        ),
        const SizedBox(height: 15),
        GhostButton(
          title: 'Ghost Button With Leading',
          leading: const Icon(
            Icons.exit_to_app,
            color: appDarkColor,
          ),
          onPressed: () => {},
          disabled: false,
        ),
        const SizedBox(height: 15),
        const GhostButton(
          title: 'Ghost Button With Leading',
          leading: Icon(
            Icons.exit_to_app,
            color: appDisableGrey,
          ),
          disabled: true,
        ),
        const SizedBox(height: 15),
      ],
    );
  }

  _getIconButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        PrimaryIconButton(
          icon: Icons.add,
          onPressed: () => {},
        ),
        const SizedBox(height: 15),
        PrimaryIconButton(
          icon: Icons.add,
          disabled: true,
          onPressed: () => {},
        ),
        const SizedBox(height: 15),
        SecondaryIconButton(
          icon: Icons.add,
          onPressed: () => {},
        ),
        const SizedBox(height: 15),
        SecondaryIconButton(
          icon: Icons.add,
          disabled: true,
          onPressed: () => {},
        ),
        const SizedBox(height: 15),
        TertiaryIconButton(
          icon: Icons.add,
          onPressed: () => {},
        ),
        const SizedBox(height: 15),
        TertiaryIconButton(
          icon: Icons.add,
          disabled: true,
          onPressed: () => {},
        ),
        const SizedBox(height: 15),
        GhostIconButton(
          icon: Icons.add,
          onPressed: () => {},
        ),
        const SizedBox(height: 15),
        GhostIconButton(
          icon: Icons.add,
          disabled: true,
          onPressed: () => {},
        ),
        const SizedBox(height: 15),
      ],
    );
  }

  getTertiaryButtons() {
    return Column(
      children: [
        TertiaryButton(
          title: 'Tertiary Button',
          onPressed: () => {},
        ),
        const SizedBox(height: 15),
        TertiaryButton(
          title: 'Tertiary Button Warning',
          onPressed: () => {},
          color: appWarning,
        ),
        const SizedBox(height: 15),
        const TertiaryButton(
          title: 'Tertiary Button Disabled',
          disabled: true,
        ),
        const SizedBox(height: 15),
        TertiaryButton(
          title: 'Tertiary Button With Leading',
          leading: const Icon(
            Icons.exit_to_app,
            color: appPrimaryColor,
          ),
          onPressed: () => {},
          disabled: false,
        ),
        const SizedBox(height: 15),
        const TertiaryButton(
          title: 'Tertiary Button With Leading',
          leading: Icon(
            Icons.exit_to_app,
            color: appDisableGrey,
          ),
          disabled: true,
        ),
        const SizedBox(height: 15),
      ],
    );
  }

  getSecondaryButtons() {
    return Column(
      children: [
        SecondaryButton.defaultSize(
          title: 'Secondary Button',
          onPressed: () => {},
        ),
        const SizedBox(height: 15),
        const SecondaryButton.defaultSize(
          title: 'Secondary Button Disabled',
          disabled: true,
        ),
        const SizedBox(height: 15),
        SecondaryButton.defaultSize(
          title: 'Secondary Button With Leading',
          leading: const Icon(
            Icons.exit_to_app,
            color: appVeryLightGreyColor,
          ),
          onPressed: () => {},
        ),
        const SizedBox(height: 15),
        const SecondaryButton.defaultSize(
          title: 'Secondary Button With Leading',
          leading: Icon(
            Icons.exit_to_app,
            color: appVeryLightGreyColor,
          ),
          disabled: true,
        ),
        const SizedBox(height: 15),
      ],
    );
  }

  getPrimaryButtons() {
    return Column(
      children: [
        PrimaryButton.defaultSize(
          title: 'Primary Buttonaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa',
          onPressed: () => {},
        ),
        const SizedBox(height: 15),
        const PrimaryButton.defaultSize(
          title: 'Primary Button Disabled',
          disabled: true,
        ),
        const SizedBox(height: 15),
        PrimaryButton.defaultSize(
          title: 'Primary Button With Leading',
          leading: const Icon(
            Icons.exit_to_app,
            color: appVeryLightGreyColor,
          ),
          onPressed: () => {},
        ),
        const SizedBox(height: 15),
        const PrimaryButton.defaultSize(
          title: 'Primary Button With Leading',
          leading: Icon(
            Icons.exit_to_app,
            color: appVeryLightGreyColor,
          ),
          disabled: true,
        ),
        const SizedBox(height: 15),
      ],
    );
  }

  _getDialog() {
    return Align(
      child: SecondaryButton.defaultSize(
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
                    style: bodyMediumStyle,
                  ),
                  actions: [
                    GhostButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      title: "Sure",
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    SecondaryButton.defaultSize(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      title: "Got it!",
                    ),
                  ],
                );
              },
            );
          }),
    );
  }

  _getSnackBar() {
    return Column(children: [
      Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
        PrimaryButton.defaultSize(
            title: 'Loading snack-bar',
            onPressed: () {
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
              ScaffoldMessenger.of(context)
                  .showSnackBar(CustomSnackBarLoading(context));
            }),
        PrimaryButton.defaultSize(
            title: 'Error snack-bar',
            onPressed: () {
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
              ScaffoldMessenger.of(context).showSnackBar(
                  CustomSnackBarError(context, "This is an error!"));
            }),
        PrimaryButton.defaultSize(
            title: 'Information snack-bar',
            onPressed: () {
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
              ScaffoldMessenger.of(context).showSnackBar(
                  CustomSnackBarInformation(
                      context, "This is some information!"));
            }),
        PrimaryButton.defaultSize(
            title: 'Loaded snack-bar',
            onPressed: () {
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
              ScaffoldMessenger.of(context).showSnackBar(CustomSnackBarLoaded(
                  context, "Something has finished running!"));
            }),
      ]),
      const SizedBox(height: 50)
    ]);
  }

  _getBulletList() {
    return Column(
      children: [
        BulletList(
          bulletPadding: const EdgeInsets.only(right: 5),
          itemPadding: const EdgeInsets.only(bottom: 5),
          items: const [Text("This is an item"), Text("This is another item")],
        ),
        const SizedBox(
          height: 20,
        ),
        BulletList(
          itemPadding: const EdgeInsets.only(bottom: 15),
          items: const [
            Text("This is item list has different paddings"),
            Text("Check it out!")
          ],
        )
      ],
    );
  }

  _getButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        getPrimaryButtons(),
        getSecondaryButtons(),
        getTertiaryButtons(),
        getGhostButtons()
      ],
    );
  }

  _getSwitches() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        SwitchButton(
          onChanged: (val) {
            setState(() {
              switch1Selected = val;
            });
          },
          value: switch1Selected,
        ),
        SwitchButton(
          onChanged: (val) {
            setState(() {
              switch2Selected = val;
            });
          },
          value: switch2Selected,
        ),
        SwitchButton(
          onChanged: (val) {},
          value: switch3Selected,
          disabled: true,
        )
      ],
    );
  }

  _getRadio() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            RadioButton(
              size: 40,
              onChanged: (val) {
                setState(() {
                  radioGroup1 = val;
                });
              },
              value: 0,
              groupValue: radioGroup1,
            ),
            RadioButton(
              size: 40,
              onChanged: (val) {
                setState(() {
                  radioGroup1 = val;
                });
              },
              groupValue: radioGroup1,
              value: 1,
            ),
            RadioButton(
              size: 40,
              onChanged: (val) {
                setState(() {
                  radioGroup1 = val;
                });
              },
              groupValue: radioGroup1,
              value: 2,
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            RadioButton(
              size: 40,
              onChanged: (val) {},
              value: 0,
              groupValue: radioGroup2,
              disabled: true,
            ),
            RadioButton(
              size: 40,
              onChanged: (val) {},
              value: 1,
              groupValue: radioGroup2,
              disabled: true,
            ),
          ],
        ),
      ],
    );
  }

  _getSideOverlay() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        PrimaryButton.defaultSize(
            title: 'Open side overlay',
            onPressed: () => TitledOverlay.showTitledOverlay(
                  context,
                  'Overlay Title',
                  Center(child: BoxText.bodyMedium('Overlay Content')),
                )),
      ],
    );
  }

  _getDropdownButton() {
    return const AppDropdownButton<String>(
        width: 300,
        required: true,
        hintText: "Select option",
        items: ["First", "Second", "Third"]);
  }

  int tabSelected = 0;

  onPressedTab(idx) {
    setState(() {
      tabSelected = idx;
    });
  }

  _getMenuTabs() {
    return Row(
      children: [
        SizedBox(
          width: 500,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              MenuTab(
                text: "Tab 1",
                selected: tabSelected == 0,
                onPressed: () => onPressedTab(0),
              ),
              MenuTab(
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
              ),
              MenuTab(
                text: "Tab 3",
                selected: tabSelected == 2,
                onPressed: () => onPressedTab(2),
                fontStyle: titleLargeStyle,
                right: Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Container(
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                          color: appWarning,
                        ),
                        child: const SizedBox(
                          width: 80,
                          height: 20,
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      const Icon(Icons.more_vert),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        Expanded(child: Container()),
      ],
    );
  }

  _getFormFields() {
    return SizedBox(
        width: 300,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              FormInputField(
                  textDescription: "Description",
                  name: "name",
                  keyboardType: TextInputType.number,
                  label: "Label",
                  hint: "I am a hint",
                  labelStyle: const TextStyle(color: appDarkColor),
                  descriptionStyle: const TextStyle(fontSize: 12),
                  validators: [
                    FormBuilderValidators.required(
                        errorText: "This field is required")
                  ],
                  icon: editIcon),
            ]));
  }

  _getPager() {
    return Row(children: [
      Expanded(
          child: Pager(
        onPageChanged: (idx) {},
        totalPages: 25,
        numberOfVisiblePages: 8,
      ))
    ]);
  }

  _getTags() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: const [
        Tag(text: "Cancelled", backgroundColor: cancelledPo),
        Tag(text: "Archived", backgroundColor: archivedPo),
        Tag(text: "Open", backgroundColor: openPo),
        Tag(text: "In Progress", backgroundColor: inProgressPo),
        Tag(text: "Unknown", backgroundColor: unknownStatus),
        Tag(
            text: "B-O-W",
            backgroundColor: Colors.white,
            textColor: appDarkColor),
        Tag(text: "Default")
      ],
    );
  }

  _getDataTable() {
    return SizedBox(
        height:
            300, // height is needed since it is a Column inside a ScrollView
        child: AppDataTable(
          onRowTap: (idx) => {},
          columnNames: const ["Name", "Description", "Seller"],
          rows: const [
            [Text("Trainers"), Text("A nice product indeed")],
            [
              Text("Trousers"),
              Text("Warm for the winter"),
              Text("Levi's"),
              Text("Ignored text (no column)"),
            ]
          ],
          headerRowMinHeight: 40,
          dataRowMinHeight: 80,
        ));
  }

  _getListView() {
    int itemCount = 2;


    Map<String, Color> statusColors = {
      'Cool': appPrimaryColor,
      'Lovely': appPrimaryColor,
      'Bad': appWarning,
    };

    ColorCaption colorCaption = ColorCaption(statusColors);

    return SizedBox(
        height: 300,
        width: 300,
        child: ListView.builder(
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
            }));
  }
}
