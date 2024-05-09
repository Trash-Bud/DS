import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:frontend/controller/provider/purchase_order_change_notifier.dart';
import 'package:provider/provider.dart';
import 'package:frontend/utils/theme.dart';
import 'package:frontend/view/widgets/create_overlay/create_po_form.dart';

// TODO: turned into a stateful in order to remove the const and update when resize
//  Is there a better way to do this?

const Map<String, String> poStateItems = {
  "PO State": "", // default value
  "Open": "Open",
  "In Progress": "InProgress",
  "Archived": "Archived",
  "Cancelled": "Cancelled"
};

class PoNavBar extends StatefulWidget {
  const PoNavBar({super.key});

  @override
  State<StatefulWidget> createState() {
    return _PoNavBarState();
  }
}

class _PoNavBarState extends State<PoNavBar> {
  void _fetchPos() {
    final poContext =
        Provider.of<PurchaseOrderChangeNotifier>(context, listen: false);
    poContext.fetchPurchaseOrders();
  }

  @override
  Widget build(BuildContext context) {
    bool smallScreen = isSmallScreen(context); // width perspective

    List<Widget> children = [];
    children.add((smallScreen) ? getSmallHeader(context) : getHeader(context));
    children.add(getSearchBar(context, smallScreen));
    children.add(getCreatePoButton(context, smallScreen));

    return Container(
      //TODO: change to wrap and define orientation from small screen
      margin: const EdgeInsets.only(left: 15, right: 15, top: 10),
      height: 100,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [...children],
      ),
    );
  }

  getSmallHeader(BuildContext context) {
    return Flexible(
        child: InkWell(
      onTap: _fetchPos,
      child: Text(
        "POs",
        style: Theme.of(context).textTheme.headlineSmall,
      ),
    )
    );
  }

  getHeader(context) {
    return Expanded(
      flex: 3,
      child: InkWell(
        onTap: _fetchPos,
        child: Text(
          "Inbound Purchase Orders",
          style: Theme.of(context).textTheme.headline4,
        ),
      ), 
    );
  }


  getSearchBar(context, bool smallScreen) {
    return Flexible(
        flex: (smallScreen) ? 3 : 2,
        child: FractionallySizedBox(
          widthFactor: 0.8,
          heightFactor: (smallScreen) ? 0.4 : 0.6,
          child: PoSearchAndFilter(smallScreen: smallScreen,),
        ));
  }

  getCreatePoButton(BuildContext context, bool smallScreen) {
    return Flexible(
      flex: 1,
      child: FractionallySizedBox(
          heightFactor: smallScreen ? 0.4 : 0.6,
          // widthFactor: smallScreen ? 0.5 : 0.8,
          child: CreatePoButton(smallScreen)),
    );
  }
}

class CreatePoButton extends StatelessWidget {
  final bool smallScreen;

  const CreatePoButton(this.smallScreen, {super.key});

  @override
  Widget build(BuildContext context) {

    void onPressed() => TitledOverlay.showTitledOverlay(
        context,
        "Create Purchase Order",
        const PoForm()
    );

    // if small screen, show square button with +
    // if large screen, show button with text
    return (smallScreen)
        ? PrimaryIconButton(icon: Icons.add, onPressed: onPressed,)
        : PrimaryButton(title: "Create PO", onPressed: onPressed);

  }
}

class PoSearchAndFilter extends StatefulWidget {
  final bool smallScreen;

  const PoSearchAndFilter({super.key, required this.smallScreen});

  Future<void> _handleSearch(String inputText, String poState, context) async {
    final poContext = Provider.of<PurchaseOrderChangeNotifier>(context, listen: false);
    await poContext.fetchPurchaseOrders(textQuery: inputText, poState: poState);

  }

  @override
  PoSearchAndFilterState createState() => PoSearchAndFilterState();
}

class PoSearchAndFilterState extends State<PoSearchAndFilter> {
  late TextEditingController _searchController;
  String? _poStateValue = "";

  @override
  void initState() {
    super.initState();

    // get last query text and poState filter
    final poContext = Provider.of<PurchaseOrderChangeNotifier>(context, listen: false);
    _searchController = TextEditingController(text: poContext.searchQuery);
    _poStateValue = poContext.poStateFilter;
  }

  void _onDropdownChange(String? newValue) {
    setState(() {
      _poStateValue =  newValue == "All" ? "" : newValue ;
    });
    widget._handleSearch(_searchController.text, (newValue == "All" ? "" : newValue)  ?? "", context);
  }

  void _onSearchSubmit(String value) {
    widget._handleSearch(value, _poStateValue ?? "", context);
  }

  dropDownOptions(){
    return poStateItems.entries
        .map((MapEntry<String, String> dictEntry) {
      if (dictEntry.value == "" && _poStateValue != "") {
        return "All";
      }
      return dictEntry.value;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> children = [];
    // TODO: Create separate widgets for this components
    if (!widget.smallScreen) {
      children.add(Container(
        margin: const EdgeInsets.only(right: 40),
        child: DropdownButton(
          key: const Key("poStateDropdown"),
          value: _poStateValue,
          icon: const Icon(Icons.arrow_drop_down, color: appPrimaryColor),
          underline: Container( height: 2, color: appPrimaryColor,),
          items: poStateItems.entries
              .map((MapEntry<String, String> dictEntry) {
            String currText = dictEntry.key;
            if (dictEntry.value == "" && _poStateValue != "") {
              currText = "All";
            }
            return DropdownMenuItem(
              value: dictEntry.value,
              child: Text(currText),
            );
          }).toList(),
          onChanged: _onDropdownChange,
          alignment: Alignment.center,
        ),

      ));
    }


    children.add(Expanded(
      child: TextField(
        decoration: InputDecoration(
          labelText: 'Search',
          hintText:
              (widget.smallScreen) ? null : 'e.g. PO#2020-1234 or Azelland',
          hintStyle: Theme.of(context).textTheme.bodyText1,
          prefixIcon: const Icon(Icons.search),
          labelStyle: Theme.of(context).textTheme.bodyText1,
          border: OutlineInputBorder(
            gapPadding: 0,
            borderSide: const BorderSide(color: Colors.grey),
            borderRadius: BorderRadius.circular(25.0),
          ),
          focusColor: Colors.blue,
          iconColor: Colors.blue,
        ),
        controller: _searchController,
        onSubmitted: _onSearchSubmit,
      ),
    ));

    return Row(mainAxisAlignment: MainAxisAlignment.center, children: children);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}
